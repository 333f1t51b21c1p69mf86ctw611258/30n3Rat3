DROP PROCEDURE VNP_DATA.TODAY_IS;

CREATE OR REPLACE PROCEDURE VNP_DATA.today_is AS
BEGIN
-- display the current system date in long format
  DBMS_OUTPUT.PUT_LINE( 'Today is ' || TO_CHAR(SYSDATE, 'DL') );
END today_is;
/
