PUBLIC void MECHANISM_INITIALIZE(void);
PUBLIC void MECHANISM_CALIBRATE(unsigned char MechanismId);
PUBLIC void MECHANISM_MOVE(unsigned char MechanismId,unsigned short Distance); // mm
PUBLIC unsigned short MECHANISM_GET_POSITION(unsigned char MechanismId); //mm
PUBLIC unsigned char MECHANISM_CHECK_FAILURE(unsigned char MechanismId);