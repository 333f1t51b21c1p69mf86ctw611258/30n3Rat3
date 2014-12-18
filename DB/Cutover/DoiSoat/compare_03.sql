/* Formatted on 16/12/2014 4:49:45 PM (QP5 v5.215.12089.38647) */
  SELECT *
    FROM vnp_0412_tmp
ORDER BY a_number, record_id;

  SELECT *
    FROM elc_0412_tmp
ORDER BY a_number, record_id;

SELECT * FROM d_v_e_0412;

SELECT COUNT (1) FROM vnp_0412_tmp;

SELECT COUNT (1) FROM elc_0412_tmp;

SELECT COUNT (1) FROM d_v_e_0412;

DROP TABLE d_v_e_0412;

CREATE TABLE d_v_e_0412
AS
     SELECT v.a_number,
            v.b_number vnp_b_number,
            E.B_NUMBER elc_b_number,
            v.cdr_start_time vnp_start_time,
            e.cdr_start_time elc_start_time,
            (v.cdr_start_time - e.cdr_start_time) * 60 * 60 * 24 time_delta,
            v.duration vnp_duration,
            e.duration elc_duration,
            v.record_id vnp_record_id,
            e.record_id elc_record_id
       FROM    vnp_0412_tmp v
            FULL OUTER JOIN
               elc_0412_tmp e
            ON (v.a_number = e.a_number AND v.record_id = e.record_id)
   ORDER BY v.a_number, v.record_id;