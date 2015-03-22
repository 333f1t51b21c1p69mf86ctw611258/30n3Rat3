ALTER TABLE VNP_COMMON.CALLING_CIRCLE_MEMBER
 DROP PRIMARY KEY CASCADE;

DROP TABLE VNP_COMMON.CALLING_CIRCLE_MEMBER CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.CALLING_CIRCLE_MEMBER
(
  CALLING_CIRCLE_ID  NUMBER(15)                 NOT NULL,
  SUBSCRIBER_ID      NUMBER(20)                 NOT NULL,
  MEMBER_TYPE        NUMBER(3),
  STATUS_ID          NUMBER(3)                  NOT NULL,
  MODIFIED_DATE      DATE                       NOT NULL,
  CREATED_DATE       DATE                       DEFAULT CURRENT_DATE
)
TABLESPACE VNP_COMMON
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


ALTER TABLE VNP_COMMON.CALLING_CIRCLE_MEMBER ADD (
  CONSTRAINT CALLING_CIRCLE_MEMBER_PK
  PRIMARY KEY
  (CALLING_CIRCLE_ID, SUBSCRIBER_ID)
  DISABLE NOVALIDATE);

ALTER TABLE VNP_COMMON.CALLING_CIRCLE_MEMBER ADD (
  CONSTRAINT CALLING_CIRCLE_MEMBER_FK1 
  FOREIGN KEY (CALLING_CIRCLE_ID) 
  REFERENCES VNP_COMMON.CALLING_CIRCLE (CALLING_CIRCLE_ID)
  DISABLE NOVALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_COMMON.CALLING_CIRCLE_MEMBER TO VNP_DATA;

GRANT SELECT ON VNP_COMMON.CALLING_CIRCLE_MEMBER TO VNP_VIEW;
