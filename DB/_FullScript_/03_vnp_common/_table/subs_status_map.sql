DROP TABLE VNP_COMMON.SUBS_STATUS_MAP CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.SUBS_STATUS_MAP
(
  SUBSCRIBER_ID  NUMBER(15)                     NOT NULL,
  STATUS_ID      NUMBER(3)                      NOT NULL,
  START_DATE     DATE                           NOT NULL,
  END_DATE       DATE
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
