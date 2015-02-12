/* Formatted on 12/28/2014 2:07:29 PM (QP5 v5.215.12089.38647) */
DROP TABLE VNP_DATA.RATED_CDR_DEV;

CREATE TABLESPACE rated_dev_p0
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p0.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p1
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p1.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p2
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p2.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p3
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p3.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p4
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p4.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p5
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p5.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p6
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p6.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p7
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p7.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p8
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p8.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE rated_dev_p9
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/rated_dev_p9.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;


CREATE TABLE RATED_CDR_DEV
(
   MAP_ID                 NUMBER (9),
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
   SERVICE_FEE            NUMBER (31, 3),
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
   RERATE_FLAG            NUMBER (2),
   AUT_FINAL_ID           NUMBER (6),
   TARIFF_PLAN_ID         NUMBER (6),
   ERROR_MESSAGE          VARCHAR2 (1023 BYTE)
)
PARTITION BY RANGE (DATA_PART)
   (PARTITION P0 VALUES LESS THAN (1)
       TABLESPACE rated_dev_p0,
    PARTITION P1 VALUES LESS THAN (2)
       TABLESPACE rated_dev_p1,
    PARTITION P2 VALUES LESS THAN (3)
       TABLESPACE rated_dev_p2,
    PARTITION P3 VALUES LESS THAN (4)
       TABLESPACE rated_dev_p3,
    PARTITION P4 VALUES LESS THAN (5)
       TABLESPACE rated_dev_p4,
    PARTITION P5 VALUES LESS THAN (6)
       TABLESPACE rated_dev_p5,
    PARTITION P6 VALUES LESS THAN (7)
       TABLESPACE rated_dev_p6,
    PARTITION P7 VALUES LESS THAN (8)
       TABLESPACE rated_dev_p7,
    PARTITION P8 VALUES LESS THAN (9)
       TABLESPACE rated_dev_p8,
    PARTITION P9 VALUES LESS THAN (10)
       TABLESPACE rated_dev_p9);