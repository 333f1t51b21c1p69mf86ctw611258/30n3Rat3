DROP TABLE VNP_COMMON.ACCOUNT_VERSION_TMP CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.ACCOUNT_VERSION_TMP
(
  ACCOUNT_VERSION_ID  NUMBER(23)                NOT NULL,
  FROM_DATE           DATE                      NOT NULL,
  TO_DATE             DATE,
  SUBSCRIBER_ID       NUMBER(15),
  ACCOUNT_ID          NUMBER(15),
  MODIFIED_DATE       DATE,
  EFFECTIVE_DATE      DATE
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


GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_COMMON.ACCOUNT_VERSION_TMP TO VNP_DATA;

GRANT SELECT ON VNP_COMMON.ACCOUNT_VERSION_TMP TO VNP_VIEW;
