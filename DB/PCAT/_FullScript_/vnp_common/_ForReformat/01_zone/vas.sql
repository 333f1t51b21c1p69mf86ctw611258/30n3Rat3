/* Formatted on 4/3/2014 9:15:03 AM (QP5 v5.227.12220.39754) */
SELECT code, zone, nw_group
  FROM VNP_COMMON.ZONE_MAP
 WHERE service_id = 1 AND nw_group = 'VAS';


SELECT glt_number, zone_name, part_of
  FROM pcat_filter.zone
 WHERE part_of = 'VAS';