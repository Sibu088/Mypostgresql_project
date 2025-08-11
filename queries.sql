-- 1. Create tables
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT REFERENCES departments(department_id),
    job_id INT REFERENCES jobs(job_id)
);

CREATE TABLE salaries (
    salary_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    salary_amount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE overtime (
    overtime_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    overtime_hours INT NOT NULL
);

-- 2. Insert data
INSERT INTO departments (department_name) VALUES
('Human Resources'),
('IT'),
('Finance');

INSERT INTO jobs (job_title) VALUES
('HR Manager'),
('Software Developer'),
('Accountant');

-- employees can only reference existing department_id and job_id
INSERT INTO employees (first_name, last_name, department_id, job_id) VALUES
('Alice', 'Smith', 1, 1),
('Bob', 'Johnson', 2, 2),
('Charlie', 'Brown', 3, 3);

-- salaries can only reference existing employee_id
INSERT INTO salaries (employee_id, salary_amount) VALUES
(1, 60000.00),
(2, 80000.00),
(3, 55000.00);

-- overtime can only reference existing employee_id
INSERT INTO overtime (employee_id, overtime_hours) VALUES
(1, 5),
(2, 10),
(3, 2);

-- 3. LEFT JOIN query: department name, job title, salary, overtime hours
SELECT d.department_name,
       j.job_title,
       s.salary_amount,
       o.overtime_hours
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN jobs j ON e.job_id = j.job_id
LEFT JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN overtime o ON e.employee_id = o.employee_id;
