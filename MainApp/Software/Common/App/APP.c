#include   "Extern.h"
  #include "delay.h"
  #include "HWI_STEPPER.h"
  #include "STEPPER.h"
  #include "MECHANISM.h"
  #include "HWI_TIMERS.h"
#include "Alloc.h"
  #include "APP.h"
  
  PUBLIC void CNC_INITIALIZE(void)
  {
   HWI_TIMERS_INTITALIZE();
   HWI_STEPPER_INITIALIZE();
   STEPPER_INITIALIZE();
   MECHANISM_INITIALIZE();
  }
  
  PUBLIC void CNC_MANAGE(void)
  {
   MECHANISM_CALIBRATE(0);
   MECHANISM_MOVE(0,150); //15 cm
   MECHANISM_CALIBRATE(1);
   MECHANISM_MOVE(1,200); // 20 cm
  }