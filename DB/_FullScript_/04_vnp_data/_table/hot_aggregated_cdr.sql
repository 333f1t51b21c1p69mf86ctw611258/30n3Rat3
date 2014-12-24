DROP TABLE VNP_DATA.HOT_AGGREGATED_CDR CASCADE CONSTRAINTS;

CREATE TABLE VNP_DATA.HOT_AGGREGATED_CDR
(
  A_NUMBER             VARCHAR2(15 BYTE),
  DATA_PART            NUMBER(2),
  CDR_TYPE             NUMBER(2),
  AUT_FINAL_ID         NUMBER(6),
  BILL_MONTH           VARCHAR2(4 BYTE),
  TOTAL_CDR            NUMBER(11),
  TOTAL_USAGE          NUMBER(15,3),
  SERVICE_FEE          NUMBER(15,3),
  CHARGE_FEE           NUMBER(15,3),
  OFFER_COST           NUMBER(15,3),
  OFFER_FREE_BLOCK     NUMBER(11),
  INTERNAL_COST        NUMBER(15,3),
  INTERNAL_FREE_BLOCK  NUMBER(11)
)
TABLESPACE AGGREGATE_CDR_TBS
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


CREATE INDEX VNP_DATA.HOT_AGGREGATED_A_NUMBER ON VNP_DATA.HOT_AGGREGATED_CDR
(A_NUMBER)
LOGGING
TABLESPACE AGGREGATE_CDR_IDX_TBS
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


CREATE INDEX VNP_DATA.HOT_AGGREGATED_BILL_MONTH ON VNP_DATA.HOT_AGGREGATED_CDR
(BILL_MONTH)
LOGGING
TABLESPACE AGGREGATE_CDR_IDX_TBS
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


CREATE INDEX VNP_DATA.HOT_AGGREGATED_CDR_TYPE ON VNP_DATA.HOT_AGGREGATED_CDR
(CDR_TYPE)
LOGGING
TABLESPACE AGGREGATE_CDR_IDX_TBS
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


CREATE INDEX VNP_DATA.HOT_AGGREGATED_DATA_PART ON VNP_DATA.HOT_AGGREGATED_CDR
(DATA_PART)
LOGGING
TABLESPACE VNP_DATA
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


CREATE INDEX VNP_DATA.HOT_AGGREGATED_PAYMENT_ITEM_ID ON VNP_DATA.HOT_AGGREGATED_CDR
(AUT_FINAL_ID)
LOGGING
TABLESPACE AGGREGATE_CDR_IDX_TBS
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


GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_DATA.HOT_AGGREGATED_CDR TO PCAT_FILTER;

GRANT DELETE, INSERT, SELECT, UPDATE ON VNP_DATA.HOT_AGGREGATED_CDR TO VNP_COMMON;
