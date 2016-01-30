
_SEQUENCE_CW:

;STEPPER.c,18 :: 		void SEQUENCE_CW(unsigned char MotorId)
;STEPPER.c,20 :: 		STEPPER_SEQUENCE[MotorId] =
	MOVLW       _STEPPER_SEQUENCE+0
	MOVWF       R4 
	MOVLW       hi_addr(_STEPPER_SEQUENCE+0)
	MOVWF       R5 
	MOVF        FARG_SEQUENCE_CW_MotorId+0, 0 
	ADDWF       R4, 1 
	BTFSC       STATUS+0, 0 
	INCF        R5, 1 
;STEPPER.c,21 :: 		0xF & ((STEPPER_SEQUENCE[MotorId] << 1)|(STEPPER_SEQUENCE[MotorId] >> 3));
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R2 
	RLCF        R2, 1 
	BCF         R2, 0 
	MOVF        R3, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVLW       15
	ANDWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,22 :: 		HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
	MOVF        FARG_SEQUENCE_CW_MotorId+0, 0 
	MOVWF       FARG_HWI_STEPPER_WRITE_MotorId+0 
	MOVLW       _STEPPER_SEQUENCE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_SEQUENCE+0)
	MOVWF       FSR0H 
	MOVF        FARG_SEQUENCE_CW_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_HWI_STEPPER_WRITE_value+0 
	CALL        _HWI_STEPPER_WRITE+0, 0
;STEPPER.c,23 :: 		}
L_end_SEQUENCE_CW:
	RETURN      0
; end of _SEQUENCE_CW

_SEQUENCE_CCW:

;STEPPER.c,26 :: 		void SEQUENCE_CCW(unsigned char MotorId)
;STEPPER.c,28 :: 		STEPPER_SEQUENCE[MotorId] =
	MOVLW       _STEPPER_SEQUENCE+0
	MOVWF       R4 
	MOVLW       hi_addr(_STEPPER_SEQUENCE+0)
	MOVWF       R5 
	MOVF        FARG_SEQUENCE_CCW_MotorId+0, 0 
	ADDWF       R4, 1 
	BTFSC       STATUS+0, 0 
	INCF        R5, 1 
;STEPPER.c,29 :: 		0x0F & ((STEPPER_SEQUENCE[MotorId] >> 1)|(STEPPER_SEQUENCE[MotorId] << 3));
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	BCF         R2, 7 
	MOVF        R3, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R2, 0 
	IORWF       R0, 1 
	MOVLW       15
	ANDWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,30 :: 		HWI_STEPPER_WRITE(MotorId,STEPPER_SEQUENCE[MotorId]);
	MOVF        FARG_SEQUENCE_CCW_MotorId+0, 0 
	MOVWF       FARG_HWI_STEPPER_WRITE_MotorId+0 
	MOVLW       _STEPPER_SEQUENCE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_SEQUENCE+0)
	MOVWF       FSR0H 
	MOVF        FARG_SEQUENCE_CCW_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_HWI_STEPPER_WRITE_value+0 
	CALL        _HWI_STEPPER_WRITE+0, 0
;STEPPER.c,31 :: 		}
L_end_SEQUENCE_CCW:
	RETURN      0
; end of _SEQUENCE_CCW

_SEQUENCE_STOP:

;STEPPER.c,33 :: 		void SEQUENCE_STOP(unsigned char MotorId)
;STEPPER.c,35 :: 		HWI_STEPPER_WRITE(MotorId,STOP_VALUE);
	MOVF        FARG_SEQUENCE_STOP_MotorId+0, 0 
	MOVWF       FARG_HWI_STEPPER_WRITE_MotorId+0 
	MOVLW       15
	MOVWF       FARG_HWI_STEPPER_WRITE_value+0 
	CALL        _HWI_STEPPER_WRITE+0, 0
;STEPPER.c,36 :: 		}
L_end_SEQUENCE_STOP:
	RETURN      0
; end of _SEQUENCE_STOP

