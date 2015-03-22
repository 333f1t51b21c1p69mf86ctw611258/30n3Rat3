/* Formatted on 2/6/2015 11:10:18 AM (QP5 v5.269.14213.34746) */
DROP TABLE VNP_DATA.HOT_RATED_CDR CASCADE CONSTRAINTS;

select file_name from dba_data_files;

CREATE TABLESPACE VNP_DATA_HRC
  DATAFILE '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE VNP_DATA_HRC_P150201_0 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_0.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_1 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_1.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_2 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_2.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_3 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_3.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_4 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_4.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_5 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_5.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_6 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_6.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_7 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_7.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_8 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_8.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLESPACE VNP_DATA_HRC_P150201_9 DATAFILE
  '/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_cdr_P150201_9.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;


CREATE TABLE VNP_DATA.HOT_RATED_CDR
(
   MAP_ID                 NUMBER (15),
   A_NUMBER               VARCHAR2 (15 BYTE),
   CDR_TYPE               NUMBER (2),
   CREATED_TIME           DATE DEFAULT SYSDATE,
   CDR_START_TIME         DATE,
   DATA_PART              NUMBER (2),
   DURATION               NUMBER (11),
   TOTAL_USAGE            NUMBER (11),
   B_NUMBER               VARCHAR2 (31 BYTE),
   B_ZONE                 VARCHAR2 (127 BYTE),
   NW_GROUP               VARCHAR2 (15 BYTE),
   SERVICE_FEE            NUMBER (17, 3),
   SERVICE_FEE_ID         NUMBER (3),
   CHARGE_FEE             NUMBER (31, 3),
   CHARGE_FEE_ID          NUMBER (5),
   LAC                    VARCHAR2 (23 BYTE),
   CELL_ID                VARCHAR2 (23 BYTE),
   SUBSCRIBER_UNBILL      CHAR (2 BYTE),
   BU_ID                  VARCHAR2 (3 BYTE),
   OLD_BU_ID              VARCHAR2 (3 BYTE),
   OFFER_COST             NUMBER (15, 3),
   OFFER_FREE_BLOCK       NUMBER (21),
   INTERNAL_COST          NUMBER (15, 3),
   INTERNAL_FREE_BLOCK    NUMBER (11),
   DIAL_DIGIT             VARCHAR2 (31 BYTE),
   CDR_RECORD_HEADER_ID   NUMBER (11),
   CDR_SEQUENCE_NUMBER    NUMBER (11),
   LOCATION_NO            VARCHAR2 (31 BYTE),
   MSC_ID                 VARCHAR2 (31 BYTE),
   UNIT_TYPE_ID           NUMBER (2),
   PRIMARY_OFFER_ID       NUMBER (10),
   DISCOUNT_ITEM_ID       NUMBER (6),
   BALANCE_CHANGE         VARCHAR2 (500 BYTE),
   RERATE_FLAG            NUMBER (2),
   AUT_FINAL_ID           NUMBER (6),
   TARIFF_PLAN_ID         NUMBER (6),
   ERROR_CODE             VARCHAR2 (6 BYTE) DEFAULT 0,
   PAYMENT_ID             NUMBER (6),
   SUBSCRIBER_NO          NUMBER (31),
   SUBSCRIBER_NO_RESETS   NUMBER (7),
   ACCOUNT_NO             NUMBER (31),
   PARENT_ACCOUNT_NO      NUMBER (31),
   INTL_VND               NUMBER (31, 3),
   INTL_ID                NUMBER (7),
   CDR_CALL_TYPE          VARCHAR2 (7 BYTE),
   QOS                    VARCHAR2 (15 BYTE)
)
TABLESPACE VNP_DATA_HRC
PARTITION BY RANGE
   (CDR_START_TIME)
   SUBPARTITION BY RANGE (DATA_PART)
   (
      PARTITION
         P150201
         VALUES LESS THAN
            (TO_DATE (' 2015-02-02 00:00:00',
                      'SYYYY-MM-DD HH24:MI:SS',
                      'NLS_CALENDAR=GREGORIAN'))
         NOLOGGING
         NOCOMPRESS
         TABLESPACE VNP_DATA_HRC
         PCTFREE 10
         INITRANS 1
         MAXTRANS 255
         STORAGE (MAXSIZE UNLIMITED
                  BUFFER_POOL DEFAULT
                  FLASH_CACHE DEFAULT
                  CELL_FLASH_CACHE DEFAULT)
         (
            SUBPARTITION P150201_0
               VALUES LESS THAN (1)
               TABLESPACE VNP_DATA_HRC_P150201_0
            ,
            SUBPARTITION P150201_1
               VALUES LESS THAN (2)
               TABLESPACE VNP_DATA_HRC_P150201_1
            ,
            SUBPARTITION P150201_2
               VALUES LESS THAN (3)
               TABLESPACE VNP_DATA_HRC_P150201_2
            ,
            SUBPARTITION P150201_3
               VALUES LESS THAN (4)
               TABLESPACE VNP_DATA_HRC_P150201_3
            ,
            SUBPARTITION P150201_4
               VALUES LESS THAN (5)
               TABLESPACE VNP_DATA_HRC_P150201_4
            ,
            SUBPARTITION P150201_5
               VALUES LESS THAN (6)
               TABLESPACE VNP_DATA_HRC_P150201_5
            ,
            SUBPARTITION P150201_6
               VALUES LESS THAN (7)
               TABLESPACE VNP_DATA_HRC_P150201_6
            ,
            SUBPARTITION P150201_7
               VALUES LESS THAN (8)
               TABLESPACE VNP_DATA_HRC_P150201_7
            ,
            SUBPARTITION P150201_8
               VALUES LESS THAN (9)
               TABLESPACE VNP_DATA_HRC_P150201_8
            ,
            SUBPARTITION P150201_9
               VALUES LESS THAN (10)
               TABLESPACE VNP_DATA_HRC_P150201_9));


CREATE TABLESPACE VNP_DATA_HRC_A_NUMBER_IDX
  DATAFILE '/u01/app/oracle/oradata/eonerate/vnp_data/HRC_A_NUMBER_IDX01.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;


CREATE INDEX VNP_DATA.IDX_HRC_A_NUMBER
   ON VNP_DATA.HOT_RATED_CDR (A_NUMBER)
   TABLESPACE VNP_DATA_HRC_A_NUMBER_IDX;

GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE
   ON VNP_DATA.HOT_RATED_CDR
   TO VNP_COMMON;

GRANT SELECT ON VNP_DATA.HOT_RATED_CDR TO VNP_VIEW;