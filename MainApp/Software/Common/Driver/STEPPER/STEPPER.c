#include "Extern.h"
 #include "STEPPERS_Cfg.h"
 #include "HWI_STEPPER.h"
 #include "HWI_DIGITAL.h"
#include "Alloc.h"
 #include "STEPPER.h"

 #define STOP_VALUE 0xF
 #define START_VALUE 0x9

 unsigned char STEPPER_SEQUENCE[(MAX_NB_STEPPERS)];
 signed short STEPPER_ANGLE[MAX_NB_STEPPERS];
 unsigned short STEPPER_MOVE_TIME[MAX_NB_STEPPERS];
 unsigned char STEPPER_INDEX[MAX_NB_STEPPERS];
 const STEPPER_CONFIG STEPPER_CONFIGS[MAX_NB_STEPPERS] = STEPPER_CONFIG_ARRAY;
 STEPPER_SM STEPPER_STATE[MAX_NB_STEPPERS];
 
  void SEQUENCE_CW(unsigned char MotorId)
 {
  STEPPER_SEQUENCE[MotorId] =
      0xF & ((STEPPER_SEQUENCE[MotorId] << 1)|(STEPPER_SEQUENCE[MotorId] >> 3));
  HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
 }


 void SEQUENCE_CCW(unsigned char MotorId)
 {
  STEPPER_SEQUENCE[MotorId] =
     0x0F & ((STEPPER_SEQUENCE[MotorId] >> 1)|(STEPPER_SEQUENCE[MotorId] << 3));
  HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
 }

 void SEQUENCE_STOP(unsigned char MotorId)
 {
  HWI_STEPPER_WRITE(MotorId,STOP_VALUE);
 }
 
 

PUBLIC void STEPPER_INITIALIZE(void)
{
   memset(STEPPER_SEQUENCE, START_VALUE, MAX_NB_STEPPERS*sizeof(unsigned char));
   memset(STEPPER_ANGLE, 0 , MAX_NB_STEPPERS * sizeof (signed short));
   memset(STEPPER_STATE, STP_STOPPED , MAX_NB_STEPPERS * sizeof(STEPPER_SM));
   memset(STEPPER_INDEX, 0, MAX_NB_STEPPERS * sizeof(unsigned char));
   memset(STEPPER_MOVE_TIME, 0, MAX_NB_STEPPERS * sizeof(STEPPER_CONFIG));
}

PUBLIC void STEPPER_MANAGE(unsigned char MotorId)
{
 switch(STEPPER_STATE[MotorId])
 {
   case STP_STALL_MIN:
    {
     if(STEPPER_MOVE_TIME[MotorId] != 0)
     {
      SEQUENCE_CCW(MotorId);
      STEPPER_MOVE_TIME[MotorId] --;
     }
     else
     {
      STEPPER_STATE[MotorId] = STP_STOPPED;
     }
     break;
    }
   case STP_STALL_MAX:
    {
     if(STEPPER_MOVE_TIME[MotorId] != 0)
     {
      SEQUENCE_CW(MotorId);
      STEPPER_MOVE_TIME[MotorId] --;
     }
     else
     {
      STEPPER_STATE[MotorId] = STP_STOPPED;
     }
     break;
    }
   case STP_MOVING_CW:
    {
     SEQUENCE_CW(MotorId);
     STEPPER_INDEX[MotorId] ++;
     if(STEPPER_INDEX[MotorId] == STEPPER_CONFIGS[MotorId].STEP_PER_ANGLE)
     {
      STEPPER_INDEX[MotorId] = 0;
      if(STEPPER_ANGLE[MotorId] > 0)
      {
       STEPPER_ANGLE[MotorId] --;
      }
      else if(STEPPER_ANGLE[MotorId] < 0)
      {
       STEPPER_STATE[MotorId] = STP_MOVING_CCW;
      }
      else
      {
       STEPPER_STATE[MotorId] = STP_STOPPED;
      }
     }
     break;
    }
   case STP_MOVING_CCW:
    {
     SEQUENCE_CCW(MotorId);
     STEPPER_INDEX[MotorId] ++;
     if(STEPPER_INDEX[MotorId] == STEPPER_CONFIGS[MotorId].STEP_PER_ANGLE)
     {
      STEPPER_INDEX[MotorId] = 0;
      if(STEPPER_ANGLE[MotorId] > 0)
      {
       STEPPER_STATE[MotorId] = STP_MOVING_CW;
      }
      else if(STEPPER_ANGLE[MotorId] < 0)
      {
       STEPPER_ANGLE[MotorId] ++;
      }
      else
      {
       STEPPER_STATE[MotorId] = STP_STOPPED;
      }
     }
     break;
    }
   case STP_STOPPED:
    {
     SEQUENCE_STOP(MotorId);
     if(STEPPER_ANGLE[MotorId] > 0)
     {
      STEPPER_STATE[MotorId] = STP_MOVING_CW;
      
     }
     else if(STEPPER_ANGLE[MotorId] < 0)
     {
      STEPPER_STATE[MotorId] = STP_MOVING_CCW;
     }
     break;
    }
   default:
    {
     STEPPER_STATE[MotorId] = STP_STOPPED;
     break;
    }
   
 }
 
}

PUBLIC void STEPPER_STOP_MOVEMENT(unsigned char MotorId)
{
 STEPPER_STATE[MotorId] = STP_STOPPED;
 STEPPER_ANGLE[MotorId] = 0;
}

PUBLIC void STEPPER_STALL(unsigned char MotorId,unsigned char direction)
{
 if(STEPPER_MOVE_TIME[MotorId] == 0 )
 {
  STEPPER_MOVE_TIME[MotorId] = STEPPER_CONFIGS[MotorId].MOVE_TIME;
  if(direction == 0)
  {
   STEPPER_STATE[MotorId] = STP_STALL_MIN;
  }
  else
  {
   STEPPER_STATE[MotorId] = STP_STALL_MAX;
  }
 }
}

PUBLIC void STEPPER_MOVE_ANGLE(unsigned char MotorId,signed short s16Angle)
{
 STEPPER_ANGLE[MotorId] += s16Angle ;
}
PUBLIC signed short STEPPER_GET_ANGLE(unsigned char MotorId)
{
 return(STEPPER_ANGLE[MotorId]);
}

PUBLIC unsigned char STEPPER_STATUS(unsigned char MotorId)
{
 unsigned char bIS_END_MOVE = 0;
 
 if (STEPPER_ANGLE[MotorId] == 0)
 {
  bIS_END_MOVE |=  END_MOVEMENT;
 }
 else
 {
  bIS_END_MOVE |= MOVING;
 }
 if(HWI_DIGI_READ(STEPPER_CONFIGS[MotorId].PIN_ID) == END_STOP_VALUE)
 {
  bIS_END_MOVE |= REACH_END_STOP;
 }
 if(STEPPER_MOVE_TIME[MotorId] == 0)
 {
  bIS_END_MOVE |= TIME_OUT;
 }

 return bIS_END_MOVE;
}