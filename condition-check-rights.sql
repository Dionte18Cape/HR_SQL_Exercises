-- Write your check_rights() function here
CREATE OR REPLACE PROCEDURE check_rights(
  birth_date_in  IN  DATE,
  has_license_in IN  BOOLEAN
)
IS
  l_age FLOAT;
BEGIN
  l_age := get_age(birth_date_in);
  
  IF l_age >= 21 AND has_license_in THEN
    DBMS_OUTPUT.PUT_LINE('You can drive and drink, but don''t drink and drive.');
  ELSIF l_age >= 21 AND NOT has_license_in THEN
    DBMS_OUTPUT.PUT_LINE('You can drink, but cannot drive.');
  ELSIF l_age >= 16 AND l_age < 21 AND has_license_in THEN
    DBMS_OUTPUT.PUT_LINE('You can drive, but cannot drink.');
  ELSIF l_age < 16 AND has_license_in THEN
    DBMS_OUTPUT.PUT_LINE('How did you get your license so young?');
  ELSE
    DBMS_OUTPUT.PUT_LINE('You cannot drink or drive.');
  END IF;
END check_rights;
/

-- Test block to run the procedure
DECLARE
  l_birth_date DATE;
BEGIN
  l_birth_date := TO_DATE('1982-06-03', 'YYYY-MM-DD'); -- Example birth date
  check_rights(l_birth_date, TRUE); -- Change TRUE/FALSE to test different scenarios
END;
