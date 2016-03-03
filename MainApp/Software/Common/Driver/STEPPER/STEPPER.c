#include "Extern.h"
 #include "HWI_STEPPER.h"
 #include "HWI_DIGITAL.h"
#include "Alloc.h"
 #include "STEPPER.h"

 #define STOP_VALUE 0xF
 #define START_VALUE 0x9

#ifdef STEPPER_FAST_MOTOR
 unsigned char STEPPER_FLAGS[MAX_NB_STEPPERS]; /* 0 =stopped , 1 = CW ,2 = CCW */
 #endif
 unsigned char STEPPER_SEQUENCE[(MAX_NB_STEPPERS)];
 signed long STEPPER_ANGLE[MAX_NB_STEPPERS];
 unsigned short STEPPER_MOVE_TIME[MAX_NB_STEPPERS];
 unsigned char STEPPER_INDEX[MAX_NB_STEPPERS];
 const STEPPER_CONFIG STEPPER_CONFIGS[MAX_NB_STEPPERS] = STEPPER_CONFIG_ARRAY;
 STEPPER_SM STEPPER_STATE[MAX_NB_STEPPERS];
 
  void SEQUENCE_CW(unsigned char MotorId)
 {
  #ifdef STEPPER_FAST_MOTOR
  STEPPER_FLAGS[MotorId] = 1;
  #else
  STEPPER_SEQUENCE[MotorId] =
      0xF & ((STEPPER_SEQUENCE[MotorId] << 1)|(STEPPER_SEQUENCE[MotorId] >> 3));
  HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
  #endif
 }


 void SEQUENCE_CCW(unsigned char MotorId)
 {
  #ifdef STEPPER_FAST_MOTOR
  STEPPER_FLAGS[MotorId] = 2;
  #else
  STEPPER_SEQUENCE[MotorId] =
     0x0F & ((STEPPER_SEQUENCE[MotorId] >> 1)|(STEPPER_SEQUENCE[MotorId] << 3));
  HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
  #endif
 }

 void SEQUENCE_STOP(unsigned char MotorId)
 {
  #ifdef STEPPER_FAST_MOTOR
  STEPPER_FLAGS[MotorId] = 0;
  #else
  HWI_STEPPER_WRITE(MotorId,STOP_VALUE);
  #endif
 }
 
 

PUBLIC void STEPPER_INITIALIZE(void)
{
   memset(STEPPER_SEQUENCE, START_VALUE, MAX_NB_STEPPERS*sizeof(unsigned char));
   memset(STEPPER_ANGLE, 0 , MAX_NB_STEPPERS * sizeof (signed long));
   memset(STEPPER_STATE, STP_STOPPED , MAX_NB_STEPPERS * sizeof(STEPPER_SM));
   memset(STEPPER_INDEX, 0, MAX_NB_STEPPERS * sizeof(unsigned char));
   memset(STEPPER_MOVE_TIME, 0, MAX_NB_STEPPERS * sizeof(STEPPER_CONFIG));
   #ifdef STEPPER_FAST_MOTOR
   memset(STEPPER_FLAGS, 0 , MAX_NB_STEPPERS * sizeof(unsigned char));
   #endif
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
      STEPPER_INDEX[MotorId] = 0;
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
      STEPPER_INDEX[MotorId] = 0;
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
     #ifndef STEPPER_FAST_MOTOR
     STEPPER_INDEX[MotorId] ++;
     #endif
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
     #ifndef STEPPER_FAST_MOTOR
     STEPPER_INDEX[MotorId] ++;
     #endif
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

#ifdef STEPPER_FAST_MOTOR
PUBLIC void STEPPER_FAST_EQUENCE(unsigned char MotorId)
{
  if(STEPPER_INDEX[MotorId] < STEPPER_CONFIGS[MotorId].STEP_PER_ANGLE);
  {
    switch(STEPPER_FLAGS[MotorId])
    {
     case 1:
     {
        STEPPER_SEQUENCE[MotorId] =
            0xF & ((STEPPER_SEQUENCE[MotorId] << 1)|(STEPPER_SEQUENCE[MotorId] >> 3));
        HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
     }
     break;
     case 2:
     {
        STEPPER_SEQUENCE[MotorId] =
           0x0F & ((STEPPER_SEQUENCE[MotorId] >> 1)|(STEPPER_SEQUENCE[MotorId] << 3));
        HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
     }
     break;
     case 0:
     {
        HWI_STEPPER_WRITE(MotorId,STOP_VALUE);
     }
     break;
     default:
     break;
    }
    STEPPER_INDEX[MotorId] ++;
  }
}
#endif

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

PUBLIC void STEPPER_MOVE_ANGLE(unsigned char MotorId,signed long s32Angle)
{
 STEPPER_ANGLE[MotorId] += s32Angle ;
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