OPTIONS (DIRECT=FALSE,ERRORS=9999, PARALLEL=TRUE)
LOAD DATA
TRUNCATE
INTO TABLE vnp_data.first_temp_rated_cdr
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(a_number, cdr_type, created_time DATE "ddMMyyyyHH24MISS", cdr_start_time DATE "ddMMyyyyHH24MISS", duration, total_usage, b_number, b_zone, nw_group, service_fee, service_fee_id, charge_fee,
charge_fee_id, lac, cell_id, bu_id, old_bu_id, offer_cost, offer_free_block, internal_cost, internal_free_block,
dial_digit, cdr_record_header_id, cdr_sequence_number, location_no, rerate_flag, call_type_id, payment_item_id, msc_id, error_message)