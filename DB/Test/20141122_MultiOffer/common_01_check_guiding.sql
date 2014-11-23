/* Formatted on 21/11/2014 4:01:56 PM (QP5 v5.215.12089.38647) */
SELECT *
  FROM subscriber
 WHERE subscriber_no = '841247494428';

-- subscriber_id = 1923390

SELECT som.*, po.*
  FROM subs_offer_map som, product_offer po
 WHERE subscriber_id = 1923390 AND SOM.PRODUCT_OFFER_ID = PO.OFFER_ID;

SELECT *
  FROM product_offer
 WHERE offer_name = 'PO_Mobile_Postpaid_Standard';

-- offer_id  = 51004284

SELECT *
  FROM product_offer
 WHERE offer_name = 'SO_Mobile_Postpaid_Alo1 - 2500 phut_26';

-- offer_id = 51004657

SELECT *
  FROM product_offer
 WHERE offer_name = 'SO_Mobile_Postpaid_Goi phu 300SMS noi mang_450';

-- offer_id = 51004508

-- aaa bbb