#include "Extern.h"
 #include "STEPPER.h"

#include "Alloc.h"
 #include "AppInterrupts.h"

PUBLIC void APP_ISR1(void)
{
 STEPPER_MANAGE(0);
 STEPPER_MANAGE(1);
 STEPPER_MANAGE(2);
 STEPPER_MANAGE(3);
}