 #define REACH_END_STOP 0x1
 #define END_MOVEMENT 0x2
 #define TIME_OUT 0x4
 #define MOVING 0x8
 
 PUBLIC void STEPPER_INITIALIZE(void);
 PUBLIC void STEPPER_MANAGE(unsigned char MotorId);
 PUBLIC void STEPPER_MOVE_ANGLE(unsigned char MotorId , signed short s16Angle);
 PUBLIC signed short STEPPER_GET_ANGLE(unsigned char MotorId);
 PUBLIC void STEPPER_STOP_MOVEMENT(unsigned char MotorId);
 PUBLIC unsigned char STEPPER_STATUS(unsigned char MotorId);
 PUBLIC void STEPPER_STALL(unsigned char MotorId,unsigned char direction);
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