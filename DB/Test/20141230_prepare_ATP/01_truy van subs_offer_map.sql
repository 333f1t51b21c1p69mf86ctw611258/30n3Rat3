/* Formatted on 17/12/2014 6:02:39 PM (QP5 v5.215.12089.38647) */
-- 1.1: Thue bao dang ky 1 PO

  SELECT subscriber_id
    FROM vnp_common.subs_offer_map
GROUP BY subscriber_id
  HAVING COUNT (1) = 1;

-- 1.2: Lay ra subscriber info

SELECT *
  FROM vnp_common.subscriber
 WHERE subscriber_id = 1000037;


-- 2.1: Thue bao dang ky 1 SO: ALO

SELECT *
  FROM vnp_common.product_offer
 WHERE UPPER (offer_name) LIKE '%TALK24%' AND OFFER_TYPE = 'SO';

  SELECT subscriber_id
    FROM vnp_common.subs_offer_map som, vnp_common.product_offer po
   WHERE     som.product_offer_id = po.offer_id
         AND UPPER (offer_name) LIKE '%ALO%'
         AND PO.OFFER_TYPE = 'SO'
GROUP BY subscriber_id
  HAVING COUNT (1) = 1;

-- 3.1: Thue bao dang ky 1 goi: PO va 2 SO (ALO, iTouch)

  SELECT subscriber_id
    FROM vnp_common.subs_offer_map som, vnp_common.product_offer po
   WHERE     som.product_offer_id = po.offer_id
         AND (   UPPER (offer_name) LIKE '%ALO%'
              OR UPPER (offer_name) LIKE '%ITOUCH%')
         AND PO.OFFER_TYPE = 'SO'
GROUP BY subscriber_id
  HAVING COUNT (1) = 3;

-- 3.1: Thue bao dang ky 1 goi: PO va 2 SO (ALO, Talk24)

  SELECT subscriber_id
    FROM vnp_common.subs_offer_map som, vnp_common.product_offer po
   WHERE     som.product_offer_id = po.offer_id
         AND (   UPPER (offer_name) LIKE '%ALO%'
              OR UPPER (offer_name) LIKE '%TALK24%')
         AND PO.OFFER_TYPE = 'SO'
GROUP BY subscriber_id
  HAVING COUNT (1) = 3;

--

