/* Formatted on 17/3/15 09:24:01 (QP5 v5.240.12305.39476) */
DROP TABLE RATED_CDR;

CREATE TABLESPACE rated_p0
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p0.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p1
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p1.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p2
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p2.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p3
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p3.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p4
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p4.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p5
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p5.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p6
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p6.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p7
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p7.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p8
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p8.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_p9
  DATAFILE '+DATA/orcl/datafile/vnp_data/rated_p9.dbf'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10 M MAXSIZE UNLIMITED;

CREATE TABLE RATED_CDR
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
   QOS                    VARCHAR2 (15 BYTE),
   ERROR_MESSAGE          VARCHAR2 (1023 BYTE)
)
PARTITION BY RANGE (DATA_PART)
   (PARTITION P0 VALUES LESS THAN (1)
       TABLESPACE rated_p0,
    PARTITION P1 VALUES LESS THAN (2)
       TABLESPACE rated_p1,
    PARTITION P2 VALUES LESS THAN (3)
       TABLESPACE rated_p2,
    PARTITION P3 VALUES LESS THAN (4)
       TABLESPACE rated_p3,
    PARTITION P4 VALUES LESS THAN (5)
       TABLESPACE rated_p4,
    PARTITION P5 VALUES LESS THAN (6)
       TABLESPACE rated_p5,
    PARTITION P6 VALUES LESS THAN (7)
       TABLESPACE rated_p6,
    PARTITION P7 VALUES LESS THAN (8)
       TABLESPACE rated_p7,
    PARTITION P8 VALUES LESS THAN (9)
       TABLESPACE rated_p8,
    PARTITION P9 VALUES LESS THAN (10)
       TABLESPACE rated_p9);

CREATE TABLESPACE vnp_data_RC_A_NUMBER
  DATAFILE '/u01/app/oracle/oradata/eonerate/vnp_data/RC_A_NUMBER01.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

DROP INDEX IDX_RC_A_NUMBER;

CREATE INDEX IDX_RC_A_NUMBER
   ON RATED_CDR (A_NUMBER)
   TABLESPACE vnp_data_RC_A_NUMBER;