#include "Alloc.h"
 #include "HWI_STEPPER.h"

PUBLIC void HWI_STEPPER_INITIALIZE(void)
{
 trisd = 0x00;
}
PUBLIC void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value)
{
 if(MotorId == 0)
 {
  portd = (LATD & 0xF0) | value;
 }
 if(MotorId == 1)
 {
  portd = (LATD & 0x0F) | (value << 4);
 }
}
PUBLIC void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value)
{
 value = portd;
}