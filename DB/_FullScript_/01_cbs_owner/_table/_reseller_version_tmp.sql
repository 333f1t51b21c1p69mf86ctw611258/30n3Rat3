/* Formatted on 05/12/2014 3:26:37 PM (QP5 v5.215.12089.38647) */
CREATE TABLE reseller_version_tmp
AS
   SELECT * FROM reseller_version;

TRUNCATE TABLE reseller_version_tmp;

INSERT INTO reseller_version_tmp
   SELECT * FROM reseller_version;

GRANT SELECT ON cbs_owner.reseller_version_tmp TO elc_user;