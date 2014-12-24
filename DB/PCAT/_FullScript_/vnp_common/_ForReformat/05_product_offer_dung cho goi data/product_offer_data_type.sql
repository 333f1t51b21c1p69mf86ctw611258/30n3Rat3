/* Formatted on 23/4/2014 08:54:28 (QP5 v5.227.12220.39754) */
SELECT b.product_offer_version_id,
       a.b_number_enrich zone,
       a.product_group_type nw_group
  FROM vnp_common.product_offer a, vnp_common.product_offer_version b
 WHERE     a.product_offer_id = b.product_offer_id
       AND (    a.b_number_enrich IS NOT NULL
            AND a.product_group_type IS NOT NULL);


SELECT a.offer_id, a.b_number_enrich zone, a.product_group_type nw_group
  FROM pcat_filter.product_offer a
 WHERE a.b_number_enrich IS NOT NULL AND a.product_group_type IS NOT NULL;