_STEPPER_INITIALIZE:

;STEPPER.c,40 :: 		PUBLIC void STEPPER_INITIALIZE(void)
;STEPPER.c,42 :: 		memset(STEPPER_SEQUENCE, START_VALUE, MAX_NB_STEPPERS*sizeof(unsigned char));
	MOVLW       _STEPPER_SEQUENCE+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_STEPPER_SEQUENCE+0)
	MOVWF       FARG_memset_p1+1 
	MOVLW       9
	MOVWF       FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;STEPPER.c,43 :: 		memset(STEPPER_ANGLE, 0 , MAX_NB_STEPPERS * sizeof (signed short));
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;STEPPER.c,44 :: 		memset(STEPPER_STATE, STP_STOPPED , MAX_NB_STEPPERS * sizeof(STEPPER_SM));
	MOVLW       _STEPPER_STATE+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FARG_memset_p1+1 
	MOVLW       4
	MOVWF       FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;STEPPER.c,45 :: 		memset(STEPPER_INDEX, 0, MAX_NB_STEPPERS * sizeof(unsigned char));
	MOVLW       _STEPPER_INDEX+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;STEPPER.c,46 :: 		memset(STEPPER_MOVE_TIME, 0, MAX_NB_STEPPERS * sizeof(STEPPER_CONFIG));
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       12
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;STEPPER.c,47 :: 		}
L_end_STEPPER_INITIALIZE:
	RETURN      0
; end of _STEPPER_INITIALIZE

_STEPPER_MANAGE:

;STEPPER.c,49 :: 		PUBLIC void STEPPER_MANAGE(unsigned char MotorId)
;STEPPER.c,51 :: 		switch(STEPPER_STATE[MotorId])
	MOVLW       _STEPPER_STATE+0
	MOVWF       FLOC__STEPPER_MANAGE+0 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FLOC__STEPPER_MANAGE+1 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FLOC__STEPPER_MANAGE+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__STEPPER_MANAGE+1, 1 
	GOTO        L_STEPPER_MANAGE0
;STEPPER.c,53 :: 		case STP_STALL_MIN:
L_STEPPER_MANAGE2:
;STEPPER.c,55 :: 		if(STEPPER_MOVE_TIME[MotorId] != 0)
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE3
;STEPPER.c,57 :: 		SEQUENCE_CCW(MotorId);
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       FARG_SEQUENCE_CCW_MotorId+0 
	CALL        _SEQUENCE_CCW+0, 0
;STEPPER.c,58 :: 		STEPPER_MOVE_TIME[MotorId] --;
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,59 :: 		}
	GOTO        L_STEPPER_MANAGE4
L_STEPPER_MANAGE3:
;STEPPER.c,62 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,63 :: 		}
L_STEPPER_MANAGE4:
;STEPPER.c,64 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,66 :: 		case STP_STALL_MAX:
L_STEPPER_MANAGE5:
;STEPPER.c,68 :: 		if(STEPPER_MOVE_TIME[MotorId] != 0)
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE6
;STEPPER.c,70 :: 		SEQUENCE_CW(MotorId);
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       FARG_SEQUENCE_CW_MotorId+0 
	CALL        _SEQUENCE_CW+0, 0
;STEPPER.c,71 :: 		STEPPER_MOVE_TIME[MotorId] --;
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,72 :: 		}
	GOTO        L_STEPPER_MANAGE7
L_STEPPER_MANAGE6:
;STEPPER.c,75 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,76 :: 		}
L_STEPPER_MANAGE7:
;STEPPER.c,77 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,79 :: 		case STP_MOVING_CW:
L_STEPPER_MANAGE8:
;STEPPER.c,81 :: 		SEQUENCE_CW(MotorId);
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       FARG_SEQUENCE_CW_MotorId+0 
	CALL        _SEQUENCE_CW+0, 0
