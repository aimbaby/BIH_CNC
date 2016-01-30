
__OS_JumpToTask:

;osa_pic18_mikroc.c,64 :: 		
;osa_pic18_mikroc.c,66 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,67 :: 		
	MOVF        4078, 0 
	MOVWF       __OS_State+0 
;osa_pic18_mikroc.c,69 :: 		
	PUSH
;osa_pic18_mikroc.c,70 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,71 :: 		
	MOVWF       4093, 1
;osa_pic18_mikroc.c,72 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,73 :: 		
	MOVWF       4094, 1
;osa_pic18_mikroc.c,74 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,75 :: 		
	MOVWF       4095, 1
;osa_pic18_mikroc.c,76 :: 		
	RETURN      0
;osa_pic18_mikroc.c,78 :: 		
L_end__OS_JumpToTask:
	RETURN      0
; end of __OS_JumpToTask

__OS_ReturnSave:

;osa_pic18_mikroc.c,106 :: 		
;osa_pic18_mikroc.c,108 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,109 :: 		
	MOVF        4093, 0 
	MOVWF       4076 
	MOVF        4094, 0 
	MOVWF       4076 
	MOVF        4095, 0 
	MOVWF       4076 
;osa_pic18_mikroc.c,110 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,111 :: 		
	POP
;osa_pic18_mikroc.c,112 :: 		
L_end__OS_ReturnSave:
	RETURN      0
; end of __OS_ReturnSave

__OS_ReturnNoSave:

;osa_pic18_mikroc.c,132 :: 		
;osa_pic18_mikroc.c,134 :: 		
	POP
;osa_pic18_mikroc.c,135 :: 		
L_end__OS_ReturnNoSave:
	RETURN      0
; end of __OS_ReturnNoSave

__OS_EnterWaitMode:

;osa_pic18_mikroc.c,156 :: 		
;osa_pic18_mikroc.c,158 :: 		
	CLRF        __OS_Temp+0 
;osa_pic18_mikroc.c,159 :: 		
	CALL        __OS_ClrReadySetClrCanContinue+0, 0
;osa_pic18_mikroc.c,160 :: 		
L_end__OS_EnterWaitMode:
	RETURN      0
; end of __OS_EnterWaitMode

__OS_EnterWaitModeTO:

;osa_pic18_mikroc.c,181 :: 		
;osa_pic18_mikroc.c,183 :: 		
	MOVLW       255
	MOVWF       __OS_Temp+0 
;osa_pic18_mikroc.c,184 :: 		
	CALL        __OS_ClrReadySetClrCanContinue+0, 0
;osa_pic18_mikroc.c,185 :: 		
L_end__OS_EnterWaitModeTO:
	RETURN      0
; end of __OS_EnterWaitModeTO

__OS_ClrReadySetClrCanContinue:

;osa_pic18_mikroc.c,207 :: 		
;osa_pic18_mikroc.c,209 :: 		
	POP
;osa_pic18_mikroc.c,211 :: 		
	BCF         __OS_Flags+0, 0 
;osa_pic18_mikroc.c,213 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,214 :: 		
	MOVF        4093, 0 
	MOVWF       4076 
	MOVF        4094, 0 
	MOVWF       4076 
	MOVF        4095, 0 
	MOVWF       4076 
;osa_pic18_mikroc.c,215 :: 		
	BCF         __OS_State+0, 3 
;osa_pic18_mikroc.c,218 :: 		
	BTFSC       __OS_State+0, 4 
	GOTO        L__OS_ClrReadySetClrCanContinue0
	BCF         __OS_State+0, 5 
L__OS_ClrReadySetClrCanContinue0:
;osa_pic18_mikroc.c,219 :: 		
	BTFSS       __OS_Temp+0, 0 
	GOTO        L__OS_ClrReadySetClrCanContinue1
	BSF         __OS_State+0, 5 
L__OS_ClrReadySetClrCanContinue1:
;osa_pic18_mikroc.c,222 :: 		
L_end__OS_ClrReadySetClrCanContinue:
	RETURN      0
; end of __OS_ClrReadySetClrCanContinue

__OS_SET_FSR_CUR_TASK:

;osa_pic18_mikroc.c,242 :: 		
;osa_pic18_mikroc.c,244 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR0L 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR0H 
;osa_pic18_mikroc.c,245 :: 		
L_end__OS_SET_FSR_CUR_TASK:
	RETURN      0
