/*
-- Create department table

DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
	dept_no VARCHAR(6) PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL
);


-- Create employee table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,	
	birth_date DATE NOT NULL,	
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1),
	hire_date DATE NOT NULL
);


-- CREATE department employee table
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,	
	dept_no	VARCHAR(6) NOT NULL,
	from_date DATE NOT NULL,	
	to_date DATE,
	PRIMARY KEY(emp_no, dept_no, from_date)
);


-- CREATE department manager table
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager(
	dept_no VARCHAR(6) NOT NULL,	
	emp_no	INT NOT NULL,
	from_date DATE NOT NULL,	
	to_date DATE,
	PRIMARY KEY(dept_no, emp_no, from_date)
);


-- CREATE salaries table
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries(
	emp_no	INT NOT NULL,
	salary	INT NOT NULL,
	from_date DATE NOT NULL,	
	to_date DATE,
	PRIMARY KEY(emp_no, from_date)
);


-- CREATE titles table
DROP TABLE IF EXISTS titles;
CREATE TABLE titles(
	emp_no	INT NOT NULL,
	title	VARCHAR(50) NOT NULL,
	from_date 	DATE NOT NULL,
	to_date DATE,
	PRIMARY KEY(emp_no, from_date)
);
*/

-- DATA ANALYSIS
-- List the following details of each employee: 
-- employee number, last name, first name, gender, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no

-- List employees who were hired in 1986
SELECT *
FROM employees
WHERE hire_date >= '1/1/1986'
AND hire_date <= '12/31/1986'

SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments d
INNER JOIN dept_manager m
ON d.dept_no = m.dept_no
INNER JOIN employees e
ON e.emp_no = m.emp_no
WHERE m.to_date = '1/1/9999'

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE lower(first_name) = 'hercules'
AND lower(last_name) like 'b%'

-- List all employees in the Sales department, 
-- including their employee number, last name, first name, 
-- and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
AND de.to_date = '1/1/9999'

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name,
-- and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name IN ('Sales', 'Development')
AND de.to_date = '1/1/9999'

-- In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
SELECT last_name, count(emp_no) as "Occurences"
FROM employees
GROUP BY last_name
ORDER BY 2 DESC