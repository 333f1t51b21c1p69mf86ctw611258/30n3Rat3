DROP TABLE VNP_DATA.HOT_AGGREGATED_CDR_HISTORY CASCADE CONSTRAINTS;

CREATE TABLE VNP_DATA.HOT_AGGREGATED_CDR_HISTORY
(
  A_NUMBER             VARCHAR2(15 BYTE),
  DATA_PART            NUMBER(2),
  CDR_TYPE             NUMBER(2),
  AUT_FINAL_ID         NUMBER(6),
  BILL_MONTH           VARCHAR2(4 BYTE),
  TOTAL_CDR            NUMBER(11),
  TOTAL_USAGE          NUMBER(15,3),
  SERVICE_FEE          NUMBER(15,3),
  CHARGE_FEE           NUMBER(31,3),
  OFFER_COST           NUMBER(15,3),
  OFFER_FREE_BLOCK     NUMBER(11),
  INTERNAL_COST        NUMBER(15,3),
  INTERNAL_FREE_BLOCK  NUMBER(11),
  PAYMENT_ID           NUMBER(6),
  INTL_VND             NUMBER(15,3)
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
