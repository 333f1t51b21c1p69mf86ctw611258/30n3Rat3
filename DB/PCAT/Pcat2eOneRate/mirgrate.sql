/* Formatted on 27/03/2014 09:39:43 (QP5 v5.215.12089.38647) */
CREATE TABLE accumulator
AS
   SELECT * FROM accumulator@vnp_pcat_elc_user;

SELECT * FROM accumulator;


CREATE TABLE balance
AS
   SELECT * FROM balance@vnp_pcat_elc_user;

SELECT * FROM balance;


CREATE TABLE currency_type
AS
   SELECT * FROM currency_type@vnp_pcat_elc_user;

SELECT * FROM currency_type;



DROP TABLE discount_model;

CREATE TABLE discount_model
AS
   SELECT * FROM discount_model@vnp_pcat_elc_user;

SELECT * FROM discount_model;


CREATE TABLE offer_balance_map
AS
   SELECT * FROM offer_balance_map@vnp_pcat_elc_user;

SELECT * FROM offer_balance_map;


CREATE TABLE product_offer
AS
   SELECT * FROM product_offer@vnp_pcat_elc_user;

SELECT * FROM product_offer;


CREATE TABLE promo_map
AS
   SELECT * FROM promo_map@vnp_pcat_elc_user;

SELECT * FROM promo_map;


CREATE TABLE rum_map
AS
   SELECT * FROM rum_map@vnp_pcat_elc_user;

SELECT * FROM rum_map;


CREATE TABLE tariff_model
AS
   SELECT * FROM tariff_model@vnp_pcat_elc_user;

SELECT * FROM tariff_model;


CREATE TABLE tariff_plan
AS
   SELECT * FROM tariff_plan@vnp_pcat_elc_user;

SELECT * FROM tariff_plan;



CREATE TABLE time_map
AS
   SELECT * FROM time_map@vnp_pcat_elc_user;

SELECT * FROM time_map;



CREATE TABLE time_model
AS
   SELECT * FROM time_model@vnp_pcat_elc_user;

SELECT * FROM time_model;


CREATE TABLE unit_type
AS
   SELECT * FROM unit_type@vnp_pcat_elc_user;

SELECT * FROM unit_type;



CREATE TABLE usage_activity
AS
   SELECT * FROM usage_activity@vnp_pcat_elc_user;

SELECT * FROM usage_activity;


CREATE TABLE usage_activity_group
AS
   SELECT * FROM usage_activity_group@vnp_pcat_elc_user;

SELECT * FROM usage_activity_group;



CREATE TABLE usage_plan
AS
   SELECT * FROM usage_plan@vnp_pcat_elc_user;

SELECT * FROM usage_plan;



CREATE TABLE zone
AS
   SELECT * FROM zone@vnp_pcat_elc_user;

SELECT * FROM zone;


DROP TABLE zone_group;

CREATE TABLE zone_group
AS
   SELECT * FROM zone_group@vnp_pcat_elc_user;

SELECT * FROM zone_group;