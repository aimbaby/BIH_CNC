#line 1 "E:/CNC/MainApp/Software/Common/Driver/STEPPER/STEPPER.c"
#line 1 "e:/cnc/mainapp/software/common/link/extern.h"
#line 1 "e:/cnc/mainapp/software/common/driver/stepper/steppers_cfg.h"
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_stepper.h"
 extern  void HWI_STEPPER_INITIALIZE(void);
 extern  void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value);
 extern  void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value);
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_digital.h"
  extern  unsigned char HWI_DIGI_READ(unsigned char pin);
  extern  void HWI_DIGI_WRITE(unsigned char pin,unsigned char value);
#line 1 "e:/cnc/mainapp/software/common/link/alloc.h"
#line 1 "e:/cnc/mainapp/software/common/driver/stepper/stepper.h"





   void STEPPER_INITIALIZE(void);
   void STEPPER_MANAGE(unsigned char MotorId);
   void STEPPER_MOVE_ANGLE(unsigned char MotorId , signed short s16Angle);
   signed short STEPPER_GET_ANGLE(unsigned char MotorId);
   void STEPPER_STOP_MOVEMENT(unsigned char MotorId);
   unsigned char STEPPER_STATUS(unsigned char MotorId);
   void STEPPER_STALL(unsigned char MotorId,unsigned char direction);
 typedef enum
 {
 STP_STALL_MIN,
 STP_STALL_MAX,
 STP_MOVING_CW,
 STP_MOVING_CCW,
 STP_STOPPED
 }STEPPER_SM;

 typedef struct
 {
 unsigned char STEP_PER_ANGLE;
 unsigned short MOVE_TIME;
 unsigned char PIN_ID;
 }STEPPER_CONFIG;
#line 11 "E:/CNC/MainApp/Software/Common/Driver/STEPPER/STEPPER.c"
 unsigned char STEPPER_SEQUENCE[( 4 )];
 signed short STEPPER_ANGLE[ 4 ];
 unsigned short STEPPER_MOVE_TIME[ 4 ];
 unsigned char STEPPER_INDEX[ 4 ];
 const STEPPER_CONFIG STEPPER_CONFIGS[ 4 ] =  { {5,50,0}, {5,50,1}, {5,1000,2}, {5,1000,3} } ;
 STEPPER_SM STEPPER_STATE[ 4 ];

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
 HWI_STEPPER_WRITE(MotorId, 0xF );
 }



  void STEPPER_INITIALIZE(void)
{
 memset(STEPPER_SEQUENCE,  0x9 ,  4 *sizeof(unsigned char));
 memset(STEPPER_ANGLE, 0 ,  4  * sizeof (signed short));
 memset(STEPPER_STATE, STP_STOPPED ,  4  * sizeof(STEPPER_SM));
 memset(STEPPER_INDEX, 0,  4  * sizeof(unsigned char));
 memset(STEPPER_MOVE_TIME, 0,  4  * sizeof(STEPPER_CONFIG));
}

  void STEPPER_MANAGE(unsigned char MotorId)
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

  void STEPPER_STOP_MOVEMENT(unsigned char MotorId)
{
 STEPPER_STATE[MotorId] = STP_STOPPED;
 STEPPER_ANGLE[MotorId] = 0;
}

  void STEPPER_STALL(unsigned char MotorId,unsigned char direction)
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

  void STEPPER_MOVE_ANGLE(unsigned char MotorId,signed short s16Angle)
{
 STEPPER_ANGLE[MotorId] += s16Angle ;
}
  signed short STEPPER_GET_ANGLE(unsigned char MotorId)
{
 return(STEPPER_ANGLE[MotorId]);
}

  unsigned char STEPPER_STATUS(unsigned char MotorId)
{
 unsigned char bIS_END_MOVE = 0;

 if (STEPPER_ANGLE[MotorId] == 0)
 {
 bIS_END_MOVE |=  0x2 ;
 }
 else
 {
 bIS_END_MOVE |=  0x7 ;
 }
 if(HWI_DIGI_READ(STEPPER_CONFIGS[MotorId].PIN_ID) ==  1 )
 {
 bIS_END_MOVE |=  0x1 ;
 }
 if(STEPPER_MOVE_TIME[MotorId] == 0)
 {
 bIS_END_MOVE |=  0x4 ;
 }

 return bIS_END_MOVE;
}
