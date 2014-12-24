DROP TABLE VNP_DATA.RATED_CSV_FILE CASCADE CONSTRAINTS;

CREATE TABLE VNP_DATA.RATED_CSV_FILE
(
  FILE_NAME          VARCHAR2(127 BYTE)         NOT NULL,
  STATUS             CHAR(1 BYTE)               NOT NULL,
  CREATED_TIME       DATE                       DEFAULT sysdate,
  LAST_CHANGED_TIME  DATE                       DEFAULT sysdate,
  BAD_FILE           CHAR(1 BYTE),
  JVM_NAME           VARCHAR2(15 BYTE),
  PIPELINE_NAME      VARCHAR2(15 BYTE)
)
TABLESPACE VNP_DATA
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


CREATE INDEX VNP_DATA.CSV_FILE_FILE_NAME ON VNP_DATA.RATED_CSV_FILE
(FILE_NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
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
NOPARALLEL;


CREATE INDEX VNP_DATA.RATED_CSV_FILE_BAD_FILE ON VNP_DATA.RATED_CSV_FILE
(BAD_FILE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
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
NOPARALLEL;


CREATE INDEX VNP_DATA.RATED_CSV_FILE_CHANGED_TIME ON VNP_DATA.RATED_CSV_FILE
(LAST_CHANGED_TIME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
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
NOPARALLEL;


CREATE INDEX VNP_DATA.RATED_CSV_FILE_CREATED_TIME ON VNP_DATA.RATED_CSV_FILE
(CREATED_TIME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
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
NOPARALLEL;


CREATE INDEX VNP_DATA.RATED_CSV_FILE_STATUS ON VNP_DATA.RATED_CSV_FILE
(STATUS)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
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
NOPARALLEL;


GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_DATA.RATED_CSV_FILE TO PCAT_FILTER;

GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_DATA.RATED_CSV_FILE TO VNP_COMMON;
