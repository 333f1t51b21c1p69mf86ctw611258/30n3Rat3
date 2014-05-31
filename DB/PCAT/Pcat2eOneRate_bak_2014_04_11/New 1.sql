/* Formatted on 4/3/2014 4:23:33 PM (QP5 v5.215.12089.38647) */
CREATE TABLE pcat_filter.business_unit
AS
   SELECT * FROM VNP_COMMON.BUSINESS_UNIT;

CREATE TABLE pcat_filter.customer
AS
   SELECT * FROM VNP_COMMON.BUSINESS_UNIT;

CREATE TABLE pcat_filter.prefix_enrich
AS
   SELECT * FROM vnp_common.prefix_enrich;

CREATE TABLE pcat_filter.subscriber_version
AS
   SELECT * FROM VNP_COMMON.SUBSCRIBER_VERSION;

CREATE TABLE pcat_filter.RC_TARIFF
AS
   SELECT * FROM vnp_common.RC_TARIFF;

SELECT * FROM pcat_filter.RC_TARIFF;

CREATE TABLE pcat_filter.rc_tariff_type
AS
   SELECT * FROM vnp_common.rc_tariff_type;

SELECT * FROM pcat_filter.rc_tariff_type;

