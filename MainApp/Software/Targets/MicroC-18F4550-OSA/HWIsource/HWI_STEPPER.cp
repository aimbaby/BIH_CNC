#line 1 "E:/CNC/MainApp/Software/Targets/MicroC-18F4550-OSA/HWIsource/HWI_STEPPER.c"
#line 1 "e:/cnc/mainapp/software/common/link/alloc.h"
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_stepper.h"
  void HWI_STEPPER_INITIALIZE(void);
  void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value);
  void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value);
#line 4 "E:/CNC/MainApp/Software/Targets/MicroC-18F4550-OSA/HWIsource/HWI_STEPPER.c"
  void HWI_STEPPER_INITIALIZE(void)
{
 trisd = 0x00;
}
  void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value)
{
 if(MotorId == 0)
 {
 portd = (portd & 0xF0) | value;
 }
 if(MotorId == 1)
 {
 portd = (portd & 0x0F) | (value << 4);
 }
}
  void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value)
{
 value = portd;
}
