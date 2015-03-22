DROP TABLE VNP_COMMON.RATING_TYPE CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.RATING_TYPE
(
  RATING_TYPE_ID  NUMBER(3)                     NOT NULL,
  TYPE_NAME       VARCHAR2(63 BYTE)             NOT NULL,
  UNBILL          CHAR(1 BYTE)
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
