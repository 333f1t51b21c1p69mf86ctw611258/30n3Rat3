DROP PROCEDURE VNP_DATA.MYPROC;

CREATE OR REPLACE PROCEDURE VNP_DATA.myproc
IS
   lockhandle   VARCHAR2 (128);
   retcode      NUMBER;
BEGIN
   DBMS_LOCK.ALLOCATE_UNIQUE ('myproclock', lockhandle);

   retcode :=
      DBMS_LOCK.REQUEST (lockhandle,
                         timeout    => 0,
                         lockmode   => DBMS_LOCK.x_mode);

   IF retcode <> 0
   THEN
      raise_application_error (-20000, 'myproc is already running');
   END IF;

   /* sleep so that we can test with a 2nd execution */
   DBMS_LOCK.sleep (1000);

   retcode := DBMS_LOCK.RELEASE (lockhandle);
END myproc;
/
