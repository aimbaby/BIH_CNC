#include "Extern.h"
 #include "STEPPER.h"

#include "Alloc.h"
 #include "AppInterrupts.h"

PUBLIC void APP_ISR1(void)
{
 STEPPER_FAST_EQUENCE(0);
 STEPPER_FAST_EQUENCE(1);
}