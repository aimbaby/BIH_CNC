
_HWI_DIGI_READ:

;HWI_DIGITAL.c,5 :: 		PUBLIC unsigned char HWI_DIGI_READ(unsigned char pin)
;HWI_DIGITAL.c,7 :: 		return (0);
	CLRF        R0 
;HWI_DIGITAL.c,8 :: 		}
L_end_HWI_DIGI_READ:
	RETURN      0
; end of _HWI_DIGI_READ

_HWI_DIGI_WRITE:

;HWI_DIGITAL.c,9 :: 		PUBLIC void HWI_DIGI_WRITE(unsigned char pin,unsigned char value)
;HWI_DIGITAL.c,11 :: 		}
L_end_HWI_DIGI_WRITE:
	RETURN      0
; end of _HWI_DIGI_WRITE
