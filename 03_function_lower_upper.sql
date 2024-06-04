/*markdown
- Giới thiệu kiểu dữ liệu dạng chuỗi và các hàm chuyển đổi dữ liệu với chuỗi trong SQL.
- Sử dụng các hàm phổ biến thường gặp khi thao tác với chuỗi ký tự.
- Using EMP and DEPT tables. Classic tables with 4 departments and 14 employees.
*/

-- cột ename: lower case, initcap, concat 2 cột ename và job; sắp xếp theo cột initcap

SELECT LOWER(ename), INITCAP(ename) , CONCAT(ename, job) from emp
WHERE ename like '%K%'
ORDER BY 2; -- = ORDER BY INITCAP(ename)

SELECT * FROM emp

-- Viết câu lệnh tìm các công việc có mô tả là quản lý, khác với câu thực hành này ở phần trước, 
-- hãy tìm sao cho không cần phải gõ đúng từng viết hoa hay viết thường kí tự trong tên của nó.

SELECT 
   job_title, job_id 
FROM jobs 
WHERE LOWER(job_title) LIKE '%manager%'
-- hoặc:
-- where UPPER(job_title) LIKE '%MANAGER%'
ORDER BY job_id;

-- Viết câu lệnh lấy họ tên đầy đủ nhân viên và ghép mã phòng ban với mã nhân viên đó thành 1 mã định danh mới là UNIQUE_ID.
SELECT concat(department_id, employee_id) as UNIQUE_ID, concat(first_name, ' ', last_name) as FULL_NAME
FROM employees
ORDER BY UNIQUE_ID;
-- lưu ý hàm CONCAT() chỉ ghép được 2 chuỗi mỗi lần
-- khác với toán tử "||" có thể cộng bao nhiêu chuỗi tùy thích

SELECT CONCAT(department_id, employee_id) AS unique_id, first_name || ' ' || last_name AS full_name 

-- Viết câu lệnh hiển thị thông báo như sau cho mỗi nhân viên: “<Tên nhân viên> được nhận <mức lương> hàng tháng” với định dạng tiền lương là “$99,999.00”.

SELECT first_name || '' || last_name || 'earns' || TO_CHAR(salary, '$99,999.00') || 'per month' as salary_info
FROM employees;
