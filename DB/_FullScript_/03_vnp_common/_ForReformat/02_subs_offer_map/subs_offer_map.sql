/* Formatted on 23/4/2014 08:58:13 (QP5 v5.227.12220.39754) */
SELECT a.product_offer_version_id, b.subscriber_no
  FROM vnp_common.subs_offer_map a, vnp_common.subscriber b
 WHERE a.subscriber_id = b.subscriber_id;

SELECT * FROM subs_offer_map;

SELECT * FROM PCAT_FILTER.SUBS_OFFER_MAP;

SELECT * FROM PCAT_FILTER.PRODUCT_OFFER;

SELECT * FROM subscriber;

-- lay toan bo goi cuoc cua thue bao dang su dung

SELECT a.product_offer_id, b.subscriber_no
  FROM pcat_filter.subs_offer_map a, pcat_filter.subscriber b
 WHERE a.subscriber_id = b.subscriber_id;

--CREATE TABLE pcat_filter.subs_offer_map
--AS
--   SELECT * FROM vnp_common.subs_offer_map;