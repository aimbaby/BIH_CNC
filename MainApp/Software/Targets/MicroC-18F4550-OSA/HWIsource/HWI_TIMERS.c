#include <osa.h>
#include "Extern.h"
 #include "AppInterrupts.h"

#include "Alloc.h"
 #include "HWI_TIMERS.h"
 
PUBLIC void HWI_TIMERS_INTITALIZE(void)
{
    INTCON = 0b11100000;
    T0CON =0b11011111;
    T1CON =0b10000101;
    T3CON =0b10011101;
    tmr0l=10;


    TMR1IF_bit=0;
    TMR1IE_bit=1;


    TMR3IF_bit=0;
    TMR3IE_bit=1;


    tmr1l=0;
    tmr1h=0xAA;

    tmr3h=0;
    tmr3l=0;

}


void interrupt (void)
{
  if(TMR0if_bit)
  {
   tmr0if_bit=0;
   tmr0l=10;
   OS_Timer();
  }
  if(tmr3if_bit)
  {
   tmr3if_bit=0;
   ISR1();
  }
  if(TMR1IF_bit)
  {
   tmr1IF_bit=0;
   tmr1l=0;
   tmr1h=0xAA;
  }
}