/* Formatted on 3/31/2014 10:40:42 AM (QP5 v5.215.12089.38647) */
--CREATE DATABASE LINK pcat_pcat_filter
--   CONNECT TO pcat_filter IDENTIFIED BY pcat_filter
--   USING 'ELC_7_210_PCAT';

CREATE TABLE accumulator
AS
   SELECT * FROM elc_user.accumulator@pcat_pcat_filter;


CREATE TABLE balance
AS
   SELECT * FROM elc_user.balance@pcat_pcat_filter;


CREATE TABLE currency_type
AS
   SELECT * FROM elc_user.currency_type@pcat_pcat_filter;


CREATE TABLE discount_model
AS
   SELECT * FROM elc_user.discount_model@pcat_pcat_filter;


CREATE TABLE offer_balance_map
AS
   SELECT * FROM elc_user.offer_balance_map@pcat_pcat_filter;


CREATE TABLE product_offer
AS
   SELECT * FROM elc_user.product_offer@pcat_pcat_filter;


CREATE TABLE promo_map
AS
   SELECT * FROM elc_user.promo_map@pcat_pcat_filter;


CREATE TABLE reseller_version
AS
   SELECT * FROM elc_user.reseller_version@pcat_pcat_filter;


CREATE TABLE rum_map
AS
   SELECT * FROM elc_user.rum_map@pcat_pcat_filter;


CREATE TABLE tariff_model
AS
   SELECT * FROM elc_user.tariff_model@pcat_pcat_filter;


CREATE TABLE tariff_plan
AS
   SELECT * FROM elc_user.tariff_plan@pcat_pcat_filter;


CREATE TABLE time_map
AS
   SELECT * FROM elc_user.time_map@pcat_pcat_filter;


CREATE TABLE time_model
AS
   SELECT * FROM elc_user.time_model@pcat_pcat_filter;


CREATE TABLE unit_type
AS
   SELECT * FROM elc_user.unit_type@pcat_pcat_filter;


CREATE TABLE usage_activity
AS
   SELECT * FROM elc_user.usage_activity@pcat_pcat_filter;


CREATE TABLE usage_activity_group
AS
   SELECT * FROM elc_user.usage_activity_group@pcat_pcat_filter;


CREATE TABLE usage_plan
AS
   SELECT * FROM elc_user.usage_plan@pcat_pcat_filter;


CREATE TABLE zone
AS
   SELECT * FROM elc_user.zone@pcat_pcat_filter;


CREATE TABLE zone_group
AS
   SELECT * FROM elc_user.zone_group@pcat_pcat_filter;