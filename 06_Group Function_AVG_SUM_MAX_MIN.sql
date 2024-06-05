/*markdown
- Giới thiệu các Group Function hay các hàm thống kê dữ liệu trong SQL.
- Sử dụng hàm phổ biến như đếm số lượng bản ghi, tính tổng hay tìm giá trị min, max, giá trị trung bình trong cột.
- https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Aggregate-Functions.html#GUID-62BE676B-AF18-4E63-BD14-25206FEA0848

*/

-- ttinhs các giá trị: trung bình, max, min, sum, count của cột salary
select AVG(salary), MAX(salary), MIN(salary), SUM(salary), COUNT(salary) 
from employees
WHERE job_id like '%REP%;'

-- TÍnh min max của ngày tháng
select MIN(hire_date), MAX(hire_date) from employees;

-- hàm count(*) và count(cột) khác nhau

-- count(*) đếm tất cả các dòng
select count(*) from employees;

-- count(cột) đếm tất cả các dòng có giá trị khác null
select count(commission_pct) from employees;

-- Viết câu lệnh đếm các giá trị độc nhất trên cột MANAGER_ID của bảng EMPLOYEES.
select count(distinct manager_id) from employees;

-- Viết câu lệnh tính trung bình lương của các nhân viên mà không dùng hàm AVG.
select sum(salary)/count(salary) as avg_salary
from employees;

-- Viết câu lệnh tính trung bình lương của các nhân viên và lấy 2 chữ số sau dấu thập phân
select round(avg(salary),2) as avg_salary
from employees;


-- Viết câu lệnh tìm mức lương cao nhất, thấp nhất, tổng lương và trung bình lương của tất cả nhân viên.
SELECT 
   MAX(salary) max_salary, 
   MIN(salary) min_salary, 
   SUM(salary) sum_salary, 
   ROUND(AVG(salary), 2) avg_salary 
FROM employees;


-- Viết câu lệnh hiển thị tổng số nhân viên trong công ty, tổng số nhân viên được thuê trong các năm 2005, 2006, 2007 và 2008.
SELECT 
   COUNT(employee_id) total_employee, 
   COUNT(CASE WHEN hire_date BETWEEN '01-JAN-05' AND '31-DEC-05' THEN 1 END) employee_2005, 
   COUNT(CASE WHEN hire_date BETWEEN '01-JAN-06' AND '31-DEC-06' THEN 1 END) employee_2006, 
   COUNT(CASE WHEN hire_date BETWEEN '01-JAN-07' AND '31-DEC-07' THEN 1 END) employee_2007, 
   COUNT(CASE WHEN hire_date BETWEEN '01-JAN-08' AND '31-DEC-08' THEN 1 END) employee_2008
FROM employees;

SELECT 
   COUNT(*) total,
   SUM(DECODE(TO_CHAR(hire_date,'YYYY'),2005,1,0))"2005",
   SUM(DECODE(TO_CHAR(hire_date,'YYYY'),2006,1,0))"2006",
   SUM(DECODE(TO_CHAR(hire_date,'YYYY'),2007,1,0))"2007",
   SUM(DECODE(TO_CHAR(hire_date,'YYYY'),2008,1,0))"2008" 
FROM employees;
