SELECT first_name || ' ' || last_name
FROM employees
WHERE employee_id = (
  SELECT manager_id
  FROM employees
  WHERE first_name = 'Nancy'
    AND last_name = 'Greenberg'
);