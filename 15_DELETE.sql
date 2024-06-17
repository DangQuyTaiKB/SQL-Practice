/*markdown
- Xóa dữ liệu bản ghi trong bảng với câu lệnh DELETE.
- Sử dụng điều kiện WHERE khi xóa dữ liệu, lưu ý sai lầm khi thực hiện DELETE dữ liệu.
- Cách thức thực hiện xóa hết dữ liệu của bảng với từ khóa TRUNCATE, khác biệt giữa câu lệnh DELETE và TRUNCATE.
*/

-- delete phải có điều kiện where
DELETE FROM table_name
WHERE condition;

-- Ví dụ
DELETE FROM departments
WHERE department_id = 100;

-- Nếu không có điều kiện where thì sẽ xóa toàn bộ dữ liệu trong bảng
DELETE FROM departments;

-- dung subquery
DELETE FROM employees
WHERE department_id IN (SELECT department_id
                         FROM departments
                         WHERE department_name LIKE '% Public%');

/*markdown
Nếu bạn cần thực sự xóa toàn bộ dữ liệu: ví dụ khi ta phân tích các datawarehouse, ta sẽ phải có những cái bảng tạm để lưu trữ dữ liệu, sau khi phân tích xong, ta sẽ xóa hết dữ liệu trong bảng tạm đó. Để xóa hết dữ liệu trong bảng, ta có thể sử dụng câu lệnh TRUNCATE TABLE hoặc DELETE FROM.
*/

TRUNCATE TABLE table_name;
-- Ví dụ
TRUNCATE TABLE departments;

-- == delete không có where và truncate khác nhau ==
-- Truncate không ghi vào log, không thể rollback, dữ liệu bay mất luôn
-- Delete ghi vào log, có thể rollback


-- Viết câu lệnh xóa các bản ghi trên bảng JOB_HISTORY thông tin các nhân viên không có mã người quản lý.
DELETE FROM job_history
WHERE employee_id IN (
SELECT employee_id
FROM employees
WHERE manager_id IS NULL
);

-- Viết câu lệnh xóa các bản ghi trên bảng JOB_HISTORY thông tin các nhân viên được thuê trước năm 2003.
DELETE FROM job_history
WHERE employee_id IN (
SELECT employee_id FROM employees
WHERE HIRE_DATE < '01-JAN-03'
);