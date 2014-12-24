DROP TABLE ELC_USER.RESELLER_VERSION CASCADE CONSTRAINTS;

CREATE TABLE ELC_USER.RESELLER_VERSION
(
  RESELLER_VERSION_ID  NUMBER(18)               NOT NULL,
  RESELLER_ID          NUMBER(10)               NOT NULL,
  MAJOR_VERSION_NUM    NUMBER(10)               NOT NULL,
  MINOR_VERSION_NUM    NUMBER(10)               NOT NULL,
  ACTIVE_DATE          DATE                     NOT NULL,
  INACTIVE_DATE        DATE,
  SERVICE_VERSION_ID   NUMBER(18)               NOT NULL,
  STATUS               NUMBER(3)                NOT NULL,
  IS_NEW               NUMBER(1)                DEFAULT 0
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
