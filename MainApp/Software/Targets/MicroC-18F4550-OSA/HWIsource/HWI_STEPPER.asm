
_HWI_STEPPER_INITIALIZE:

;HWI_STEPPER.c,4 :: 		PUBLIC void HWI_STEPPER_INITIALIZE(void)
;HWI_STEPPER.c,6 :: 		trisd = 0x00;
	CLRF        TRISD+0 
;HWI_STEPPER.c,7 :: 		}
L_end_HWI_STEPPER_INITIALIZE:
	RETURN      0
; end of _HWI_STEPPER_INITIALIZE

_HWI_STEPPER_WRITE:

;HWI_STEPPER.c,8 :: 		PUBLIC void HWI_STEPPER_WRITE(unsigned char MotorId,unsigned char value)
;HWI_STEPPER.c,10 :: 		if(MotorId == 0)
	MOVF        FARG_HWI_STEPPER_WRITE_MotorId+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_HWI_STEPPER_WRITE0
;HWI_STEPPER.c,12 :: 		portd = (portd & 0xF0) | value;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R0 
	MOVF        FARG_HWI_STEPPER_WRITE_value+0, 0 
	IORWF       R0, 0 
	MOVWF       PORTD+0 
;HWI_STEPPER.c,13 :: 		}
L_HWI_STEPPER_WRITE0:
;HWI_STEPPER.c,14 :: 		if(MotorId == 1)
	MOVF        FARG_HWI_STEPPER_WRITE_MotorId+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_HWI_STEPPER_WRITE1
;HWI_STEPPER.c,16 :: 		portd = (portd & 0x0F) | (value << 4);
	MOVLW       15
	ANDWF       PORTD+0, 0 
	MOVWF       R2 
	MOVF        FARG_HWI_STEPPER_WRITE_value+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       R2, 0 
	MOVWF       PORTD+0 
;HWI_STEPPER.c,17 :: 		}
L_HWI_STEPPER_WRITE1:
;HWI_STEPPER.c,18 :: 		}
L_end_HWI_STEPPER_WRITE:
	RETURN      0
; end of _HWI_STEPPER_WRITE

_HWI_STEPPER_READ:

;HWI_STEPPER.c,19 :: 		PUBLIC void HWI_STEPPER_READ(unsigned char MotorId, unsigned char value)
;HWI_STEPPER.c,21 :: 		value = portd;
	MOVF        PORTD+0, 0 
	MOVWF       FARG_HWI_STEPPER_READ_value+0 
;HWI_STEPPER.c,22 :: 		}
L_end_HWI_STEPPER_READ:
	RETURN      0
; end of _HWI_STEPPER_READ
