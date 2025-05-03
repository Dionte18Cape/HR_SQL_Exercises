-- Create procedure
CREATE OR REPLACE PROCEDURE merge_departments(
  department_id_keep_in  IN   departments.department_id%TYPE,
  department_id_lose_in  IN   departments.department_id%TYPE,
  employees_merged_out   OUT  NUMBER
) IS
  integrity_constraint_violated EXCEPTION;
  PRAGMA EXCEPTION_INIT(integrity_constraint_violated, -2291);
  no_such_department_to_lose EXCEPTION;
BEGIN

  -- Will cause integrity_constraint_violated error if 
  -- no department_id is department_id_keep_in
  UPDATE employees
  SET department_id = department_id_keep_in
  WHERE department_id = department_id_lose_in;

  employees_merged_out := SQL%ROWCOUNT;

  UPDATE departments
  SET manager_id = NULL
  WHERE department_id = department_id_lose_in;
  
  IF SQL%NOTFOUND THEN
    RAISE no_such_department_to_lose;
  END IF;

EXCEPTION
  WHEN integrity_constraint_violated THEN
    RAISE_APPLICATION_ERROR(-20101, 'Cannot keep department ' ||
                  department_id_keep_in || '. Does not exist.');
  WHEN no_such_department_to_lose THEN
    RAISE_APPLICATION_ERROR(-20102, 'Cannot lose department ' ||
                  department_id_lose_in || '. Does not exist.');
  
END merge_departments;
-------Lines Omitted-------