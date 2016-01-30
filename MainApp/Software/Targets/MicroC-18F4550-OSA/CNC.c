#include <osa.h>

#include "Extern.h"
  #include "APP.h"
  #include "STEPPER.h"

void CNC_CONTROL(void);
void STEPPER_CONTROL(void);

#pragma funcall main CNC_CONTROL
#pragma funcall main STEPPER_CONTROL

void main()
{
 CNC_INITIALIZE();                           // Init periphery
 OS_Init();                                  // Init OS

 OS_Task_Create(1,CNC_CONTROL);
 OS_Task_Create(2,STEPPER_CONTROL);
 OS_EI();                            // Enable interrupts

 OS_Run();

}

void CNC_CONTROL(void)
{
 //for(;;)
  {
   CNC_MANAGE();
   OS_Delay(10);
  }
}

void STEPPER_CONTROL(void)
{
 for(;;)
 {
  STEPPER_MANAGE(0);
  OS_Delay(5);
  STEPPER_MANAGE(1);
  OS_Delay(5);
  STEPPER_MANAGE(2);
  OS_Delay(5);
  STEPPER_MANAGE(3);
  OS_Delay(5);
 }
}