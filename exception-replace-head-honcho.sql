CREATE OR REPLACE PROCEDURE replace_head_honcho(
  new_head_honcho_id_in      IN    employees.employee_id%TYPE,
  old_head_honcho_id_in      IN    employees.employee_id%TYPE,
  new_head_honcho_name_out   OUT   VARCHAR2,
  old_head_honcho_name_out   OUT   VARCHAR2
) IS
  l_new_head_manager_id         employees.manager_id%TYPE;
  l_old_head_manager_id         employees.manager_id%TYPE;
  employee_already_head_honcho  EXCEPTION;
  employee_not_head_honcho      EXCEPTION;
BEGIN
  -- Retrieve names
  SELECT first_name || ' ' || last_name
  INTO new_head_honcho_name_out
  FROM employees
  WHERE employee_id = new_head_honcho_id_in;
  
  SELECT first_name || ' ' || last_name
  INTO old_head_honcho_name_out
  FROM employees
  WHERE employee_id = old_head_honcho_id_in;

  -- Retrieve manager IDs
  SELECT manager_id
  INTO l_new_head_manager_id
  FROM employees
  WHERE employee_id = new_head_honcho_id_in;

  SELECT manager_id
  INTO l_old_head_manager_id
  FROM employees
  WHERE employee_id = old_head_honcho_id_in;

  -- Check conditions
  CASE
    WHEN l_new_head_manager_id IS NOT NULL THEN
      RAISE employee_already_head_honcho;
    WHEN l_old_head_manager_id IS NULL THEN
      RAISE employee_not_head_honcho;
    ELSE
      -- Update employees reporting to the old head honcho
      UPDATE employees
      SET manager_id = new_head_honcho_id_in
      WHERE manager_id = old_head_honcho_id_in;

      DBMS_OUTPUT.PUT_LINE('Successfully replaced ' || old_head_honcho_name_out ||
                           ' with ' || new_head_honcho_name_out || '.');
  END CASE;

EXCEPTION
  WHEN employee_already_head_honcho THEN
    RAISE_APPLICATION_ERROR(-20101,
              new_head_honcho_name_out ||
              ' (employee_id: ' || new_head_honcho_id_in ||
              ') is already a head honcho.');
  WHEN employee_not_head_honcho THEN
    RAISE_APPLICATION_ERROR(-20102,
              old_head_honcho_name_out ||
              ' (employee_id: ' || old_head_honcho_id_in ||
              ') is not a head honcho.');
END replace_head_honcho;
