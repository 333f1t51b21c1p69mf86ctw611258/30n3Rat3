DROP TABLE ELC_USER.USAGE_ACTIVITY_GROUP CASCADE CONSTRAINTS;

CREATE TABLE ELC_USER.USAGE_ACTIVITY_GROUP
(
  UA_MAP_ID            NUMBER(10)               NOT NULL,
  UA_GROUP_NAME        VARCHAR2(240 BYTE)       NOT NULL,
  UA_GROUP_ID          NUMBER(6)                NOT NULL,
  UA_NAME              VARCHAR2(240 BYTE),
  UA_ID                NUMBER(10),
  RESELLER_VERSION_ID  NUMBER(18)               NOT NULL
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
