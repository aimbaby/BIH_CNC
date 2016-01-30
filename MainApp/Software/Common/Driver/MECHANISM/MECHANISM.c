  #include "Extern.h"
   #include "STEPPERS_Cfg.h"
   #include "MECHANISMS_Cfg.h"
   #include "STEPPER.h"
  #include "Alloc.h"
   #include "MECHANISM.h"

 #define DISP_UNKNOWN 0xFFFF

unsigned short CURRENT_DISPLACEMENT[MAX_NB_STEPPERS];
unsigned char FAILURES[MAX_NB_STEPPERS];

PUBLIC void MECHANISM_INITIALIZE(void)
{
 memset(FAILURES , 0 , MAX_NB_STEPPERS * sizeof(unsigned char));
 memset(CURRENT_DISPLACEMENT , DISP_UNKNOWN , MAX_NB_STEPPERS * sizeof(unsigned short));
}
PUBLIC void MECHANISM_CALIBRATE(unsigned char MechanismId)
{
 STEPPER_STALL(MechanismId,0); // stall min
 CURRENT_DISPLACEMENT[MechanismId] = 0;
}
PUBLIC void MECHANISM_MOVE(unsigned char MechanismId , unsigned short Distance)
{
 signed short Angle;
 Angle = (signed short)CURRENT_DISPLACEMENT[MechanismId]-(signed short)Distance;
 Angle *= (signed short)ANGLE_PER_MILLIM;
 STEPPER_MOVE_ANGLE(MechanismId,Angle);
 CURRENT_DISPLACEMENT[MechanismId]= Distance;
}
PUBLIC unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId)
{
 return((unsigned short)((signed short)CURRENT_DISPLACEMENT[MechanismId]-
        (((signed short) STEPPER_GET_ANGLE(MechanismId))
                                        /((signed short)ANGLE_PER_MILLIM)))) ;
}
PUBLIC unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId)
{
 return( 0 ) ;
}
