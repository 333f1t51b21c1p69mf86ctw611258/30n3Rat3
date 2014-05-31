/* Formatted on 29/05/2014 11:23:08 (QP5 v5.227.12220.39754) */
SET SERVEROUT ON SIZE 1000000
SET VERIFY OFF

SPOOL numrowspart_&&1..lst

DECLARE
   sql_stmt    VARCHAR2 (1024);

   row_count   NUMBER;

   CURSOR get_tab
   IS
      SELECT table_name, partition_name
        FROM dba_tab_partitions
       WHERE table_owner = UPPER ('&&1');

BEGIN
   DBMS_OUTPUT.put_line ('Checking Record Counts for schema &&1 ');
   DBMS_OUTPUT.put_line ('Log file to numrows_part_&&1.lst ....');
   DBMS_OUTPUT.put_line ('....');

   FOR get_tab_rec IN get_tab
   LOOP
      BEGIN
         sql_stmt :=
               'select count(*) from &&1..'
            || get_tab_rec.table_name
            || ' partition ( '
            || get_tab_rec.partition_name
            || ' )';

         EXECUTE IMMEDIATE sql_stmt INTO row_count;

         DBMS_OUTPUT.put_line (
               'Table '
            || RPAD (
                     get_tab_rec.table_name
                  || '('
                  || get_tab_rec.partition_name
                  || ')',
                  50)
            || ' '
            || TO_CHAR (row_count)
            || ' rows.');
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (
               'Error counting rows for table ' || get_tab_rec.table_name);
      END;
   END LOOP;
END;
/

SET VERIFY ON
SPOOL OFF