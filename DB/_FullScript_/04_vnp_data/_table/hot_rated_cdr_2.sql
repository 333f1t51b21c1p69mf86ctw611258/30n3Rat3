/* Formatted on 1/29/2015 11:32:43 AM (QP5 v5.215.12089.38647) */
DROP TABLE VNP_DATA.HOT_RATED_CDR_2;

CREATE TABLESPACE hot_rated_2_p0
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p0.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p1
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p1.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p2
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p2.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p3
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p3.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p4
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p4.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p5
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p5.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p6
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p6.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p7
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p7.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p8
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p8.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_rated_2_p9
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_rated_2_p9.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;


CREATE TABLE VNP_DATA.HOT_RATED_CDR_2
(
   MAP_ID                NUMBER(15),
  A_NUMBER              VARCHAR2(15 BYTE),
  CDR_TYPE              NUMBER(2),
  CREATED_TIME          DATE                    DEFAULT SYSDATE,
  CDR_START_TIME        DATE,
  DATA_PART             NUMBER(2),
  DURATION              NUMBER(11),
  TOTAL_USAGE           NUMBER(11),
  B_NUMBER              VARCHAR2(31 BYTE),
  B_ZONE                VARCHAR2(127 BYTE),
  NW_GROUP              VARCHAR2(15 BYTE),
  SERVICE_FEE           NUMBER(17,3),
  SERVICE_FEE_ID        NUMBER(3),
  CHARGE_FEE            NUMBER(31,3),
  CHARGE_FEE_ID         NUMBER(5),
  LAC                   VARCHAR2(23 BYTE),
  CELL_ID               VARCHAR2(23 BYTE),
  SUBSCRIBER_UNBILL     CHAR(2 BYTE),
  BU_ID                 VARCHAR2(3 BYTE),
  OLD_BU_ID             VARCHAR2(3 BYTE),
  OFFER_COST            NUMBER(15,3),
  OFFER_FREE_BLOCK      NUMBER(21),
  INTERNAL_COST         NUMBER(15,3),
  INTERNAL_FREE_BLOCK   NUMBER(11),
  DIAL_DIGIT            VARCHAR2(31 BYTE),
  CDR_RECORD_HEADER_ID  NUMBER(11),
  CDR_SEQUENCE_NUMBER   NUMBER(11),
  LOCATION_NO           VARCHAR2(31 BYTE),
  MSC_ID                VARCHAR2(31 BYTE),
  UNIT_TYPE_ID          NUMBER(2),
  PRIMARY_OFFER_ID      NUMBER(10),
  DISCOUNT_ITEM_ID      NUMBER(6),
  BALANCE_CHANGE        VARCHAR2(500 BYTE),
  RERATE_FLAG           NUMBER(2),
  AUT_FINAL_ID          NUMBER(6),
  TARIFF_PLAN_ID        NUMBER(6),
  ERROR_CODE            VARCHAR2(6 BYTE)        DEFAULT 0,
  PAYMENT_ID            NUMBER(6),
  SUBSCRIBER_NO         NUMBER(31),
  SUBSCRIBER_NO_RESETS  NUMBER(7),
  ACCOUNT_NO            NUMBER(31),
  PARENT_ACCOUNT_NO     NUMBER(31),
  INTL_VND              NUMBER(31,3),
  INTL_ID               NUMBER(7),
  CDR_CALL_TYPE         VARCHAR2(7 BYTE),
  QOS                   VARCHAR2(15 BYTE)
)
PARTITION BY RANGE (DATA_PART)
   (PARTITION P0 VALUES LESS THAN (1)
       TABLESPACE hot_rated_2_p0,
    PARTITION P1 VALUES LESS THAN (2)
       TABLESPACE hot_rated_2_p1,
    PARTITION P2 VALUES LESS THAN (3)
       TABLESPACE hot_rated_2_p2,
    PARTITION P3 VALUES LESS THAN (4)
       TABLESPACE hot_rated_2_p3,
    PARTITION P4 VALUES LESS THAN (5)
       TABLESPACE hot_rated_2_p4,
    PARTITION P5 VALUES LESS THAN (6)
       TABLESPACE hot_rated_2_p5,
    PARTITION P6 VALUES LESS THAN (7)
       TABLESPACE hot_rated_2_p6,
    PARTITION P7 VALUES LESS THAN (8)
       TABLESPACE hot_rated_2_p7,
    PARTITION P8 VALUES LESS THAN (9)
       TABLESPACE hot_rated_2_p8,
    PARTITION P9 VALUES LESS THAN (10)
       TABLESPACE hot_rated_2_p9);

CREATE TABLESPACE vnp_data_HRC_2_A_NUMBER
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/HRC_2_A_NUMBER01.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

DROP INDEX IDX_HRC_2_A_NUMBER;

CREATE INDEX IDX_HRC_2_A_NUMBER
   ON HOT_RATED_CDR_2 (A_NUMBER)
   TABLESPACE VNP_DATA_HRC;


CREATE TABLESPACE vnp_data_hrc_2_rec_head_id
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hrc_2_rec_head_id01.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE INDEX IDX_HRC_2_CDR_REC_HEAD_ID
   ON HOT_RATED_CDR_2 (CDR_RECORD_HEADER_ID)
   TABLESPACE vnp_data_hrc_2_rec_head_id;

CREATE TABLESPACE vnp_data_hrc_2_created_time
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hrc_2_created_time01.dbf'
    SIZE 100M
    REUSE
    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;

CREATE INDEX IDX_HRC_2_CREATED_TIME
   ON HOT_RATED_CDR_2 (CREATED_TIME)
   NOLOGGING
   TABLESPACE vnp_data_hrc_2_created_time;

--CREATE TABLESPACE vnp_data_hrc_2_rerate_flag
--  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hrc_2_rerate_flag01.dbf'
--    SIZE 100M
--    REUSE
--    AUTOEXTEND ON NEXT 100 M MAXSIZE UNLIMITED;
--
--CREATE INDEX IDX_HRC_2_rerate_flag
--   ON HOT_RATED_CDR_2 (rerate_flag)
--   NOLOGGING
--   TABLESPACE vnp_data_hrc_2_rerate_flag;

ALTER TABLE HOT_RATED_CDR_2 DISABLE ROW MOVEMENT;

ALTER TABLE HOT_RATED_CDR_2 SHRINK SPACE;

GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_DATA.HOT_RATED_CDR_2 TO VNP_COMMON;

GRANT SELECT ON VNP_DATA.HOT_RATED_CDR_2 TO VNP_VIEW;