/*markdown
- Cập nhật dữ liệu trong bảng với câu lệnh UPDATE.
- Sử dụng điều kiện WHERE khi cập nhật dữ liệu.
*/

-- Update the department_id of the employee with employee_id 100 to 2
UPDATE employees
SET department_id = 2
WHERE employee_id = 100;


-- Nếu không có where thì sẽ update tất cả các dòng
UPDATE copy_emp
SET department_id = 110;

-- update nhiều cột
UPDATE employees
Set (job_id, salary) = (SELECT job_id, salary
                        FROM employees
                        WHERE employee_id = 100)
    WHERE employee_id = 101;


UPDATE copy_emp
SET department_id = SELECT department_id
                    FROM employees
                    WHERE employee_id = 100
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200);

-- Viết câu lệnh thay đổi các bản ghi trong bảng EMPLYEES sao cho lương các nhân viên thuộc phòng ban 60 và 90 lên 50% mức lương hiện tại.
UPDATE employees
SET salary = salary * 1.5
WHERE department_id in (60, 90);

-- Viết câu lệnh thay đổi email các nhân viên hiện tại thành định dạng tên cũ thêm đuôi “@wecommit.com.vn”. Không thực hiện với nhân viên không có mã người quản lý.
UPDATE employees
SET email = email || ‘@wecommit.com.vn’
WHERE manager_id IS NOT NULL;;