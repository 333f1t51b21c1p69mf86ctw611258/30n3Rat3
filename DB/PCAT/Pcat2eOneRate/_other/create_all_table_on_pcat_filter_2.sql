/* Formatted on 19/4/2014 12:59:06 (QP5 v5.227.12220.39754) */
-- DROP TABLE accumulator;

CREATE TABLE accumulator
AS
   SELECT * FROM elc_user.accumulator;

-- DROP TABLE balance;

CREATE TABLE balance
AS
   SELECT * FROM elc_user.balance;

-- DROP TABLE currency_type;

CREATE TABLE currency_type
AS
   SELECT * FROM elc_user.currency_type;

-- DROP TABLE discount_model;

CREATE TABLE discount_model
AS
   SELECT * FROM elc_user.discount_model;


-- DROP TABLE offer_accumulator_map;

CREATE TABLE offer_accumulator_map
AS
   SELECT * FROM elc_user.offer_accumulator_map;


-- DROP TABLE offer_balance_map;

CREATE TABLE offer_balance_map
AS
   SELECT * FROM elc_user.offer_balance_map;


-- DROP TABLE offer_rc_award_map;

CREATE TABLE offer_rc_award_map
AS
   SELECT * FROM elc_user.offer_rc_award_map;



-- DROP TABLE offer_priority;

CREATE TABLE offer_priority
AS
   SELECT * FROM elc_user.offer_priority;



-- DROP TABLE product_offer;

CREATE TABLE product_offer
AS
   SELECT * FROM elc_user.product_offer;


-- DROP TABLE promo_plan

CREATE TABLE promo_plan
AS
   SELECT * FROM elc_user.promo_plan;


-- DROP TABLE reseller_version;

CREATE TABLE reseller_version
AS
   SELECT * FROM elc_user.reseller_version;


-- DROP TABLE rum_map;

CREATE TABLE rum_map
AS
   SELECT * FROM elc_user.rum_map;


-- DROP TABLE tariff_model;

CREATE TABLE tariff_model
AS
   SELECT * FROM elc_user.tariff_model;



-- DROP TABLE tariff_plan;

CREATE TABLE tariff_plan
AS
   SELECT * FROM elc_user.tariff_plan;


-- DROP TABLE time_map;

CREATE TABLE time_map
AS
   SELECT * FROM elc_user.time_map;


-- DROP TABLE time_model;

CREATE TABLE time_model
AS
   SELECT * FROM elc_user.time_model;


-- DROP TABLE unit_type;

CREATE TABLE unit_type
AS
   SELECT * FROM elc_user.unit_type;


-- DROP TABLE usage_activity;

CREATE TABLE usage_activity
AS
   SELECT * FROM elc_user.usage_activity;

-- DROP TABLE usage_activity_trans;

CREATE TABLE usage_activity_trans
AS
   SELECT * FROM elc_user.usage_activity_trans;


-- DROP TABLE usage_activity_group;

CREATE TABLE usage_activity_group
AS
   SELECT * FROM elc_user.usage_activity_group;


-- DROP TABLE usage_plan;

CREATE TABLE usage_plan
AS
   SELECT * FROM elc_user.usage_plan;


-- DROP TABLE zone;

CREATE TABLE zone
AS
   SELECT * FROM elc_user.zone;


-- DROP TABLE zone_group;

CREATE TABLE zone_group
AS
   SELECT * FROM elc_user.zone_group;