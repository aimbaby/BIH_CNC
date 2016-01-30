#line 1 "E:/CNC/MainApp/Software/Targets/MicroC-18F4550-OSA/HWIsource/HWI_TIMERS.c"
#line 1 "e:/cnc/mainapp/software/os/osa/osa.h"
#line 1 "e:/cnc/mainapp/software/os/osacfg.h"
#line 1068 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef  short  _OST_SMSG;
#line 1 "e:/cnc/mainapp/software/os/osa/port/osa_include.h"
#line 1 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
#line 41 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
typedef unsigned char OST_UINT8;
typedef unsigned int OST_UINT16;
typedef unsigned long OST_UINT32;
typedef unsigned char OST_BOOL;

typedef OST_UINT8 OST_UINT;
#line 93 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
extern volatile unsigned int _fsr;
extern volatile char _indf;
extern volatile char _postinc;
extern volatile char _postdec;
extern volatile char _preinc;

extern volatile unsigned char _fsr1l;

extern volatile char _pcl;
extern volatile char _pclath;
extern volatile char _pclatu;
extern volatile char _status;
extern volatile char _tosl;
extern volatile char _tosh;
extern volatile char _tosu;
extern volatile char _bsr;
extern volatile char _wreg;
extern volatile char _intcon;
extern volatile char _rcon;
extern volatile char _stkptr;
#line 251 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
void _OS_JumpToTask (void);
#line 288 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
extern void _OS_ReturnSave (void);
extern void _OS_ReturnNoSave (void);
extern void _OS_EnterWaitMode (void);
extern void _OS_EnterWaitModeTO (void);

extern void _OS_SET_FSR_CUR_TASK (void);
#line 397 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
char OS_DI (void);
void OS_RI (char);
#line 419 "e:/cnc/mainapp/software/os/osa/port/pic18/osa_pic18_mikroc.h"
extern void _OS_CheckEvent (OST_UINT);
#line 1092 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef  short  OST_SMSG;
#line 1110 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef  void *  OST_MSG;







typedef

 volatile

 struct _OST_MSG_CB
{
 OST_UINT status;
 OST_MSG msg;

} OST_MSG_CB;
#line 1139 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef struct
{
 OST_UINT cSize;
 OST_UINT cFilled;
 OST_UINT cBegin;

} OST_QUEUE_CONTROL;




typedef struct
{
 OST_QUEUE_CONTROL Q;
 OST_MSG *pMsg;

} OST_QUEUE;




typedef struct
{
 OST_QUEUE_CONTROL Q;
 OST_SMSG *pSMsg;

} OST_SQUEUE;
#line 1190 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef struct
{
 OST_UINT bEventError : 1;
 OST_UINT bError : 1;

 OST_UINT bInCriticalSection : 1;

 OST_UINT bCheckingTasks : 1;


 OST_UINT bBestTaskFound : 1;





  OST_UINT bTimeout : 1; OST_UINT bGIE_CTemp : 1; OST_UINT bGIEL_CTemp : 1; 



 OST_UINT bEventOK : 1;







} OST_SYSTEM_FLAGS;
#line 1235 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef struct
{
 OST_UINT cPriority : 3;
 OST_UINT bReady : 1;
 OST_UINT bDelay : 1;


 OST_UINT bCanContinue: 1;
 OST_UINT bEnable : 1;
 OST_UINT bPaused : 1;


  


} OST_TASK_STATE;
#line 1270 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef struct
{
 OST_TASK_STATE State;
  unsigned long  pTaskPointer;




  



  OST_UINT8  Timer;


} OST_TCB;
#line 1477 "e:/cnc/mainapp/software/os/osa/osa.h"
typedef OST_UINT8 OST_CSEM;
#line 1506 "e:/cnc/mainapp/software/os/osa/osa.h"
extern volatile   OST_SYSTEM_FLAGS _OS_Flags;
extern   OST_UINT _OS_Temp;


extern volatile   OST_UINT _OS_TempH;




extern volatile   OST_TASK_STATE _OS_State;
#line 1527 "e:/cnc/mainapp/software/os/osa/osa.h"
extern   OST_TCB *    volatile _OS_CurTask;
#line 1563 "e:/cnc/mainapp/software/os/osa/osa.h"
 extern   OST_UINT _OS_Best_Priority;
 extern   OST_UINT _OS_Worst_Priority;
 extern   OST_UINT _OS_Best_n;
 extern   OST_UINT _OS_Cur_Pos;
 extern   OST_UINT _OS_n;
 extern   OST_UINT8 _OS_TaskQueue[ 2 ];
 extern   OST_UINT8 _OS_TaskLevel[ 2 ];
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/osa_oldnames.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/system/osa_system.h"
#line 48 "e:/cnc/mainapp/software/os/osa/kernel/system/osa_system.h"
extern void OS_Init (void);



extern void OS_EnterCriticalSection (void);
extern void OS_LeaveCriticalSection (void);
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/system/osa_tasks.h"
#line 37 "e:/cnc/mainapp/software/os/osa/kernel/system/osa_tasks.h"
extern   OST_TCB _OS_Tasks[ 2 ];






void _OS_Task_Create(OST_UINT priority,  unsigned long  TaskAddr);
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_bsem.h"
#line 56 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_bsem.h"
extern volatile   OST_UINT _OS_Bsems[( 1 + 8 -1)/ 8 ];
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_csem.h"
#line 54 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_csem.h"
extern void _OS_Csem_Signal(OST_CSEM *pCSem);
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_flag.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_msg.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_queue.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_smsg.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/events/osa_squeue.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_stimer.h"
#line 43 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_stimer.h"
extern volatile    OST_UINT8  _OS_Stimers[ 1 ] ;


extern   OST_UINT _OS_StimersFree[( 1  +  8 -1) /  8 ];









 OST_UINT8 _OS_Stimer_GetFree (OST_UINT bCreate);
 void _OS_Stimer_Free (OST_UINT8 ID);
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_stimer_old.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_dtimer.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_qtimer.h"
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_ttimer.h"
#line 53 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_ttimer.h"
void _OS_InitDelay( OST_UINT8  Delay);
#line 1 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_timer.h"
#line 53 "e:/cnc/mainapp/software/os/osa/kernel/timers/osa_timer.h"
 extern void OS_Timer (void);
#line 1 "e:/cnc/mainapp/software/common/link/extern.h"
#line 1 "e:/cnc/mainapp/software/common/interrupts/appinterrupts.h"
 extern  void ISR1(void);
#line 1 "e:/cnc/mainapp/software/common/link/alloc.h"
#line 1 "e:/cnc/mainapp/software/common/hwiheader/hwi_timers.h"
  void HWI_TIMERS_INTITALIZE(void);
#line 8 "E:/CNC/MainApp/Software/Targets/MicroC-18F4550-OSA/HWIsource/HWI_TIMERS.c"
  void HWI_TIMERS_INTITALIZE(void)
{
 INTCON = 0b11100000;
 T0CON =0b11010111;
 T1CON =0b10000101;
 T3CON =0b10011101;
 tmr0l=210;


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
 tmr0l=210;
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
