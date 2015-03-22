DROP TABLE VNP_COMMON.SUBSCRIBER_CCC_TMP CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.SUBSCRIBER_CCC_TMP
(
  STT          NUMBER,
  CC_NAME      NVARCHAR2(50),
  CC_GROUP_ID  INTEGER,
  MSISDN       VARCHAR2(20 BYTE),
  MEMBER_TYPE  INTEGER
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


GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_COMMON.SUBSCRIBER_CCC_TMP TO VNP_DATA;

GRANT SELECT ON VNP_COMMON.SUBSCRIBER_CCC_TMP TO VNP_VIEW;
