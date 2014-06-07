DROP TABLE VNP_COMMON.BUSINESS_UNIT CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.BUSINESS_UNIT
(
  BU_ID    VARCHAR2(7 BYTE)                     NOT NULL,
  BU_NAME  VARCHAR2(127 BYTE)                   NOT NULL
)
TABLESPACE PCAT_FILTER
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
