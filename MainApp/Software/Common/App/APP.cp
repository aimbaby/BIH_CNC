#line 1 "E:/CNC/MainApp/Software/Common/App/APP.c"
#line 1 "e:/cnc/mainapp/software/common/link/extern.h"
#line 1 "e:/cnc/mainapp/software/common/hwiheader/delay.h"
 extern  void HWI_Delay_msec(unsigned short Time);
 extern  void HWI_Delay_usec(unsigned short Time);
 extern  void HWI_Delay_nsec(unsigned short Time);
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_stepper.h"
 extern  void HWI_STEPPER_INITIALIZE(void);
 extern  void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value);
 extern  void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value);
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
#line 1 "e:/cnc/mainapp/software/common/driver/mechanism/mechanism.h"
 extern  void MECHANISM_INITIALIZE(void);
 extern  void MECHANISM_CALIBRATE(unsigned char MechanismId);
 extern  void MECHANISM_MOVE(unsigned char MechanismId,unsigned short Distance);
 extern  unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId);
 extern  unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId);
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_timers.h"
 extern  void HWI_TIMERS_INTITALIZE(void);
#line 1 "e:/cnc/mainapp/software/common/link/alloc.h"
#line 1 "e:/cnc/mainapp/software/common/app/app.h"

  void CNC_INITIALIZE(void);
  void CNC_MANAGE();
#line 10 "E:/CNC/MainApp/Software/Common/App/APP.c"
   void CNC_INITIALIZE(void)
 {
 HWI_TIMERS_INTITALIZE();
 HWI_STEPPER_INITIALIZE();
 STEPPER_INITIALIZE();
 MECHANISM_INITIALIZE();
 }

   void CNC_MANAGE(void)
 {
 MECHANISM_CALIBRATE(0);
 MECHANISM_MOVE(0,150);
 MECHANISM_CALIBRATE(1);
 MECHANISM_MOVE(1,200);
 }
