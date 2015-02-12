DROP TABLE VNP_COMMON.SUBSCRIBER CASCADE CONSTRAINTS;

CREATE TABLESPACE subs_p0
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p0.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p1
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p1.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p2
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p2.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p3
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p3.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p4
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p4.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p5
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p5.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p6
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p6.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p7
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p7.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p8
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p8.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLESPACE subs_p9
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_common/subs_p9.dbf'
    SIZE 200M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE 5 G;

CREATE TABLE VNP_COMMON.SUBSCRIBER
(
  SUBSCRIBER_ID           NUMBER(15)            NOT NULL,
  SUBSCRIBER_NO           VARCHAR2(31 BYTE)     NOT NULL,
  RATING_TYPE_ID          NUMBER(3)             NOT NULL,
  DATA_PART               NUMBER(2)             NOT NULL,
  C1_SUBSCRIBER_NO        NUMBER(15),
  C1_SUBSCRIBER_NO_RESET  NUMBER,
  ACCOUNT_ID              NUMBER,
  FROM_DATE               DATE,
  TO_DATE                 DATE,
  EFFECTIVE_DATE          DATE,
  MODIFIED_DATE           DATE                  DEFAULT current_date
)
NOCOMPRESS 
TABLESPACE VNP_COMMON
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
PARTITION BY RANGE (DATA_PART)
(  
  PARTITION P0 VALUES LESS THAN (1)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P1 VALUES LESS THAN (2)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P1
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P2 VALUES LESS THAN (3)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P2
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P3 VALUES LESS THAN (4)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P3
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P4 VALUES LESS THAN (5)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P4
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P5 VALUES LESS THAN (6)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P5
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P6 VALUES LESS THAN (7)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P6
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P7 VALUES LESS THAN (8)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P7
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P8 VALUES LESS THAN (9)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P8
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION P9 VALUES LESS THAN (10)
    LOGGING
    NOCOMPRESS 
    TABLESPACE SUBS_P9
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
)
NOCACHE
NOPARALLEL
MONITORING;


CREATE INDEX VNP_COMMON.IDX_SUBSCRIBER_ID ON VNP_COMMON.SUBSCRIBER
(SUBSCRIBER_ID)
LOGGING
TABLESPACE VNP_COMMON
PCTFREE    10
INITRANS   2
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
NOPARALLEL;

GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_COMMON.SUBSCRIBER TO VNP_DATA;

GRANT SELECT ON VNP_COMMON.SUBSCRIBER TO VNP_VIEW;
