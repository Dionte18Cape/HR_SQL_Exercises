-- Create the function here

DECLARE
  l_first_name    VARCHAR2(20);
  l_last_name     VARCHAR2(25);
  l_manager_name  VARCHAR2(50);
BEGIN
  l_first_name    := 'Nancy';
  l_last_name     := 'Greenberg';
  l_manager_name  := get_manager(l_first_name, l_last_name);

  DBMS_OUTPUT.PUT_LINE(l_manager_name || ' is the manager of ' ||
    l_first_name || ' ' || l_last_name || '.');
END;