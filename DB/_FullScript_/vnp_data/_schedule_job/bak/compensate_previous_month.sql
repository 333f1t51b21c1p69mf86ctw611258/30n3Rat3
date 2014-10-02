/* Formatted on 6/6/2014 11:19:11 (QP5 v5.227.12220.39754) */
DECLARE
   v_interval   INTEGER := 5;
BEGIN
   DBMS_SCHEDULER.create_job (
      job_name          => 'COMPENSATE_PREVIOUS_MONTH',
      job_type          => 'PLSQL_BLOCK',
      job_action        => 'begin STUFF.COMPENSATE_PREVIOUS_MONTH; end;',
      start_date        => SYSDATE,
      repeat_interval   =>    'FREQ=MINUTELY; BYMONTHDAY=1; INTERVAL='
                           || v_interval
                           || ';',
      end_date          => NULL,
      enabled           => TRUE,
      comments          => 'Compensate previous month');
END;
/

BEGIN
   -- Run job synchronously.
   DBMS_SCHEDULER.run_job (job_name              => 'COMPENSATE_PREVIOUS_MONTH',
                           use_current_session   => FALSE);
-- Stop jobs.
-- DBMS_SCHEDULER.stop_job (job_name => 'billing_daily_provisioning, test_prog_sched_job_definition');
END;
/

BEGIN
   DBMS_SCHEDULER.DROP_JOB (JOB_NAME => 'COMPENSATE_PREVIOUS_MONTH');
END;