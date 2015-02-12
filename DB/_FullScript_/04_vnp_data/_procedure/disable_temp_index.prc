DROP PROCEDURE VNP_DATA.DISABLE_TEMP_INDEX;

CREATE OR REPLACE PROCEDURE VNP_DATA.disable_temp_index(i_schema in varchar2 ,i_tablename in varchar2) as
  CURSOR  usr_idxs IS select INDEX_NAME from user_indexes where 
          upper(TABLE_OWNER)=upper(i_schema) and upper(TABLE_NAME) = UPPER(i_tablename);          
  cur_idx  usr_idxs% ROWTYPE;
  
  v_sql  VARCHAR2(1024);

BEGIN
  OPEN usr_idxs;
  LOOP
    FETCH usr_idxs INTO cur_idx;
    EXIT WHEN NOT usr_idxs%FOUND;

    v_sql:= 'ALTER INDEX ' || cur_idx.index_name || ' UNUSABLE';
    EXECUTE IMMEDIATE v_sql;
  END LOOP;
  CLOSE usr_idxs;
END disable_temp_index;
/
