SET SERVEROUTPUT ON
DECLARE
  l_greeting VARCHAR2(10) := 'Hello';
  l_first_name VARCHAR2(20);
  l_last_name VARCHAR2(25);
BEGIN
  SELECT first_name, last_name
  INTO l_first_name, l_last_name
  FROM employees
  WHERE job_id = 'AD_PRES';

  DBMS_OUTPUT.PUT_LINE(l_greeting || ', ' ||
    l_first_name || ' ' || l_last_name || '!');
END;



SET SERVEROUTPUT ON
DECLARE
-- Declare and initialize variable 
    greeting VARCHAR2 (20);
    pi CONSTANT FLOAT := 3.14159;
BEGIN
    greeting := 'Hello, world!';
DBMS_OUTPUT.PUT_LINE(greeting || ' Have a great traing experience!' || ' pi: ' || pi);
END;