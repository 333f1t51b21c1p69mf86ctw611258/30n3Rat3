/* Formatted on 1/30/2015 12:39:05 PM (QP5 v5.269.14213.34746) */
SET SERVEROUTPUT ON

DECLARE
BEGIN
   FOR i IN 0 .. 9
   LOOP
      EXECUTE IMMEDIATE
            'INSERT INTO hot_rated_cdr_1 PARTITION (p'
         || i
         || ') SELECT * FROM hot_rated_cdr_temp1 PARTITION (p'
         || i
         || ')';

      DBMS_OUTPUT.put_line ('OK: insert hot_rated_cdr_1 part: ' || i);

      EXECUTE IMMEDIATE
         'ALTER TABLE hot_rated_cdr_temp1 TRUNCATE PARTITION p' || i || '';

      DBMS_OUTPUT.put_line ('OK: truncate hot_rated_cdr_temp1 part: ' || i);
   END LOOP;

   FOR i IN 0 .. 9
   LOOP
      EXECUTE IMMEDIATE
            'INSERT INTO hot_rated_cdr_2 PARTITION (p'
         || i
         || ') SELECT * FROM hot_rated_cdr_temp2 PARTITION (p'
         || i
         || ')';

      DBMS_OUTPUT.put_line ('OK: insert hot_rated_cdr_2 part: ' || i);

      EXECUTE IMMEDIATE
         'ALTER TABLE hot_rated_cdr_temp2 TRUNCATE PARTITION p' || i || '';

      DBMS_OUTPUT.put_line ('OK: truncate hot_rated_cdr_temp2 part: ' || i);
   END LOOP;
END;
/