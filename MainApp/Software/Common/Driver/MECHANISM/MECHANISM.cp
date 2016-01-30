#line 1 "E:/CNC/MainApp/Software/Common/Driver/MECHANISM/MECHANISM.c"
#line 1 "e:/cnc/mainapp/software/common/link/extern.h"
#line 1 "e:/cnc/mainapp/software/common/driver/stepper/steppers_cfg.h"
#line 1 "e:/cnc/mainapp/software/common/driver/mechanism/mechanisms_cfg.h"
#line 1 "e:/cnc/mainapp/software/common/driver/stepper/stepper.h"





  extern  void STEPPER_INITIALIZE(void);
  extern  void STEPPER_MANAGE(unsigned char MotorId);
  extern  void STEPPER_MOVE_ANGLE(unsigned char MotorId , signed short s16Angle);
  extern  signed short STEPPER_GET_ANGLE(unsigned char MotorId);
  extern  void STEPPER_STOP_MOVEMENT(unsigned char MotorId);
  extern  unsigned char STEPPER_STATUS(unsigned char MotorId);
  extern  void STEPPER_STALL(unsigned char MotorId,unsigned char direction);
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
#line 1 "e:/cnc/mainapp/software/common/link/alloc.h"
#line 1 "e:/cnc/mainapp/software/common/driver/mechanism/mechanism.h"
  void MECHANISM_INITIALIZE(void);
  void MECHANISM_CALIBRATE(unsigned char MechanismId);
  void MECHANISM_MOVE(unsigned char MechanismId,unsigned short Distance);
  unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId);
  unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId);
#line 10 "E:/CNC/MainApp/Software/Common/Driver/MECHANISM/MECHANISM.c"
unsigned short CURRENT_DISPLACEMENT[ 4 ];
unsigned char FAILURES[ 4 ];

  void MECHANISM_INITIALIZE(void)
{
 memset(FAILURES , 0 ,  4  * sizeof(unsigned char));
 memset(CURRENT_DISPLACEMENT ,  0xFFFF  ,  4  * sizeof(unsigned short));
}
  void MECHANISM_CALIBRATE(unsigned char MechanismId)
{
 STEPPER_STALL(MechanismId,0);
 CURRENT_DISPLACEMENT[MechanismId] = 0;
}
  void MECHANISM_MOVE(unsigned char MechanismId , unsigned short Distance)
{
 signed short Angle;
 Angle = (signed short)CURRENT_DISPLACEMENT[MechanismId]-(signed short)Distance;
 Angle *= (signed short) 1 ;
 STEPPER_MOVE_ANGLE(MechanismId,Angle);
 CURRENT_DISPLACEMENT[MechanismId]= Distance;
}
  unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId)
{
 return((unsigned short)((signed short)CURRENT_DISPLACEMENT[MechanismId]-
 (((signed short) STEPPER_GET_ANGLE(MechanismId))
 /((signed short) 1 )))) ;
}
  unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId)
{
 return( 0 ) ;
}
