/* Formatted on 31/12/2014 11:36:14 (QP5 v5.215.12089.38647) */
SELECT table_name, constraint_name FROM user_constraints;

DECLARE
   CURSOR aaa
   IS
      SELECT table_name, constraint_name FROM user_constraints;

   c1rec   aaa%ROWTYPE;
   temp    VARCHAR2 (63);
BEGIN
   OPEN aaa;

   LOOP
      FETCH aaa INTO c1rec;

      EXIT WHEN aaa%NOTFOUND;

      SELECT SUBSTR (c1rec.constraint_name, -3, 3) INTO temp FROM DUAL;

      IF temp = '_FK'
      THEN
         EXECUTE IMMEDIATE
               'ALTER TABLE '
            || c1rec.table_name
            || ' DROP CONSTRAINT '
            || c1rec.constraint_name;
      END IF;
   END LOOP;

   CLOSE aaa;
END;