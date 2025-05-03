-- Create the procedure
CREATE OR REPLACE PROCEDURE replace_head_honcho(
  new_head_honcho_id_in      IN    employees.employee_id%TYPE,
  old_head_honcho_id_in      IN    employees.employee_id%TYPE
) IS
  l_new_head_manager_id   employees.manager_id%TYPE;
  l_old_head_manager_id   employees.manager_id%TYPE;
  l_new_head_honcho_name  VARCHAR2(50);
  l_old_head_honcho_name   VARCHAR2(50);
BEGIN
  -- Get the new head honcho's manager ID and name
  SELECT manager_id, first_name || ' ' || last_name
  INTO l_new_head_manager_id, l_new_head_honcho_name
  FROM employees
  WHERE employee_id = new_head_honcho_id_in;

  -- Get the old head honcho's manager ID and name
  SELECT manager_id, first_name || ' ' || last_name
  INTO l_old_head_manager_id, l_old_head_honcho_name
  FROM employees
  WHERE employee_id = old_head_honcho_id_in;

  -- Use CASE statement to handle different scenarios
  CASE 
    WHEN l_new_head_manager_id IS NULL THEN
      DBMS_OUTPUT.PUT_LINE(l_new_head_honcho_name || ' (employee_id: ' || new_head_honcho_id_in || ') is already a head honcho.');
    WHEN l_old_head_manager_id IS NULL THEN
      DBMS_OUTPUT.PUT_LINE(l_old_head_honcho_name || ' (employee_id: ' || old_head_honcho_id_in || ') is not a head honcho.');
    ELSE
      -- Update the employees' manager IDs
      UPDATE employees
      SET manager_id = old_head_honcho_id_in
      WHERE employee_id = new_head_honcho_id_in;

      UPDATE employees
      SET manager_id = NULL
      WHERE employee_id = old_head_honcho_id_in;

      DBMS_OUTPUT.PUT_LINE(l_new_head_honcho_name || ' now reports to ' || l_old_head_honcho_name || '.');
      DBMS_OUTPUT.PUT_LINE(l_old_head_honcho_name || ' is new head honcho.');
  END CASE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('One of the employee IDs is invalid.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END replace_head_honcho;
/

-- Test block to run the procedure
BEGIN
  -- First test with valid IDs
  replace_head_honcho(101, 102); -- Assuming 101 is Steven King and 102 is Lex De Haan
  -- Run the procedure again without changes
  replace_head_honcho(101, 102);

  -- Change IDs to 103 and 104 for the next test
  replace_head_honcho(103, 104); -- Assuming 103 is Bruce Ernst and 104 is another employee
END;
/
