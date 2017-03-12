--±í·ÖÎö
DECLARE
  v_Sql VARCHAR2(1024);
  CURSOR c_Table IS SELECT Table_Name FROM User_Tables ORDER BY Table_Name;
BEGIN
  FOR R IN c_Table LOOP
    v_Sql := 'analyze table ' || R.Table_Name || ' compute statistics';
    execute immediate v_Sql;
  END LOOP;
END;
/
