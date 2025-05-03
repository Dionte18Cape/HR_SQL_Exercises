CREATE OR REPLACE FUNCTION get_age(
  birth_date_in IN  DATE
)
  RETURN NUMBER
IS
  l_age NUMBER;
BEGIN
  l_age := TRUNC(MONTHS_BETWEEN(CURRENT_DATE, birth_date_in) / 12);
  -- Uncomment the line below to output age
  DBMS_OUTPUT.PUT_LINE('Your age: ' || l_age);
  RETURN l_age;
END get_age;
/

CREATE OR REPLACE FUNCTION can_buy_alcohol(
  age_in IN NUMBER
)
  RETURN BOOLEAN
IS
BEGIN
  RETURN age_in >= 21; -- Assuming the legal drinking age is 21
END can_buy_alcohol;
/

DECLARE
  l_birth_date  DATE;
  l_age         FLOAT;
BEGIN
  l_birth_date := TO_DATE('1971-06-16', 'YYYY-MM-DD');
  l_age := get_age(l_birth_date);
  IF can_buy_alcohol(l_age) THEN
    DBMS_OUTPUT.PUT_LINE('You can buy alcohol.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('You cannot buy alcohol.');
  END IF;
END;