; end of __OS_SET_FSR_CUR_TASK

_OS_DI:

;osa_pic18_mikroc.c,281 :: 		
;osa_pic18_mikroc.c,284 :: 		
	MOVLW       192
	ANDWF       4082, 0 
	MOVWF       R1 
;osa_pic18_mikroc.c,285 :: 		
	BCF         GIE_bit+0, 7 
;osa_pic18_mikroc.c,286 :: 		
	BTFSS       IPEN_bit+0, 7 
	GOTO        L_OS_DI2
	BCF         GIEL_bit+0, 6 
L_OS_DI2:
;osa_pic18_mikroc.c,287 :: 		
	MOVF        R1, 0 
	MOVWF       R0 
;osa_pic18_mikroc.c,288 :: 		
L_end_OS_DI:
	RETURN      0
; end of _OS_DI

_OS_RI:

;osa_pic18_mikroc.c,326 :: 		
;osa_pic18_mikroc.c,328 :: 		
	BTFSS       FARG_OS_RI_temp+0, 7 
	GOTO        L_OS_RI3
	BSF         GIE_bit+0, 7 
L_OS_RI3:
;osa_pic18_mikroc.c,329 :: 		
	BTFSS       IPEN_bit+0, 7 
	GOTO        L_OS_RI4
;osa_pic18_mikroc.c,331 :: 		
	BTFSS       FARG_OS_RI_temp+0, 6 
	GOTO        L_OS_RI5
	BSF         GIEL_bit+0, 6 
L_OS_RI5:
;osa_pic18_mikroc.c,332 :: 		
L_OS_RI4:
;osa_pic18_mikroc.c,333 :: 		
L_end_OS_RI:
	RETURN      0
; end of _OS_RI

__OS_CheckEvent:

;osa_pic18_mikroc.c,383 :: 		
;osa_pic18_mikroc.c,421 :: 		
	BCF         __OS_Flags+0, 5 
;osa_pic18_mikroc.c,422 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,424 :: 		
	MOVF        FARG__OS_CheckEvent_bEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__OS_CheckEvent6
;osa_pic18_mikroc.c,426 :: 		
	BTFSS       __OS_State+0, 3 
	GOTO        L__OS_CheckEvent7
;osa_pic18_mikroc.c,430 :: 		
	BCF         __OS_State+0, 4 
;osa_pic18_mikroc.c,431 :: 		
	BCF         4079, 4 
;osa_pic18_mikroc.c,436 :: 		
	BSF         __OS_Flags+1, 0 
;osa_pic18_mikroc.c,439 :: 		
	GOTO        L_end__OS_CheckEvent
;osa_pic18_mikroc.c,440 :: 		
L__OS_CheckEvent7:
;osa_pic18_mikroc.c,442 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,444 :: 		
	GOTO        L__OS_CheckEvent8
L__OS_CheckEvent6:
;osa_pic18_mikroc.c,445 :: 		
	BCF         __OS_State+0, 3 
;osa_pic18_mikroc.c,446 :: 		
L__OS_CheckEvent8:
;osa_pic18_mikroc.c,450 :: 		
	BTFSC       __OS_State+0, 4 
	GOTO        L__OS_CheckEvent11
	BTFSS       __OS_State+0, 5 
	GOTO        L__OS_CheckEvent11
L___OS_CheckEvent38:
;osa_pic18_mikroc.c,452 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,453 :: 		
	BSF         __OS_Flags+0, 5 
;osa_pic18_mikroc.c,456 :: 		
	BSF         __OS_Flags+1, 0 
;osa_pic18_mikroc.c,459 :: 		
	GOTO        L_end__OS_CheckEvent
;osa_pic18_mikroc.c,460 :: 		
L__OS_CheckEvent11:
;osa_pic18_mikroc.c,464 :: 		
	POP
;osa_pic18_mikroc.c,469 :: 		
L_end__OS_CheckEvent:
	RETURN      0
; end of __OS_CheckEvent

__OS_Stimer_GetFree:

;osa_stimer.c,93 :: 		
;osa_stimer.c,98 :: 		
	BCF         __OS_Flags+0, 1 
;osa_stimer.c,100 :: 		
	CLRF        R3 
L__OS_Stimer_GetFree12:
	MOVF        R3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L__OS_Stimer_GetFree13
;osa_stimer.c,102 :: 		
	MOVLW       __OS_StimersFree+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(__OS_StimersFree+0)
	MOVWF       FSR0H 
	MOVF        R3, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R5 
