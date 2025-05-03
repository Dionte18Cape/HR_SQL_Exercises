CREATE OR REPLACE FUNCTION is_manager(
  employee_id_in IN employees.employee_id%TYPE  := NULL,
  first_name_in  IN employees.first_name%TYPE   := NULL,
  last_name_in   IN employees.last_name%TYPE    := NULL
)
RETURN BOOLEAN
IS
  l_num_reports NUMBER;
BEGIN
  IF employee_id_in IS NOT NULL THEN  
    SELECT COUNT(employee_id)
    INTO l_num_reports
    FROM employees
    WHERE manager_id = employee_id_in;

    RETURN l_num_reports > 0;
  ELSE
    SELECT COUNT(employee_id)
    INTO l_num_reports
    FROM employees
    WHERE manager_id = (
      SELECT employee_id
      FROM employees
      WHERE first_name = first_name_in
        AND last_name = last_name_in
      AND ROWNUM = 1 -- To ensure only one row is returned
    );

    RETURN l_num_reports > 0;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE; -- No employee found with the given name
  WHEN OTHERS THEN
    RETURN FALSE; -- Handle any other exceptions
END is_manager;
/

-- Test block to run the function
DECLARE
  l_is_manager BOOLEAN;
BEGIN
  l_is_manager := is_manager(104); -- Test with employee ID 104
  DBMS_OUTPUT.PUT_LINE('Employee ID 104 is a manager: ' || CASE WHEN l_is_manager THEN 'TRUE' ELSE 'FALSE' END);

  l_is_manager := is_manager(145); -- Test with employee ID 145
  DBMS_OUTPUT.PUT_LINE('Employee ID 145 is a manager: ' || CASE WHEN l_is_manager THEN 'TRUE' ELSE 'FALSE' END);

  l_is_manager := is_manager(NULL, 'Diana', 'Lorentz'); -- Test with name Diana Lorentz
  DBMS_OUTPUT.PUT_LINE('Diana Lorentz is a manager: ' || CASE WHEN l_is_manager THEN 'TRUE' ELSE 'FALSE' END);

  l_is_manager := is_manager(NULL, 'Eleni', 'Zlotkey'); -- Test with name Eleni Zlotkey
  DBMS_OUTPUT.PUT_LINE('Eleni Zlotkey is a manager: ' || CASE WHEN l_is_manager THEN 'TRUE' ELSE 'FALSE' END);
END;
/

