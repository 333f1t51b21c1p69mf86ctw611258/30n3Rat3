/* Formatted on 27/4/2014 14:59:50 (QP5 v5.227.12220.39754) */
BEGIN
   SYS.DBMS_SCHEDULER.DROP_JOB (
      job_name => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"');
END;
/

BEGIN
   DBMS_SCHEDULER.CREATE_JOB (
      job_name              => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
      job_type              => 'STORED_PROCEDURE',
      job_action            => 'ELC_USER.CBS_OWNER_FILTER.LETS_GO',
      number_of_arguments   => 1,
      start_date            => NULL,
      repeat_interval       => NULL,
      end_date              => NULL,
      enabled               => FALSE,
      auto_drop             => FALSE,
      comments              => '');

   DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
      job_name            => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
      argument_position   => 1,
      argument_value      => '2');


   DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
      attribute   => 'logging_level',
      VALUE       => DBMS_SCHEDULER.LOGGING_OFF);

   DBMS_SCHEDULER.enable (name => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"');
END;
/

BEGIN
   DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
      job_name            => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
      argument_position   => 1,
      argument_value      => '3');

   -- Run job synchronously.
   DBMS_SCHEDULER.run_job (
      job_name              => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
      use_current_session   => FALSE);
      
--   -- Stop jobs.
--   DBMS_SCHEDULER.stop_job (
--      job_name => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"');
END;
/