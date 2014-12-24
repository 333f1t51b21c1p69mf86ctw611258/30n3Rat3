CREATE TABLE reseller_version_tmp AS
SELECT * FROM reseller_version;

GRANT
SELECT ON cbs_owner.reseller_version_tmp TO elc_user;