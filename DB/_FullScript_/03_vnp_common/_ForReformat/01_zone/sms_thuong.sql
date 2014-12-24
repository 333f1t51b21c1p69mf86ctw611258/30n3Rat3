-- tam thoi coi la sms

SELECT glt_number, zone_name, part_of
  FROM pcat_filter.zone
 WHERE part_of NOT LIKE '%VAS%';