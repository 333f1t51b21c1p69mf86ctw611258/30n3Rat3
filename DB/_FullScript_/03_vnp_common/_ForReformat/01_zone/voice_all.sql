/* Formatted on 4/3/2014 9:26:09 AM (QP5 v5.227.12220.39754) */
SELECT code, zone, nw_group
  FROM vnp_common.zone_map
 WHERE service_id = 2;

-- Tam thoi xem tat ca cac zone danh cho voice

SELECT glt_number, zone_name, part_of FROM pcat_filter.zone;