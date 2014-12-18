/* Formatted on 13/12/2014 1:38:21 AM (QP5 v5.215.12089.38647) */
DROP TABLE VNP_COMMON.PRODUCT_OFFER CASCADE CONSTRAINTS;

ALTER TABLE VNP_COMMON.PRODUCT_OFFER
ADD (
  IS_INTERNAL               NUMBER(1) DEFAULT 0,
  RC                        NUMBER(15,3),
  NRC                       NUMBER(15,3),
  VAT_RATE                  NUMBER(15,3),
  UNBILL                    CHAR(1 BYTE)
);

CREATE TABLE VNP_COMMON.PRODUCT_OFFER
(
   OFFER_ID                   NUMBER (10) NOT NULL,
   OFFER_NAME                 VARCHAR2 (720 BYTE) NOT NULL,
   OFFER_TYPE                 VARCHAR2 (93 BYTE),
   RESELLER_VERSION_ID        NUMBER (18) NOT NULL,
   SALES_EFFECTIVE_TIME       DATE NOT NULL,
   SALES_EXPIRATION_TIME      DATE,
   CURRENCY_NAME              VARCHAR2 (720 BYTE),
   CURRENCY_CODE              NUMBER (6),
   UPSELL_TEMPLATE_ID         NUMBER (10),
   IS_INTERNAL                NUMBER (1) DEFAULT 0,
   RC                         NUMBER (15, 3),
   NRC                        NUMBER (15, 3),
   VAT_RATE                   NUMBER (15, 3),
   UNBILL                     CHAR (1 BYTE),
   AUTO_EXPIRATION_DURATION   NUMBER (6),
   AUTO_EXPIRATION_UNIT       VARCHAR2 (11 BYTE)
)
TABLESPACE VNP_COMMON
RESULT_CACHE (MODE DEFAULT)
PCTUSED 0
PCTFREE 10
INITRANS 1
MAXTRANS 255
STORAGE (INITIAL 64 K
         NEXT 1 M
         MINEXTENTS 1
         MAXEXTENTS UNLIMITED
         PCTINCREASE 0
         BUFFER_POOL DEFAULT
         FLASH_CACHE DEFAULT
         CELL_FLASH_CACHE DEFAULT)
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;


GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE
   ON VNP_COMMON.PRODUCT_OFFER
   TO VNP_COMMON_PROP;

GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE
   ON VNP_COMMON.PRODUCT_OFFER
   TO VNP_DATA;