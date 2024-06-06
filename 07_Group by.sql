/*markdown
- Cách thức sử dụng mệnh đề GROUP BY trong câu lệnh SELECT để gộp nhóm dữ liệu với nhau.
- Lọc dữ liệu sau khi gộp nhóm với mệnh đề HAVING.


-- Trung bình tiền lương theo một nhóm cụ thể
SELECT department_id, dept_id, job_id, SUM(salary) 
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- Lọc kết quả bằng mệnh đề HAVING
SELECT department_id, dept_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id
HAVING SUM(salary) > 10000
ORDER BY department_id;


-- Viết câu lệnh đếm số lượng nhân viên mỗi phòng ban
SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id;


-- Viết câu lệnh tìm mức lương cao nhất của mỗi phòng ban
SELECT department_id, MAX(salary) as max_salary
FROM employees
GROUP BY department_id;


-- Viết câu lệnh đếm số nhân viên, tổng mức lương và sự chênh lệch giữa mức lương cao nhất và thấp nhất cho từng công việc.
SELECT 
   job_id, 
   COUNT(*) AS number_of_employees, 
   SUM(salary), 
   MAX(salary) - MIN(salary) AS salary_difference 
FROM employees 
GROUP BY job_id;

	-- - Trả ra tổng số bản ghi: COUNT(*)
-- Và câu lệnh: Select(tên cột) là khác nhau: câu lệnh này sẽ không trả ra toàn bộ bản ghi như Select Count(*)
-- Vì: count(*) đếm cả giá trị null, còn count(salary-tên cột) không lấy giá trị null

-- Viết câu lệnh tìm mức lương cao nhất, thấp nhất, tổng lương và trung bình lương của tất cả nhân viên, nhóm lại theo từng loại công việc
SELECT job_id, 
   ROUND(MAX(salary), 2) max_salary,
   ROUND(MIN(salary), 2) min_salary,
   ROUND(SUM(salary), 2) sum_salary,
   ROUND(AVG(salary), 2) avg_salary
FROM employees
GROUP BY job_id;


-- Viết câu lệnh tìm phòng ban có nhiều hơn 5 nhân viên được nhận hoa hồng.
SELECT department_id 
FROM employees 
  WHERE commission_pct IS NOT NULL
GROUP BY department_id 
  HAVING COUNT(commission_pct) > 5;

-- Viết câu lệnh tìm nhân viên đã làm nhiều hơn 2 công việc trong quá khứ.
SELECT employee_id 
FROM job_history 
GROUP BY employee_id 
  HAVING COUNT(*) >= 2;

-- Viết câu lệnh hiển thị JOB_ID, SALARY của của những JOB_ID dựa trên mã phòng ban và tổng lương của các JOB_ID đó, hiển thị các cột cho phòng ban 20, 50, 80 và 90.
SELECT job_id,
   SUM(DECODE(department_id, 20, salary)) "Dept 20",
   SUM(DECODE(department_id, 50, salary)) "Dept 50",
   SUM(DECODE(department_id, 80, salary)) "Dept 80",
   SUM(DECODE(department_id, 90, salary)) "Dept 90",
   SUM(salary) "Total"
FROM employees
GROUP BY job_id;

-- DECODE là một hàm trong SQL Server dùng để thay thế giá trị của một cột bằng một giá trị khác nếu giá trị của cột đó thỏa mãn một điều kiện nào đó.

-- Viết câu lệnh hiển thị mã quản lý (MANAGER_ID) và người nhân viên có lương thấp nhất dưới các mã quản lý tương ứng. 
-- Báo cáo không hiển thị những bản ghi có mức lương thấp nhất dưới 6000 và không hiển thị những người không biết quản lý là ai.
SELECT manager_id, MIN(salary) AS "Lowest Salary"
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY 2;