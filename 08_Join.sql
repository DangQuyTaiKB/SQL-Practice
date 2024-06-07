/*markdown
- Cách thức để lấy dữ liệu từ nhiều bảng với các phép JOIN trong câu lệnh SELECT.
- Cách sử dụng điều kiện khi JOIN các bảng với nhau.
*/

-- dùng on
select e.employee_id, e.last_name, e.department_id, 
d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

-- dùng where
select e.employee_id, e.last_name, e.department_id,
d.department_id, d.location_id
from employees e JOIN departments d
where (e.department_id = d.department_id);

-- JOIN nhiều bảng với nhau
select e.employee_id, city, department_name
FROM employees e 
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id;

-- Viết câu lệnh tìm tên nhân viên và tên quản lý của nhân viên đó.
SELECT 
   e.first_name || ' ' || e.last_name AS employee_name, 
   m.first_name || ' ' || m.last_name AS manager_name
FROM employees e 
JOIN employees m
   ON e.manager_id = m.employee_id;

-- Viết câu lệnh tìm nhân viên và phòng ban của từng nhân viên đó.
SELECT
    e.first_name || ' ' || e.last_name AS employee_name,
    e.department_id, d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;

-- Viết câu lệnh tìm nhân viên và địa điểm chi tiết nơi nhân viên đó làm việc.
SELECT 
   employee_id,
   first_name || ' ' || last_name AS employee_name, 
   country_name 
FROM employees 
JOIN departments USING(department_id) 
JOIN locations USING(location_id) 
JOIN countries USING(country_id);
-- sử dụng USING(<tên cột chung>) thay cho điều kiện ON trong mệnh đề JOIN

-- Viết câu lệnh tìm nhân viên và địa điểm chi tiết nơi nhân viên đó làm việc.
SELECT 
   employee_id,
   first_name || ' ' || last_name AS employee_name, 
   country_name
FROM employees e
JOIN departments d
   ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id
JOIN countries c
    ON l.country_id = c.country_id;

-- Viết câu lệnh tính lương trung bình của các nhân viên cho từng job.
SELECT job_title, AVG(salary) 
FROM employees 
JOIN jobs USING(job_id) 
-- hoặc sử dụng phép JOIN sau:
-- NATURAL JOIN jobs
GROUP BY job_title;
-- NATURAL JOIN sẽ tự động sử dụng cột chung giữa 2 bảng mà không cần chỉ định

-- Viết câu lệnh tìm số ngày nhân viên đã làm việc cho phòng ban có ID là 80.
SELECT 
   employee_id, 
   job_title, end_date - start_date number_of_days 
FROM job_history 
JOIN jobs USING(job_id) 
WHERE department_id = 80;

-- Viết câu lệnh hiển thị danh sách các nhân viên trong Toronto.
SELECT 
   e.last_name, e.job_id, 
   d.department_name, e.department_id
FROM employees e 
JOIN departments d
   ON e.department_id = d.department_id
JOIN locations l
   ON d.location_id = l.location_id
WHERE LOWER(l.city) = 'toronto';