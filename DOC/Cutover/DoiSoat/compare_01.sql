/* Formatted on 16/12/2014 4:49:02 PM (QP5 v5.215.12089.38647) */
CREATE TABLE vnp_0412_tmp
AS
   SELECT *
     FROM vnp_0412
    WHERE 1 = 2;

ALTER TABLE vnp_0412_tmp
ADD (
    record_id NUMBER(15)
);

  SELECT *
    FROM vnp_0412
ORDER BY a_number, cdr_start_time;

CREATE TABLE elc_0412_tmp
AS
   SELECT *
     FROM elc_0412
    WHERE 1 = 2;

ALTER TABLE elc_0412_tmp
ADD (
    record_id NUMBER(15)
);