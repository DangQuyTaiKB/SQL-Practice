/*markdown
Sử dụng phép tổ hợp bảng như UNION, INTERSECT và MINUS để tổ hợp dữ liệu từ nhiều bảng khác nhau khi SELECT trong SQL.
*/

-- Select:
-- 	- Hợp giữa A và B
-- 		○ Loại bỏ giá trị trùng lặp
-- 		○ Hoặc lấy hết, không bỏ giá trị trùng lặp nào
-- - UNION: loại bỏ các giá trị giông nhau --- deduplicate  = select distinct
-- - UNION ALL: không loai bỏ mà giữ nguyên các giá trị giống nhau

SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history;

-- UNION ALL
SELECT employee_id, job_id
FROM employees
UNION ALL
SELECT employee_id, job_id
FROM job_history;

	-- Nếu bạn biết chắc rằng dữ liệu của bạn không có sự trùng lặp mà bạn vẫn dùng UNION thì nó sẽ gây lang phí tài nguyên
-- Và nó cũng chậm hơn câu lệnh UNION ALL nữa vì nó phải kiểm tra xem có giá trị trùng lặp không 
-- đối với dữ liệu lớn thì nó sẽ chậm hơn rất nhiều

-- Giao (INTERSECT)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

-- Lấy dữ liệu từ tập này và bỏ từ tập kia: dùng minus
SELECT employee_id, job_id
FROM employees
MINUS
SELECT employee_id, job_id
FROM job_history;

/*markdown
Sau đây là các câu lệnh, bài tập có đáp án bạn có thể làm theo để thực hành với SQL.
*/

-- 1. Viết câu lệnh tìm các nhân viên làm công việc IT trước năm 2006 và Sales trước năm 2005.
SELECT
employee_id,
first_name ||''|| last_name AS full_name,
job_id, hire_date
FROM employees
WHERE LOWER(job_id) LIKE '%sa%'
AND hire_date < '01-JAN-05'
UNION
SELECT
employee_id,
first_name || '' || last_name AS full_name,
job_id, hire_date
FROM employees
WHERE LOWER(job_id) LIKE '%it%'
AND hire_date < '01-JAN-06';

-- 2. Viết câu lệnh tìm nhân viên có trong danh sách làm việc ở quá khứ.
SELECT employee_id FROM employees
INTERSECT
SELECT employee_id FROM job_history;


-- 3. Viết câu lệnh tìm nhân viên không có trong danh sách làm việc ở quá khứ.
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;

-- 4. Viết câu lệnh liệt kê các phòng ban không chứa mã công việc ST_CLERK.
SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees
WHERE LOWER(job_id) LIKE '%st_clerk%';


-- 5. iết câu lệnh liệt kê các vùng không có phòng ban nào trong vùng đó.
SELECT job_id, department_id
FROM (
SELECT job_id, department_id FROM employees

INTERSECT (
SELECT job_id, department_id
FROM employees
WHERE department_id IN (10, 50, 20)
)
) ORDER BY INSTR('10,50,20', department_id);

-- 6. Viết câu lệnh hiển thị các nhân viên từ bảng EMPLOYEES, bất kể người nhân viên đó có thuộc một phòng ban nào hay không và ở phòng ban của tất cả các phòng ban từ bảng DEPARTMENTS, bất kể phòng đó có nhân viên làm việc hay không.
SELECT
last_name, department_id,
TO_CHAR(null) dept_name
FROM employees
UNION
SELECT
TO_CHAR(null),
department_id, department_name
FROM departments;