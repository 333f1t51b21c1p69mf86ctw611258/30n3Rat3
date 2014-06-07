DROP TABLE VNP_COMMON.TIME_MAP CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.TIME_MAP
(
  CALENDAR_ID          NUMBER(10)               NOT NULL,
  RESELLER_VERSION_ID  NUMBER(18)               NOT NULL,
  CALENDAR_TYPE        VARCHAR2(720 BYTE),
  CALENDAR_NAME        VARCHAR2(720 BYTE)       NOT NULL,
  DESCRIPTION          VARCHAR2(2160 BYTE)
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