;osa_stimer.c,103 :: 		
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__OS_Stimer_GetFree15
;osa_stimer.c,105 :: 		
	BTFSC       FARG__OS_Stimer_GetFree_bCreate+0, 0 
	GOTO        L__OS_Stimer_GetFree16
	CLRF        R0 
	GOTO        L_end__OS_Stimer_GetFree
L__OS_Stimer_GetFree16:
;osa_stimer.c,107 :: 		
	MOVF        R3, 0 
	MOVWF       R4 
	RLCF        R4, 1 
	BCF         R4, 0 
	RLCF        R4, 1 
	BCF         R4, 0 
	RLCF        R4, 1 
	BCF         R4, 0 
;osa_stimer.c,108 :: 		
	MOVLW       1
	MOVWF       R6 
;osa_stimer.c,109 :: 		
L__OS_Stimer_GetFree17:
	MOVF        R6, 0 
	ANDWF       R5, 0 
	MOVWF       R0 
	BTFSS       STATUS+0, 2 
	GOTO        L__OS_Stimer_GetFree18
;osa_stimer.c,111 :: 		
	RLCF        R6, 1 
	BCF         R6, 0 
;osa_stimer.c,112 :: 		
	INCF        R4, 1 
;osa_stimer.c,113 :: 		
	GOTO        L__OS_Stimer_GetFree17
