/* Formatted on 27/1/2015 11:17:33 (QP5 v5.215.12089.38647) */
DROP TABLE VNP_DATA.HOT_RATED_CDR;

CREATE TABLESPACE vnp_data_hot_aggregated
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated01.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p0
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p0.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p1
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p1.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p2
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p2.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p3
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p3.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p4
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p4.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p5
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p5.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p6
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p6.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p7
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p7.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p8
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p8.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE TABLESPACE hot_aggregated_p9
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hot_aggregated_p9.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;


CREATE TABLE HOT_AGGREGATED_CDR
(
   A_NUMBER              VARCHAR2 (15 BYTE),
   DATA_PART             NUMBER (2),
   CDR_TYPE              NUMBER (2),
   AUT_FINAL_ID          NUMBER (6),
   BILL_MONTH            VARCHAR2 (4 BYTE),
   TOTAL_CDR             NUMBER (11),
   TOTAL_USAGE           NUMBER (15, 3),
   SERVICE_FEE           NUMBER (15, 3),
   CHARGE_FEE            NUMBER (31, 3),
   OFFER_COST            NUMBER (15, 3),
   OFFER_FREE_BLOCK      NUMBER (11),
   INTERNAL_COST         NUMBER (15, 3),
   INTERNAL_FREE_BLOCK   NUMBER (11),
   PAYMENT_ID            NUMBER (6),
   INTL_VND              NUMBER (15, 3)
)
TABLESPACE VNP_DATA_HOT_AGGREGATED
PARTITION BY RANGE (DATA_PART)
   (PARTITION P0 VALUES LESS THAN (1)
       TABLESPACE hot_aggregated_p0,
    PARTITION P1 VALUES LESS THAN (2)
       TABLESPACE hot_aggregated_p1,
    PARTITION P2 VALUES LESS THAN (3)
       TABLESPACE hot_aggregated_p2,
    PARTITION P3 VALUES LESS THAN (4)
       TABLESPACE hot_aggregated_p3,
    PARTITION P4 VALUES LESS THAN (5)
       TABLESPACE hot_aggregated_p4,
    PARTITION P5 VALUES LESS THAN (6)
       TABLESPACE hot_aggregated_p5,
    PARTITION P6 VALUES LESS THAN (7)
       TABLESPACE hot_aggregated_p6,
    PARTITION P7 VALUES LESS THAN (8)
       TABLESPACE hot_aggregated_p7,
    PARTITION P8 VALUES LESS THAN (9)
       TABLESPACE hot_aggregated_p8,
    PARTITION P9 VALUES LESS THAN (10)
       TABLESPACE hot_aggregated_p9);

CREATE TABLESPACE vnp_data_hac_some1
  DATAFILE '/cdr/u01/app/oracle/oradata/eonerate/vnp_data/hac_some101.dbf'
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50 M MAXSIZE UNLIMITED;

CREATE INDEX idx_hac_some1
   ON HOT_AGGREGATED_CDR (A_NUMBER,
                          BILL_MONTH,
                          CDR_TYPE,
                          PAYMENT_ID)
   TABLESPACE vnp_data_hac_some1;

GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE
   ON HOT_AGGREGATED_CDR
   TO VNP_COMMON;

GRANT SELECT ON HOT_AGGREGATED_CDR TO VNP_VIEW;