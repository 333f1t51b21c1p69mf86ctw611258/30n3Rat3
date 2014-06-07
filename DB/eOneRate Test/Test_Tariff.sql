/* Formatted on 22/05/2014 16:37:31 (QP5 v5.227.12220.39754) */
SELECT *
  FROM vnp_data.hot_rated_cdr
 WHERE a_number = '84914632111';

SELECT *
  FROM vnp_data.rated_cdr
 WHERE a_number = '84914632111';

SELECT *
  FROM subscriber
 WHERE subscriber_no = '84914632111';

SELECT *
  FROM PRODUCT_SELECT
 WHERE SUBSCRIBER_NO = '84914632111';

--51004286    PO_Data_Postpaid Broadband EZcom
--51004350    SO_Data_Postpaid_EZ50_Ipad

SELECT po_offer_id,
       po_offer_name,
       upsell_tmp_offer_id,
       upsell_tmp_offer_name,
       tariff_priority,
       discount_priority,
       balance_priority
  FROM offer_priority_view
 WHERE upsell_tmp_offer_id = 51004284 OR upsell_tmp_offer_id = 51004316;

SELECT offer_id, balance_name, amount
  FROM offer_balance_award_view
 WHERE offer_id = 51004284 OR offer_id = 51004316;

SELECT *
  FROM OFFER_BALANCE_AWARD_VIEW
 WHERE OFFER_ID = 51004284;

SELECT *
  FROM USAGE_PLAN_VIEW
 WHERE OFFER_ID = 51004286 AND UA_ID = 30378 AND TARIFF_PLAN_ID = 30137;

SELECT *
  FROM USAGE_PLAN_VIEW
 WHERE OFFER_ID = 51004284;

SELECT *
  FROM TARIFF_PLAN
 WHERE TARIFF_PLAN_ID = 30136;

SELECT *
  FROM rum_map
 WHERE tariff_plan_id = 30136;

SELECT *
  FROM tariff_model
 WHERE tariff_model_id = 107;

SELECT *
  FROM usage_activity
 WHERE ua_id = 30405;

SELECT *
  FROM promo_plan
 WHERE offer_id = 51004284;

SELECT *
  FROM discount_model_rating_view
 WHERE discount_item_id = 116;

INSERT INTO VNP_DATA.HOT_RATED_CDR_DEV
   SELECT *
     FROM VNP_DATA.HOT_RATED_CDR
    WHERE a_number = '84914632111' AND cdr_type = 7;