OPTIONS (DIRECT=FALSE,ERRORS=9999, PARALLEL=TRUE)
LOAD DATA
APPEND
INTO TABLE vnp_data.rated_rc
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
(subscriber_id, subscriber_no, product_offer_version_id, bill_month DATE "ddMMyyyy", rc, vat, currency_id, status_id, number_of_days, full_cycle)