;STEPPER.c,82 :: 		STEPPER_INDEX[MotorId] ++;
	MOVLW       _STEPPER_INDEX+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,83 :: 		if(STEPPER_INDEX[MotorId] == STEPPER_CONFIGS[MotorId].STEP_PER_ANGLE)
	MOVLW       _STEPPER_INDEX+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _STEPPER_CONFIGS+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        POSTINC0+0, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE9
;STEPPER.c,85 :: 		STEPPER_INDEX[MotorId] = 0;
	MOVLW       _STEPPER_INDEX+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;STEPPER.c,86 :: 		if(STEPPER_ANGLE[MotorId] > 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE10
;STEPPER.c,88 :: 		STEPPER_ANGLE[MotorId] --;
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	DECF        R0, 1 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,89 :: 		}
	GOTO        L_STEPPER_MANAGE11
L_STEPPER_MANAGE10:
;STEPPER.c,90 :: 		else if(STEPPER_ANGLE[MotorId] < 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE12
;STEPPER.c,92 :: 		STEPPER_STATE[MotorId] = STP_MOVING_CCW;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;STEPPER.c,93 :: 		}
	GOTO        L_STEPPER_MANAGE13
L_STEPPER_MANAGE12:
;STEPPER.c,96 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,97 :: 		}
L_STEPPER_MANAGE13:
L_STEPPER_MANAGE11:
;STEPPER.c,98 :: 		}
L_STEPPER_MANAGE9:
;STEPPER.c,99 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,101 :: 		case STP_MOVING_CCW:
L_STEPPER_MANAGE14:
;STEPPER.c,103 :: 		SEQUENCE_CCW(MotorId);
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       FARG_SEQUENCE_CCW_MotorId+0 
	CALL        _SEQUENCE_CCW+0, 0
;STEPPER.c,104 :: 		STEPPER_INDEX[MotorId] ++;
	MOVLW       _STEPPER_INDEX+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,105 :: 		if(STEPPER_INDEX[MotorId] == STEPPER_CONFIGS[MotorId].STEP_PER_ANGLE)
	MOVLW       _STEPPER_INDEX+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _STEPPER_CONFIGS+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        POSTINC0+0, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE15
;STEPPER.c,107 :: 		STEPPER_INDEX[MotorId] = 0;
	MOVLW       _STEPPER_INDEX+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_INDEX+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;STEPPER.c,108 :: 		if(STEPPER_ANGLE[MotorId] > 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE16
;STEPPER.c,110 :: 		STEPPER_STATE[MotorId] = STP_MOVING_CW;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;STEPPER.c,111 :: 		}
	GOTO        L_STEPPER_MANAGE17
L_STEPPER_MANAGE16:
;STEPPER.c,112 :: 		else if(STEPPER_ANGLE[MotorId] < 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE18
;STEPPER.c,114 :: 		STEPPER_ANGLE[MotorId] ++;
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	INCF        R0, 1 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,115 :: 		}
	GOTO        L_STEPPER_MANAGE19
L_STEPPER_MANAGE18:
;STEPPER.c,118 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,119 :: 		}
L_STEPPER_MANAGE19:
L_STEPPER_MANAGE17:
;STEPPER.c,120 :: 		}
L_STEPPER_MANAGE15:
;STEPPER.c,121 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,123 :: 		case STP_STOPPED:
L_STEPPER_MANAGE20:
;STEPPER.c,125 :: 		SEQUENCE_STOP(MotorId);
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	MOVWF       FARG_SEQUENCE_STOP_MotorId+0 
	CALL        _SEQUENCE_STOP+0, 0
;STEPPER.c,126 :: 		if(STEPPER_ANGLE[MotorId] > 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE21
;STEPPER.c,128 :: 		STEPPER_STATE[MotorId] = STP_MOVING_CW;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;STEPPER.c,130 :: 		}
	GOTO        L_STEPPER_MANAGE22
