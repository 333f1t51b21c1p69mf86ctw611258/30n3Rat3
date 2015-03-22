DROP PACKAGE VNP_COMMON.ELC_SUBS_OFFER_SYNC;

CREATE OR REPLACE PACKAGE VNP_COMMON.ELC_SUBS_OFFER_SYNC AS 

   v_SUB_ID SUBSCRIBER.SUBSCRIBER_ID%TYPE;

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  
  PROCEDURE ADD_NEW_SUB(inSUB_NO IN VARCHAR2,inOFFER_ID IN VARCHAR2,inRATING_TYPE IN INTEGER,inACTIVE_DATE IN DATE,inIN_ACTIVE_DATE IN DATE,inMODIFIED IN DATE,inEFFECTIVE_DATE IN DATE,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2); 
  PROCEDURE REMOVE_SUB(inSUB_NO IN VARCHAR2,inACTIVE_DATE IN DATE,inIN_ACTIVE_DATE IN DATE,inMODIFIED_DATE IN DATE,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2);
  PROCEDURE UPDATE_SUB_STATUS(inSUB_NO IN VARCHAR2,in_OLD_STATUS IN NUMBER,in_NEW_STATUS IN NUMBER,inMODIFIED_DATE IN DATE,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2);
  PROCEDURE ADD_NEW_OFFER(inSUB_NO IN VARCHAR2,inOFFER_ID IN VARCHAR2,inACTIVE_DATE IN DATE,inIN_ACTIVE_DATE IN DATE,inMODIFIED IN DATE,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2);
  PROCEDURE REMOVE_OFFER(inSUB_NO IN VARCHAR2,inOFFER_ID IN VARCHAR2,inACTIVE_DATE IN DATE,inIN_ACTIVE_DATE IN DATE,inMODIFIED_DATE IN DATE,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2);
  PROCEDURE ADD_CALLING_CIRCLE(inCALLING_CIRCLE_ID IN VARCHAR2,inCALLING_CIRCLE_NAME IN VARCHAR2, inMAX_SIZE IN INTEGER);
  PROCEDURE ADD_CALLING_CIRCLE_MEMBER(inCALLING_CIRCLE_ID IN VARCHAR2,inSUB_NO IN VARCHAR2,inMEMBER_TYPE IN INTEGER,inMODIFIED_DATE IN DATE,inSTATUS IN NUMBER,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2);
  PROCEDURE ADD_CALLING_CIRCLE_MEMBER_TMP(inCALLING_CIRCLE_ID IN VARCHAR2,inSUB_NO IN VARCHAR2,inMEMBER_TYPE IN INTEGER,inMODIFIED_DATE IN DATE,inSTATUS IN NUMBER,inC1_ACCOUNT IN VARCHAR2,inC1_SUBSCRIBER_NO IN VARCHAR2,inC1_SUBSCRIBER_NO_RESET IN VARCHAR2);
  PROCEDURE GET_LAST_SYNC_TIME(outSYNC_TIME OUT DATE);

  PROCEDURE UPDATE_LAST_SYNC_TIME_STATUS(inSYNCTIME IN DATE,status IN INTEGER);
  PROCEDURE ADD_NEW_ACCOUNT_OFFER(inACCOUNT_ID IN VARCHAR2,inOFFER_ID IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2,inOFFER_TYPE IN VARCHAR2,inACTIVE_DATE IN DATE, inIN_ACTIVE_DATE IN DATE);
  PROCEDURE REMOVE_ACCOUNT_OFFER(inACCOUNT_ID IN VARCHAR2,inOFFER_ID IN VARCHAR2,inC1_OFFER_INSTANCE_ID IN VARCHAR2,inOFFER_TYPE IN VARCHAR2,inACTIVE_DATE IN DATE, inIN_ACTIVE_DATE IN DATE);

  FUNCTION ADD_TIMES (in_DATE IN DATE, in_VALUE   IN NUMBER,in_TYPE    IN VARCHAR2) RETURN DATE;

  
END ELC_SUBS_OFFER_SYNC;
/
