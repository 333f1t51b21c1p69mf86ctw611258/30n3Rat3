DROP TABLE ELC_USER.ACCUMULATOR CASCADE CONSTRAINTS;

CREATE TABLE ELC_USER.ACCUMULATOR
(
  ACCUMULATOR_ID       NUMBER(10)               NOT NULL,
  ACCUMULATOR_NAME     VARCHAR2(240 BYTE)       NOT NULL,
  RESELLER_VERSION_ID  NUMBER(18)               NOT NULL,
  UNIT_TYPE_NAME       VARCHAR2(240 BYTE)       NOT NULL,
  UNIT_TYPE_ID         NUMBER(6)                NOT NULL,
  PERIOD_ID            VARCHAR2(71 BYTE),
  PERIOD_NAME          VARCHAR2(240 BYTE),
  RESET_POINT          NUMBER                   NOT NULL,
  TYPE_ID              VARCHAR2(65 BYTE),
  TYPE_NAME            VARCHAR2(240 BYTE),
  COUNT_TYPE_ID        VARCHAR2(65 BYTE),
  COUNT_TYPE_NAME      VARCHAR2(240 BYTE),
  DESCRIPTION          VARCHAR2(720 BYTE)
)
TABLESPACE ELC_USER
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          80K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