L_STEPPER_MANAGE21:
;STEPPER.c,131 :: 		else if(STEPPER_ANGLE[MotorId] < 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_STEPPER_MANAGE23
;STEPPER.c,133 :: 		STEPPER_STATE[MotorId] = STP_MOVING_CCW;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;STEPPER.c,134 :: 		}
L_STEPPER_MANAGE23:
L_STEPPER_MANAGE22:
;STEPPER.c,135 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,137 :: 		default:
L_STEPPER_MANAGE24:
;STEPPER.c,139 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_MANAGE_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,140 :: 		break;
	GOTO        L_STEPPER_MANAGE1
;STEPPER.c,143 :: 		}
L_STEPPER_MANAGE0:
	MOVFF       FLOC__STEPPER_MANAGE+0, FSR0L
	MOVFF       FLOC__STEPPER_MANAGE+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE2
	MOVFF       FLOC__STEPPER_MANAGE+0, FSR0L
	MOVFF       FLOC__STEPPER_MANAGE+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE5
	MOVFF       FLOC__STEPPER_MANAGE+0, FSR0L
	MOVFF       FLOC__STEPPER_MANAGE+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE8
	MOVFF       FLOC__STEPPER_MANAGE+0, FSR0L
	MOVFF       FLOC__STEPPER_MANAGE+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE14
	MOVFF       FLOC__STEPPER_MANAGE+0, FSR0L
	MOVFF       FLOC__STEPPER_MANAGE+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_STEPPER_MANAGE20
	GOTO        L_STEPPER_MANAGE24
L_STEPPER_MANAGE1:
;STEPPER.c,145 :: 		}
L_end_STEPPER_MANAGE:
	RETURN      0
; end of _STEPPER_MANAGE

_STEPPER_STOP_MOVEMENT:

;STEPPER.c,147 :: 		PUBLIC void STEPPER_STOP_MOVEMENT(unsigned char MotorId)
;STEPPER.c,149 :: 		STEPPER_STATE[MotorId] = STP_STOPPED;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_STOP_MOVEMENT_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       4
	MOVWF       POSTINC1+0 
;STEPPER.c,150 :: 		STEPPER_ANGLE[MotorId] = 0;
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_STOP_MOVEMENT_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;STEPPER.c,151 :: 		}
L_end_STEPPER_STOP_MOVEMENT:
	RETURN      0
; end of _STEPPER_STOP_MOVEMENT

_STEPPER_STALL:

;STEPPER.c,153 :: 		PUBLIC void STEPPER_STALL(unsigned char MotorId,unsigned char direction)
;STEPPER.c,155 :: 		if(STEPPER_MOVE_TIME[MotorId] == 0 )
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_STALL_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_STALL25
;STEPPER.c,157 :: 		STEPPER_MOVE_TIME[MotorId] = STEPPER_CONFIGS[MotorId].MOVE_TIME;
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FLOC__STEPPER_STALL+0 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FLOC__STEPPER_STALL+1 
	MOVF        FARG_STEPPER_STALL_MotorId+0, 0 
	ADDWF       FLOC__STEPPER_STALL+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__STEPPER_STALL+1, 1 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_STEPPER_STALL_MotorId+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _STEPPER_CONFIGS+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R2, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FLOC__STEPPER_STALL+0, FSR1L
	MOVFF       FLOC__STEPPER_STALL+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,158 :: 		if(direction == 0)
	MOVF        FARG_STEPPER_STALL_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_STALL26
;STEPPER.c,160 :: 		STEPPER_STATE[MotorId] = STP_STALL_MIN;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_STALL_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;STEPPER.c,161 :: 		}
	GOTO        L_STEPPER_STALL27
L_STEPPER_STALL26:
;STEPPER.c,164 :: 		STEPPER_STATE[MotorId] = STP_STALL_MAX;
	MOVLW       _STEPPER_STATE+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_STEPPER_STATE+0)
	MOVWF       FSR1H 
	MOVF        FARG_STEPPER_STALL_MotorId+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;STEPPER.c,165 :: 		}
L_STEPPER_STALL27:
;STEPPER.c,166 :: 		}
L_STEPPER_STALL25:
;STEPPER.c,167 :: 		}
L_end_STEPPER_STALL:
	RETURN      0
