DROP PROCEDURE VNP_DATA.ENABLE_TEMP_INDEX;

CREATE OR REPLACE PROCEDURE VNP_DATA.enable_temp_index(i_schema in varchar2 ,i_tablename in varchar2) as
  CURSOR  usr_idxs IS select INDEX_NAME from user_indexes where 
          TABLE_OWNER=i_schema and TABLE_NAME = i_tablename;          
  cur_idx  usr_idxs% ROWTYPE;
  
  v_sql  VARCHAR2(1024);

BEGIN
  OPEN usr_idxs;
  LOOP
    FETCH usr_idxs INTO cur_idx;
    EXIT WHEN NOT usr_idxs%FOUND;

    v_sql:= 'ALTER INDEX ' || cur_idx.index_name || ' REBUILD';
    EXECUTE IMMEDIATE v_sql;
    
  END LOOP;
  CLOSE usr_idxs;
  
END enable_temp_index;
/
