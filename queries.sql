-- Create Tables 
-- Create departments Table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Create dept_emp Table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create dept_manager Table
CREATE TABLE dept_manager (
    dept_no CHAR(4),
    emp_no,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Create employees Table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(255),
    birth_date DATE,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    sex CHAR(1),
    hire_date DATE
);

-- Create salaries Table
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Create title_id Table
CREATE TABLE title_id (
    title_id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255)
);
-- 1
SELECT 
    e.emp_no AS EmployeeNumber,
    e.last_name AS LastName,
    e.first_name AS FirstName,
    e.sex AS Sex,
    s.salary AS Salary
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no; 
-- 2 	
SELECT
    first_name AS FirstName,
    last_name AS LastName,
    hire_date AS HireDate
FROM
    employees
WHERE
    EXTRACT(YEAR FROM hire_date) = 1986;
-- 3
SELECT
    dm.dept_no AS DepartmentNumber,
    d.dept_name AS DepartmentName,
    dm.emp_no AS EmployeeNumber,
    e.last_name AS LastName,
    e.first_name AS FirstName
FROM
    dept_manager dm
JOIN
    departments d ON dm.dept_no = d.dept_no
JOIN
    employees e ON dm.emp_no = e.emp_no;

--4 
SELECT
    de.emp_no AS EmployeeNumber,
    e.last_name AS LastName,
    e.first_name AS FirstName,
    de.dept_no AS DepartmentNumber,
    d.dept_name AS DepartmentName
FROM
    dept_emp de
JOIN
    employees e ON de.emp_no = e.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no;

--5
SELECT
    first_name AS FirstName,
    last_name AS LastName,
    sex AS Sex
FROM
    employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
	
--6 
SELECT
    e.emp_no AS EmployeeNumber,
    e.last_name AS LastName,
    e.first_name AS FirstName
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';
	
-- 7 
SELECT
    e.emp_no AS EmployeeNumber,
    e.last_name AS LastName,
    e.first_name AS FirstName,
    d.dept_name AS DepartmentName
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');
	
-- 8 
SELECT
    last_name AS LastName,
    COUNT(*) AS Frequency
FROM
    employees
GROUP BY
    last_name
ORDER BY
    Frequency DESC, last_name;
