DROP SEQUENCE VNP_COMMON.SUBSCRIBER_SEQ;

CREATE SEQUENCE VNP_COMMON.SUBSCRIBER_SEQ
  START WITH 950406
  MAXVALUE 999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
