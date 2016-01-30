
_HWI_TIMERS_INTITALIZE:

;HWI_TIMERS.c,8 :: 		PUBLIC void HWI_TIMERS_INTITALIZE(void)
;HWI_TIMERS.c,10 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;HWI_TIMERS.c,11 :: 		T0CON =0b11010111;
	MOVLW       215
	MOVWF       T0CON+0 
;HWI_TIMERS.c,12 :: 		T1CON =0b10000101;
	MOVLW       133
	MOVWF       T1CON+0 
;HWI_TIMERS.c,13 :: 		T3CON =0b10011101;
	MOVLW       157
	MOVWF       T3CON+0 
;HWI_TIMERS.c,14 :: 		tmr0l=210;
	MOVLW       210
	MOVWF       TMR0L+0 
;HWI_TIMERS.c,17 :: 		TMR1IF_bit=0;
	BCF         TMR1IF_bit+0, 0 
;HWI_TIMERS.c,18 :: 		TMR1IE_bit=1;
	BSF         TMR1IE_bit+0, 0 
;HWI_TIMERS.c,21 :: 		TMR3IF_bit=0;
	BCF         TMR3IF_bit+0, 1 
;HWI_TIMERS.c,22 :: 		TMR3IE_bit=1;
	BSF         TMR3IE_bit+0, 1 
;HWI_TIMERS.c,25 :: 		tmr1l=0;
	CLRF        TMR1L+0 
;HWI_TIMERS.c,26 :: 		tmr1h=0xAA;
	MOVLW       170
	MOVWF       TMR1H+0 
;HWI_TIMERS.c,28 :: 		tmr3h=0;
	CLRF        TMR3H+0 
;HWI_TIMERS.c,29 :: 		tmr3l=0;
	CLRF        TMR3L+0 
;HWI_TIMERS.c,31 :: 		}
L_end_HWI_TIMERS_INTITALIZE:
	RETURN      0
; end of _HWI_TIMERS_INTITALIZE

_interrupt:

;HWI_TIMERS.c,34 :: 		void interrupt (void)
;HWI_TIMERS.c,36 :: 		if(TMR0if_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;HWI_TIMERS.c,38 :: 		tmr0if_bit=0;
	BCF         TMR0IF_bit+0, 2 
;HWI_TIMERS.c,39 :: 		tmr0l=210;
	MOVLW       210
	MOVWF       TMR0L+0 
;HWI_TIMERS.c,40 :: 		OS_Timer();
	CALL        _OS_Timer+0, 0
;HWI_TIMERS.c,41 :: 		}
L_interrupt0:
;HWI_TIMERS.c,42 :: 		if(tmr3if_bit)
	BTFSS       TMR3IF_bit+0, 1 
	GOTO        L_interrupt1
;HWI_TIMERS.c,44 :: 		tmr3if_bit=0;
	BCF         TMR3IF_bit+0, 1 
;HWI_TIMERS.c,45 :: 		ISR1();
	CALL        _ISR1+0, 0
;HWI_TIMERS.c,46 :: 		}
L_interrupt1:
;HWI_TIMERS.c,47 :: 		if(TMR1IF_bit)
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt2
;HWI_TIMERS.c,49 :: 		tmr1IF_bit=0;
	BCF         TMR1IF_bit+0, 0 
;HWI_TIMERS.c,50 :: 		tmr1l=0;
	CLRF        TMR1L+0 
;HWI_TIMERS.c,51 :: 		tmr1h=0xAA;
	MOVLW       170
	MOVWF       TMR1H+0 
;HWI_TIMERS.c,52 :: 		}
L_interrupt2:
;HWI_TIMERS.c,53 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt
