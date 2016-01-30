
_MECHANISM_INITIALIZE:

;MECHANISM.c,13 :: 		PUBLIC void MECHANISM_INITIALIZE(void)
;MECHANISM.c,15 :: 		memset(FAILURES , 0 , MAX_NB_STEPPERS * sizeof(unsigned char));
	MOVLW       _FAILURES+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_FAILURES+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MECHANISM.c,16 :: 		memset(CURRENT_DISPLACEMENT , DISP_UNKNOWN , MAX_NB_STEPPERS * sizeof(unsigned short));
	MOVLW       _CURRENT_DISPLACEMENT+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_CURRENT_DISPLACEMENT+0)
	MOVWF       FARG_memset_p1+1 
	MOVLW       255
	MOVWF       FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;MECHANISM.c,17 :: 		}
L_end_MECHANISM_INITIALIZE:
	RETURN      0
; end of _MECHANISM_INITIALIZE

_MECHANISM_CALIBRATE:

;MECHANISM.c,18 :: 		PUBLIC void MECHANISM_CALIBRATE(unsigned char MechanismId)
;MECHANISM.c,20 :: 		STEPPER_STALL(MechanismId,0); // stall min
	MOVF        FARG_MECHANISM_CALIBRATE_MechanismId+0, 0 
	MOVWF       FARG_STEPPER_STALL_MotorId+0 
	CLRF        FARG_STEPPER_STALL_direction+0 
	CALL        _STEPPER_STALL+0, 0
;MECHANISM.c,21 :: 		CURRENT_DISPLACEMENT[MechanismId] = 0;
	MOVLW       _CURRENT_DISPLACEMENT+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_CURRENT_DISPLACEMENT+0)
	MOVWF       FSR1H 
	MOVF        FARG_MECHANISM_CALIBRATE_MechanismId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;MECHANISM.c,22 :: 		}
L_end_MECHANISM_CALIBRATE:
	RETURN      0
; end of _MECHANISM_CALIBRATE

_MECHANISM_MOVE:

;MECHANISM.c,23 :: 		PUBLIC void MECHANISM_MOVE(unsigned char MechanismId , unsigned short Distance)
;MECHANISM.c,26 :: 		Angle = (signed short)CURRENT_DISPLACEMENT[MechanismId]-(signed short)Distance;
	MOVLW       _CURRENT_DISPLACEMENT+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_CURRENT_DISPLACEMENT+0)
	MOVWF       FSR0H 
	MOVF        FARG_MECHANISM_MOVE_MechanismId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        FARG_MECHANISM_MOVE_Distance+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       FARG_STEPPER_MOVE_ANGLE_s16Angle+0 
;MECHANISM.c,27 :: 		Angle *= (signed short)ANGLE_PER_MILLIM;
;MECHANISM.c,28 :: 		STEPPER_MOVE_ANGLE(MechanismId,Angle);
	MOVF        FARG_MECHANISM_MOVE_MechanismId+0, 0 
	MOVWF       FARG_STEPPER_MOVE_ANGLE_MotorId+0 
	CALL        _STEPPER_MOVE_ANGLE+0, 0
;MECHANISM.c,29 :: 		CURRENT_DISPLACEMENT[MechanismId]= Distance;
	MOVLW       _CURRENT_DISPLACEMENT+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_CURRENT_DISPLACEMENT+0)
	MOVWF       FSR1H 
	MOVF        FARG_MECHANISM_MOVE_MechanismId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        FARG_MECHANISM_MOVE_Distance+0, 0 
	MOVWF       POSTINC1+0 
;MECHANISM.c,30 :: 		}
L_end_MECHANISM_MOVE:
	RETURN      0
; end of _MECHANISM_MOVE

_MECHANISM_GET_POSITION:

;MECHANISM.c,31 :: 		PUBLIC unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId)
;MECHANISM.c,33 :: 		return((unsigned short)((signed short)CURRENT_DISPLACEMENT[MechanismId]-
	MOVLW       _CURRENT_DISPLACEMENT+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_CURRENT_DISPLACEMENT+0)
	MOVWF       FSR0H 
	MOVF        FARG_MECHANISM_GET_POSITION_MechanismId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__MECHANISM_GET_POSITION+0 
;MECHANISM.c,34 :: 		(((signed short) STEPPER_GET_ANGLE(MechanismId))
	MOVF        FARG_MECHANISM_GET_POSITION_MechanismId+0, 0 
	MOVWF       FARG_STEPPER_GET_ANGLE_MotorId+0 
	CALL        _STEPPER_GET_ANGLE+0, 0
;MECHANISM.c,35 :: 		/((signed short)ANGLE_PER_MILLIM)))) ;
	MOVF        R0, 0 
	SUBWF       FLOC__MECHANISM_GET_POSITION+0, 0 
	MOVWF       R0 
;MECHANISM.c,36 :: 		}
L_end_MECHANISM_GET_POSITION:
	RETURN      0
; end of _MECHANISM_GET_POSITION

_MECHANISM_CHECK_FAILURE:

;MECHANISM.c,37 :: 		PUBLIC unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId)
;MECHANISM.c,39 :: 		return( 0 ) ;
	CLRF        R0 
;MECHANISM.c,40 :: 		}
L_end_MECHANISM_CHECK_FAILURE:
	RETURN      0
; end of _MECHANISM_CHECK_FAILURE
