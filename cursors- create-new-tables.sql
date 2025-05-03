DROP TABLE people_employees;
DROP TABLE people;
DROP TABLE companies;

/*
  In the companies table below, the staff, vendor, and client
  columns are pseudo-booleans.
    '1' = True, meaning the company falls in this category
    '0' = False, meaning the company does not fall in this category
*/
CREATE TABLE companies
(
  company_id       NUMBER GENERATED AS IDENTITY,
  company_name     VARCHAR2(100) UNIQUE,
  staff            CHAR(1) DEFAULT '0' NOT NULL,
  vendor           CHAR(1) DEFAULT '0' NOT NULL,
  client           CHAR(1) DEFAULT '0' NOT NULL,
  CONSTRAINT PK_company PRIMARY KEY (company_id),
  CONSTRAINT cons_companies_staff  CHECK (staff IN ('1','0')),
  CONSTRAINT cons_companies_vendor CHECK (vendor IN ('1','0')),
  CONSTRAINT cons_companies_client CHECK (client IN ('1','0'))
);

CREATE TABLE people
(
  person_id       NUMBER GENERATED AS IDENTITY,
  first_name      VARCHAR2(20),
  last_name       VARCHAR2(25)    NOT NULL,
  email           VARCHAR2(25)    NOT NULL,
  phone_number    VARCHAR2(20),
  company_id      NUMBER REFERENCES companies(company_id),
  CONSTRAINT PK_people PRIMARY KEY (person_id)
);

CREATE TABLE people_employees
(
  employee_id       NUMBER GENERATED AS IDENTITY,
  person_id         NUMBER REFERENCES people(person_id),
  hire_date         DATE,
  job_id            VARCHAR2(10) REFERENCES jobs(job_id),
  salary            NUMBER(8,2),
  commission_pct    NUMBER(2,2),
  manager_id        NUMBER(6,0),
  department_id     NUMBER(4) REFERENCES departments(department_id),
  CONSTRAINT PK_people_employee PRIMARY KEY (employee_id)
);

-- Create the relationship between manager_id and employee_id
ALTER TABLE people_employees
ADD CONSTRAINT people_employee_manager_fk
FOREIGN KEY (manager_id)
REFERENCES people_employees(employee_id);