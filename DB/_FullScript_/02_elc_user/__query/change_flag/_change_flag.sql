-- DROP TABLE ELC_USER.CHANGE_FLAG CASCADE CONSTRAINTS;

CREATE TABLE ELC_USER.CHANGE_FLAG
(
  IS_CHANGING  NUMBER(1)
);
Insert into ELC_USER.CHANGE_FLAG
   (IS_CHANGING)
 Values
   (0);
COMMIT;


GRANT SELECT ON ELC_USER.CHANGE_FLAG TO PCAT_FILTER;
