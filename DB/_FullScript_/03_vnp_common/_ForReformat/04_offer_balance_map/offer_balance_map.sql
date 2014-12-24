/* Formatted on 23/4/2014 08:53:59 (QP5 v5.227.12220.39754) */
SELECT (balance_id || '_' || product_offer_version_id) key,
       offer_cost,
       internal_cost,
       rerate_flag
  FROM vnp_common.po_balance_map;


ALTER TABLE PCAT_FILTER.PRODUCT_OFFER
ADD (IS_INTERNAL NUMBER(1) DEFAULT 0);


SELECT (obm.balance_id || '_' || po.offer_id) key, po.is_internal
  FROM pcat_filter.product_offer po
       INNER JOIN pcat_filter.offer_balance_map obm
          ON (obm.offer_id = po.offer_id);