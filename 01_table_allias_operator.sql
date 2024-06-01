/*markdown
- Khái niệm về bảng biểu, cột và bản ghi trong Cơ sở dữ liệu.
- Thế nào là ngôn ngữ SQL và cách lấy dữ liệu từ các bảng với câu lệnh SELECT.
- Sử dụng định danh và các phép tính cơ bản trên cột trong SQL.
- using HR Schema (Oracle Live SQL)
*/

-- select first name from employees
SELECT first_name FROM employees;

-- select id, email from employees
SELECT employee_id, email FROM employees;

-- use alias to select id from employees
SELECT employee_id as id FROM employees;

-- select first name as "First Name" have space between First and Name
SELECT first_name as "First Name" FROM employees;

-- select all columns from employees
SELECT * FROM employees;



SELECT last_name, salary, salary * 12 "Annual Salary" FROM employees;

SELECT last_name, salary, 2*salary+100 "New Salary" FROM employees;

SELECT last_name, salary, 2*(salary+100) "New Salary" FROM employees;



DESCRIBE jobs;
-- lệnh "DESCRIBE <tên bảng>" trả về 3 cột giá trị là:
-- tên các cột trong bảng
-- ràng buộc có thể có giá trị NULL trong cột hay không
-- kiểu dữ liệu tương ứng của các cột
SELECT job_title, job_id  FROM jobs;

-- Viết câu lệnh tính xem mỗi một công việc có thể tăng tối đa mức lương bao nhiêu trên bảng JOBS, sau đó đặt định danh là MAX_PROMOTION.
SELECT job_title, max_salary - min_salary AS max_promotion FROM jobs;

-- Viết câu lệnh hiển thị báo cáo gồm mã nhân viên, tên, lương hiện tại và lương mới nếu tăng 15.5% của tất cả nhân viên
SELECT employee_id, first_name, salary, salary * 1.155 AS new_salary FROM employees;

-- Viết câu lệnh lấy ID và họ tên đầy đủ của nhân viên từ bảng EMPLOYEES với định danh khác là FULL_NAME (gợi ý: sử dụng toán tử ” ||” để cộng chuỗi).
SELECT employee_id, first_name || ' ' || last_name AS full_name FROM employees;

-- Viết câu lệnh lấy dữ liệu độc nhất, mỗi giá trị chỉ xuất hiện 1 lần trên cột họ của nhân viên từ bảng EMPLOYEES (gợi ý sử dụng từ khóa DISTINCT)

SELECT DISTINCT last_name FROM employees;