L__OS_Stimer_GetFree18:
;osa_stimer.c,114 :: 		
	MOVLW       __OS_StimersFree+0
	MOVWF       R1 
	MOVLW       hi_addr(__OS_StimersFree+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	COMF        R6, 0 
	MOVWF       R0 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;osa_stimer.c,115 :: 		
	MOVF        R4, 0 
	MOVWF       R0 
	GOTO        L_end__OS_Stimer_GetFree
;osa_stimer.c,116 :: 		
L__OS_Stimer_GetFree15:
;osa_stimer.c,100 :: 		
	INCF        R3, 1 
;osa_stimer.c,117 :: 		
	GOTO        L__OS_Stimer_GetFree12
L__OS_Stimer_GetFree13:
;osa_stimer.c,119 :: 		
	BSF         __OS_Flags+0, 1 
;osa_stimer.c,120 :: 		
	MOVLW       255
	MOVWF       R0 
;osa_stimer.c,121 :: 		
L_end__OS_Stimer_GetFree:
	RETURN      0
; end of __OS_Stimer_GetFree

__OS_Stimer_Free:

;osa_stimer.c,126 :: 		
;osa_stimer.c,128 :: 		
	MOVF        FARG__OS_Stimer_Free_ID+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       __OS_StimersFree+0
	MOVWF       R2 
	MOVLW       hi_addr(__OS_StimersFree+0)
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       R2, 1 
	BTFSC       STATUS+0, 0 
	INCF        R3, 1 
	MOVLW       7
	ANDWF       FARG__OS_Stimer_Free_ID+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L___OS_Stimer_Free51:
	BZ          L___OS_Stimer_Free52
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L___OS_Stimer_Free51
L___OS_Stimer_Free52:
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;osa_stimer.c,129 :: 		
L_end__OS_Stimer_Free:
	RETURN      0
; end of __OS_Stimer_Free

__OS_InitDelay:

;osa_ttimer.c,69 :: 		
;osa_ttimer.c,72 :: 		
	BCF         __OS_State+0, 5 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1L 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 4 
;osa_ttimer.c,77 :: 		
	MOVF        FARG__OS_InitDelay_Delay+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__OS_InitDelay19
;osa_ttimer.c,79 :: 		
	MOVLW       255
	XORWF       FARG__OS_InitDelay_Delay+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG__OS_InitDelay_Delay+0 
;osa_ttimer.c,80 :: 		
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG__OS_InitDelay_Delay+0 
;osa_ttimer.c,81 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       R0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       R1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
;osa_ttimer.c,82 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1L 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 3 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1L 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 4 
;osa_ttimer.c,87 :: 		
	BSF         __OS_State+0, 4 
;osa_ttimer.c,88 :: 		
	BSF         __OS_State+0, 3 
;osa_ttimer.c,90 :: 		
L__OS_InitDelay19:
;osa_ttimer.c,91 :: 		
L_end__OS_InitDelay:
	RETURN      0
; end of __OS_InitDelay

__OS_Csem_Signal:

;osa_csem.c,64 :: 		
;osa_csem.c,66 :: 		
	BCF         __OS_Flags+0, 0 
;osa_csem.c,68 :: 		
	MOVFF       FARG__OS_Csem_Signal_pCSem+0, FSR0L
	MOVFF       FARG__OS_Csem_Signal_pCSem+1, FSR0H
	MOVFF       FARG__OS_Csem_Signal_pCSem+0, FSR1L
	MOVFF       FARG__OS_Csem_Signal_pCSem+1, FSR1H
	INCF        POSTINC1+0, 1 
;osa_csem.c,69 :: 		
	MOVFF       FARG__OS_Csem_Signal_pCSem+0, FSR0L
	MOVFF       FARG__OS_Csem_Signal_pCSem+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__OS_Csem_Signal20
;osa_csem.c,71 :: 		
	MOVFF       FARG__OS_Csem_Signal_pCSem+0, FSR1L
	MOVFF       FARG__OS_Csem_Signal_pCSem+1, FSR1H
	MOVLW       255
	MOVWF       POSTINC1+0 
;osa_csem.c,72 :: 		
	BSF         __OS_Flags+0, 0 
;osa_csem.c,73 :: 		
L__OS_Csem_Signal20:
;osa_csem.c,74 :: 		
L_end__OS_Csem_Signal:
	RETURN      0
; end of __OS_Csem_Signal

_OS_Init:

;osa_system.c,67 :: 		
;osa_system.c,72 :: 		
	CLRF        __OS_Flags+0 
;osa_system.c,238 :: 		
	MOVLW       1
	MOVWF       __OS_StimersFree+0 
;osa_system.c,260 :: 		
	CLRF        __OS_Bsems+0 
;osa_system.c,326 :: 		
	BCF         __OS_Tasks+0, 6 
;osa_system.c,329 :: 		
	BCF         __OS_Tasks+6, 6 
;osa_system.c,380 :: 		
	MOVLW       __OS_Tasks+0
	MOVWF       __OS_CurTask+0 
	MOVLW       hi_addr(__OS_Tasks+0)
	MOVWF       __OS_CurTask+1 
;osa_system.c,381 :: 		
	MOVLW       2
	MOVWF       __OS_Temp+0 
;osa_system.c,382 :: 		
L_OS_Init21:
;osa_system.c,384 :: 		
	DECF        __OS_Temp+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskQueue+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;osa_system.c,385 :: 		
	DECF        __OS_Temp+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskLevel+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(__OS_TaskLevel+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;osa_system.c,386 :: 		
	DECF        __OS_Temp+0, 1 
	MOVF        __OS_Temp+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_OS_Init21
;osa_system.c,394 :: 		
L_end_OS_Init:
	RETURN      0
; end of _OS_Init

_OS_EnterCriticalSection:

;osa_system.c,444 :: 		
;osa_system.c,448 :: 		
	CALL        _OS_DI+0, 0
	MOVF        R0, 0 
	MOVWF       OS_EnterCriticalSection_temp_L0+0 
;osa_system.c,449 :: 		
	BSF         __OS_Flags+0, 2 
;osa_system.c,451 :: 		
	BCF         __OS_Flags+0, 6 
;osa_system.c,452 :: 		
	BTFSS       R0, 7 
	GOTO        L_OS_EnterCriticalSection24
	BSF         __OS_Flags+0, 6 
L_OS_EnterCriticalSection24:
;osa_system.c,454 :: 		
	BCF         __OS_Flags+0, 7 
;osa_system.c,455 :: 		
	BTFSS       OS_EnterCriticalSection_temp_L0+0, 6 
	GOTO        L_OS_EnterCriticalSection25
	BSF         __OS_Flags+0, 7 
L_OS_EnterCriticalSection25:
;osa_system.c,456 :: 		
L_end_OS_EnterCriticalSection:
	RETURN      0
; end of _OS_EnterCriticalSection

_OS_LeaveCriticalSection:

;osa_system.c,515 :: 		
;osa_system.c,518 :: 		
	BCF         __OS_Flags+0, 2 
;osa_system.c,519 :: 		
	CLRF        OS_LeaveCriticalSection_temp_L0+0 
;osa_system.c,520 :: 		
	BTFSS       __OS_Flags+0, 6 
	GOTO        L_OS_LeaveCriticalSection26
	BSF         OS_LeaveCriticalSection_temp_L0+0, 7 
L_OS_LeaveCriticalSection26:
;osa_system.c,521 :: 		
	BTFSS       __OS_Flags+0, 7 
	GOTO        L_OS_LeaveCriticalSection27
	BSF         OS_LeaveCriticalSection_temp_L0+0, 6 
L_OS_LeaveCriticalSection27:
;osa_system.c,522 :: 		
	MOVF        OS_LeaveCriticalSection_temp_L0+0, 0 
	MOVWF       FARG_OS_RI_temp+0 
	CALL        _OS_RI+0, 0
;osa_system.c,523 :: 		
L_end_OS_LeaveCriticalSection:
	RETURN      0
; end of _OS_LeaveCriticalSection

_OS_Timer:

;osa_system.c,568 :: 		
;osa_system.c,570 :: 		
	BTFSS       __OS_Tasks+0, 4 
	GOTO        L_OS_Timer28
	MOVF        __OS_Tasks+5, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Tasks+5 
	MOVF        __OS_Tasks+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_OS_Timer29
	BCF         __OS_Tasks+0, 4 
L_OS_Timer29:
L_OS_Timer28:
	BTFSS       __OS_Tasks+6, 4 
	GOTO        L_OS_Timer30
	MOVF        __OS_Tasks+11, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Tasks+11 
	MOVF        __OS_Tasks+11, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_OS_Timer31
	BCF         __OS_Tasks+6, 4 
L_OS_Timer31:
L_OS_Timer30:
	BTFSS       __OS_Stimers+0, 7 
	GOTO        L_OS_Timer32
	MOVF        __OS_Stimers+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Stimers+0 
L_OS_Timer32:
;osa_system.c,571 :: 		
L_end_OS_Timer:
	RETURN      0
; end of _OS_Timer

__OS_Task_Create:

;osa_tasks.c,75 :: 		
;osa_tasks.c,79 :: 		
	BCF         __OS_Flags+0, 1 
;osa_tasks.c,88 :: 		
	MOVLW       __OS_Tasks+0
	MOVWF       R1 
	MOVLW       hi_addr(__OS_Tasks+0)
	MOVWF       R2 
;osa_tasks.c,89 :: 		
	CLRF        __OS_Temp+0 
;osa_tasks.c,91 :: 		
L__OS_Task_Create33:
;osa_tasks.c,93 :: 		
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       R0, 6 
	GOTO        L__OS_Task_Create36
;osa_tasks.c,95 :: 		
	BSF         FARG__OS_Task_Create_priority+0, 6 
;osa_tasks.c,96 :: 		
	BSF         FARG__OS_Task_Create_priority+0, 3 
;osa_tasks.c,98 :: 		
	MOVLW       1
	ADDWF       R1, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	MOVF        FARG__OS_Task_Create_TaskAddr+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+3, 0 
	MOVWF       POSTINC1+0 
;osa_tasks.c,101 :: 		
	MOVLW       5
	ADDWF       R1, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;osa_tasks.c,108 :: 		
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        FARG__OS_Task_Create_priority+0, 0 
	MOVWF       POSTINC1+0 
;osa_tasks.c,111 :: 		
	MOVF        R2, 0 
	XORWF       __OS_CurTask+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L___OS_Task_Create60
	MOVF        __OS_CurTask+0, 0 
	XORWF       R1, 0 
L___OS_Task_Create60:
	BTFSS       STATUS+0, 2 
	GOTO        L__OS_Task_Create37
	MOVF        FARG__OS_Task_Create_priority+0, 0 
	MOVWF       __OS_State+0 
L__OS_Task_Create37:
;osa_tasks.c,126 :: 		
	BCF         __OS_Flags+0, 1 
;osa_tasks.c,128 :: 		
	GOTO        L_end__OS_Task_Create
;osa_tasks.c,130 :: 		
L__OS_Task_Create36:
;osa_tasks.c,132 :: 		
	MOVLW       6
	ADDWF       R1, 1 
	MOVLW       0
	ADDWFC      R2, 1 
;osa_tasks.c,134 :: 		
	INCF        __OS_Temp+0, 1 
	MOVLW       2
	SUBWF       __OS_Temp+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__OS_Task_Create33
;osa_tasks.c,137 :: 		
	BSF         __OS_Flags+0, 1 
;osa_tasks.c,139 :: 		
;osa_tasks.c,140 :: 		
L_end__OS_Task_Create:
	RETURN      0
; end of __OS_Task_Create