; end of _STEPPER_STALL

_STEPPER_MOVE_ANGLE:

;STEPPER.c,169 :: 		PUBLIC void STEPPER_MOVE_ANGLE(unsigned char MotorId,signed short s16Angle)
;STEPPER.c,171 :: 		STEPPER_ANGLE[MotorId] += s16Angle ;
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       R1 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       R2 
	MOVF        FARG_STEPPER_MOVE_ANGLE_MotorId+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        FARG_STEPPER_MOVE_ANGLE_s16Angle+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;STEPPER.c,172 :: 		}
L_end_STEPPER_MOVE_ANGLE:
	RETURN      0
; end of _STEPPER_MOVE_ANGLE

_STEPPER_GET_ANGLE:

;STEPPER.c,173 :: 		PUBLIC signed short STEPPER_GET_ANGLE(unsigned char MotorId)
;STEPPER.c,175 :: 		return(STEPPER_ANGLE[MotorId]);
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_GET_ANGLE_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;STEPPER.c,176 :: 		}
L_end_STEPPER_GET_ANGLE:
	RETURN      0
; end of _STEPPER_GET_ANGLE

_STEPPER_STATUS:

;STEPPER.c,178 :: 		PUBLIC unsigned char STEPPER_STATUS(unsigned char MotorId)
;STEPPER.c,180 :: 		unsigned char bIS_END_MOVE = 0;
	CLRF        STEPPER_STATUS_bIS_END_MOVE_L0+0 
;STEPPER.c,182 :: 		if (STEPPER_ANGLE[MotorId] == 0)
	MOVLW       _STEPPER_ANGLE+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_ANGLE+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_STATUS_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_STATUS28
;STEPPER.c,184 :: 		bIS_END_MOVE |=  END_MOVEMENT;
	BSF         STEPPER_STATUS_bIS_END_MOVE_L0+0, 1 
;STEPPER.c,185 :: 		}
	GOTO        L_STEPPER_STATUS29
L_STEPPER_STATUS28:
;STEPPER.c,188 :: 		bIS_END_MOVE |= MOVING;
	MOVLW       7
	IORWF       STEPPER_STATUS_bIS_END_MOVE_L0+0, 1 
;STEPPER.c,189 :: 		}
L_STEPPER_STATUS29:
;STEPPER.c,190 :: 		if(HWI_DIGI_READ(STEPPER_CONFIGS[MotorId].PIN_ID) == END_STOP_VALUE)
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FARG_STEPPER_STATUS_MotorId+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       _STEPPER_CONFIGS+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R1, 1 
	MOVLW       higher_addr(_STEPPER_CONFIGS+0)
	ADDWFC      R2, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_HWI_DIGI_READ_pin+0
	CALL        _HWI_DIGI_READ+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_STATUS30
;STEPPER.c,192 :: 		bIS_END_MOVE |= REACH_END_STOP;
	BSF         STEPPER_STATUS_bIS_END_MOVE_L0+0, 0 
;STEPPER.c,193 :: 		}
L_STEPPER_STATUS30:
;STEPPER.c,194 :: 		if(STEPPER_MOVE_TIME[MotorId] == 0)
	MOVLW       _STEPPER_MOVE_TIME+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(_STEPPER_MOVE_TIME+0)
	MOVWF       FSR0H 
	MOVF        FARG_STEPPER_STATUS_MotorId+0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_STEPPER_STATUS31
;STEPPER.c,196 :: 		bIS_END_MOVE |= TIME_OUT;
	BSF         STEPPER_STATUS_bIS_END_MOVE_L0+0, 2 
;STEPPER.c,197 :: 		}
L_STEPPER_STATUS31:
;STEPPER.c,199 :: 		return bIS_END_MOVE;
	MOVF        STEPPER_STATUS_bIS_END_MOVE_L0+0, 0 
	MOVWF       R0 
;STEPPER.c,200 :: 		}
L_end_STEPPER_STATUS:
	RETURN      0
; end of _STEPPER_STATUS
