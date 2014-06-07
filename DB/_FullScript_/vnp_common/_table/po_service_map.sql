ALTER TABLE VNP_COMMON.PO_SERVICE_MAP
 DROP PRIMARY KEY CASCADE;

DROP TABLE VNP_COMMON.PO_SERVICE_MAP CASCADE CONSTRAINTS;

CREATE TABLE VNP_COMMON.PO_SERVICE_MAP
(
  PO_SERVICE_MAP_ID  NUMBER(11),
  SERVICE_ID         NUMBER(3)                  NOT NULL,
  PRODUCT_OFFER_ID   NUMBER(10)                 NOT NULL
)
TABLESPACE VNP_COMMON
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
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

COMMENT ON TABLE VNP_COMMON.PO_SERVICE_MAP IS 'Bang trung gian cua PRODUCT_OFFER va SERVICE';



CREATE UNIQUE INDEX VNP_COMMON.PO_SERVICE_MAP_PK ON VNP_COMMON.PO_SERVICE_MAP
(PO_SERVICE_MAP_ID)
LOGGING
TABLESPACE VNP_COMMON
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX VNP_COMMON.PO_SERVICE_MAP_PO_ID ON VNP_COMMON.PO_SERVICE_MAP
(PRODUCT_OFFER_ID)
LOGGING
TABLESPACE VNP_COMMON
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX VNP_COMMON.PO_SERVICE_MAP_SERVICE_ID ON VNP_COMMON.PO_SERVICE_MAP
(SERVICE_ID)
LOGGING
TABLESPACE VNP_COMMON
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


ALTER TABLE VNP_COMMON.PO_SERVICE_MAP ADD (
  CONSTRAINT PO_SERVICE_MAP_PK
  PRIMARY KEY
  (PO_SERVICE_MAP_ID)
  USING INDEX VNP_COMMON.PO_SERVICE_MAP_PK
  ENABLE VALIDATE);
