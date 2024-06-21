/*markdown
OVER and PARTITION BY
Giả sử một ngày bạn cần làm báo cáo lấy danh sách tất cả nhân viên và hiển thị cả tổng số lượng nhân viên trên cùng một bảng thì bạn sẽ thực hiện như thế nào? Khi ấy bạn có thể sẽ cố thực hiện các câu lệnh như sau để truy vấn.
*/

-- Ví dụ bạn có thể thực hiện 2 câu lệnh SQL đơn giản như dưới đây rồi ghép lại thành bảng kết quả mong muốn.
SELECT * FROM employees;
-- —————————-
SELECT COUNT(*) FROM employees;

-- Hoặc bạn có thể thực hiện 1 câu lệnh có thêm truy vấn con phức tạp hơn một chút như sau.

SELECT e.*, 

   ( SELECT COUNT(*) FROM employees

   ) AS total_employees
FROM employees;

-- Xong sau đó có thể bạn lại được yêu cầu lập danh sách nhân viên mà thay vì có tổng tất cả, 
-- sếp bạn muốn biết tổng số lượng của từng phòng ban mà mỗi nhân viên của phòng ban tương ứng đang làm việc. 
-- Câu lệnh SQL bên trên sẽ bắt đầu phức tạp hơn một chút. 
-- Lúc này bạn sẽ cần dùng đến truy vấn con tương quan (Correlated Subquery) để thực hiện như sau.

SELECT e.*, 

   ( SELECT COUNT(*) FROM employees
    WHERE department_id = e.department_id
  ) AS total_employees
FROM employees;

-- Trong Oracle có một loại mệnh đề có thể giúp bạn giải quyết được những vấn đề như đã nêu bên trên gọi là mệnh đề OVER PARTITION BY. 
-- Ta sẽ thực hiện lại các câu lệnh để giải quyết 2 câu hỏi đặt ra bên trên sử dụng OVER và PARTITION BY như sau.

SELECT e.*, 

    COUNT(*) OVER() AS total_employees
FROM employees e;

SELECT e.*, 

    COUNT(*) OVER(PARTITION BY department_id)
    AS total_employees_by_department
FROM employees e;

-- Mệnh đề OVER sẽ nhóm các hàng bản ghi lại với nhau, thực hiện tính toán trên các nhóm đó và trả về kết quả trên từng hàng. 
-- Ví dụ sau nếu chỉ có mệnh đề OVER không thì Oracle sẽ tự hiểu chúng ta đang thực hiện COUNT trên toàn bộ bảng và trả về kết quả trên từng hàng tương ứng.

SELECT
    e.*, COUNT(*) OVER()
    AS total_employees
FROM employees e;

/*markdown
Nhóm các hàng trong mệnh đề OVER thường được gọi là các “Window”. Nếu không chỉ định gì trong OVER, Oracle sẽ tự động coi cả bảng đang được truy vấn là 1 Window và thực hiện tính toán trên cả bảng đó. Nếu muốn chỉ định cách Oracle đọc Window khác đi, ta thêm mệnh đề PARTITION BY trong OVER và sau đó là tên cột mà ta muốn Oracle nhóm lại để thực hiện tính toán.
*/

-- Ví dụ sau sẽ lấy danh sách nhân viên và tính toán tổng số lương mà công việc ở vị trí mỗi nhân viên đó nhận được trong cả công ty.
SELECT
    employee_id,
    first_name || '' || last_name AS full_name,
    salary,
    SUM(salary) OVER(PARTITION BY job_id)
    AS total_salary_by_job
FROM employees e;