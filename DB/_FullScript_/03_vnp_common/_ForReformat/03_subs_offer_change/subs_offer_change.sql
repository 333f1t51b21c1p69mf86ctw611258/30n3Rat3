/* Formatted on 23/4/2014 08:52:09 (QP5 v5.227.12220.39754) */
SELECT * FROM vnp_common.subs_offer_change;

DROP TABLE pcat_filter.subs_offer_change;

CREATE TABLE pcat_filter.subs_offer_change
AS
   SELECT *
     FROM vnp_common.subs_offer_change
    WHERE 1 = 2;

SELECT * FROM PCAT_FILTER.SUBS_OFFER_CHANGE;



SELECT a.product_offer_id,
       b.subscriber_no,
       c.change_type,
       c.MODIFIED_DATE
  FROM PCAT_FILTER.subs_offer_map a,
       PCAT_FILTER.subscriber b,
       PCAT_FILTER.subs_offer_change c
 WHERE     (a.subscriber_id = b.subscriber_id)
       AND (a.subscriber_id = c.subscriber_id)
       AND c.MODIFIED_DATE > SYSDATE - 100;