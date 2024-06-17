/*markdown
- Thêm dữ liệu trong bảng với câu lệnh INSERT.
- Lưu ý giá trị NULL khi INSERT dữ liệu.
- INSERT dữ liệu từ các bảng khác trong cơ sở dữ liệu.
- Cách thức sử dụng COMMIT, ROLLBACK trong cơ sở dữ liệu.
- Tự tạo một db local và thực hành các câu lệnh SQL INSERT.
*/

-- ví dụ thêm một bản ghi
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

-- ví dụ thêm nhiều bản ghi
INSERT INTO table_name (column1, column2, column3, ...)
VALUES
    (value1, value2, value3, ...),
    (value1, value2, value3, ...),
    (value1, value2, value3, ...),
    ...;


INSERT INTO department (department_id, department_name, manager_id, location_id)
VALUES (280, 'Finance', 108, 1700);


-- giá trị mặc định cho cột nếu không cung cấp giá trị là NULL
INSERT INTO department (department_id, department_name, manager_id, location_id)
VALUES (290, 'Human Resources', 203, NULL);

-- Thêm giá trị được lấy từ bảng khác
INSERT INTO department (department_id, department_name, manager_id, location_id)
SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE department_id = 10;


-- Thêm giá trị từ một bảng khác
INSERT INTO sale_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';


/*markdown
Sau đây là các câu lệnh, bài tập có đáp án bạn có thể làm theo để thực hành với SQL.
*/

-- Viết câu lệnh thêm các bản ghi như sau vào bảng EMPLOYEES.
-- — thực hiện câu lệnh INSERT với từng bản ghi như trong video
-- — hoặc có thể thực hiện INSERT cùng lúc nhiều bản ghi như sau

INSERT ALL
INTO employees VALUES (97, 'Steven', 'Gerrald', 'george@gmail.com', '511.111.4567', '17-JUN-03', 'AD_PRES', 24000, NULL, NULL, 90)
INTO employees VALUES (98, 'Alexander', 'Arnold', 'trent@gmail.com', '512.112.4567', '03-JAN-06', 'IT_PROG', 9000, NULL, 102, 60)
INTO employees VALUES (99, 'Daniel', 'Faviet', 'daniel@gmail.com', '513.1113.4169', '16-AUG-02', 'FI_ACCOUNT', 9000, NULL, 108, 100)
SELECT 1 FROM DUAL;

-- Viết câu lệnh thêm các bản ghi như sau vào bảng JOB_HISTORY từ các nhân mới thêm trước đó trong bảng EMPLOYEES. 
-- Sao cho cột START_DATE bằng cột HIRE_DATE trong bảng, cột END_DATE là 10 tháng kể từ cột START_DATE (gợi ý dùng hàm ADD_MONTHS).

INSERT INTO job_history(employee_id, start_date, end_date, job_id, department_id)
SELECT employee_id, hire_date, ADD_MONTHS(hire_date, 10), job_id, department_id
FROM employees
WHERE employee_id IN (97, 98, 99);

INSERT INTO job_history
SELECT employee_id,
hire_date, ADD_MONTHS(hire_date, 10),
job_id, department_id FROM employees
WHERE employee_idINn (97, 98, 99);

-- Viết câu lệnh thêm bản ghi vào bảng JOB_HISTORY thông tin các nhân viên có trong bảng EMPLOYEES mà không có trong bảng JOB_HISTORY.
-- Giá trị trong cột END_DATE là 18 tháng kể từ START_DATE (HIRE_DATE trong bảng EMPLOYEES).

INSERT INTO job_history(employee_id, start_date, end_date, job_id, department_id)
SELECT employee_id, hire_date, ADD_MONTHS(hire_date, 18), job_id, department_id
FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM job_history);

INSERT INTO job_history
SELECT
employee_id, hire_date AS start_date,
ADD_MONTHS(hire_date, 18) AS end_date,
job_id, department_id
FROM employees
WHERE department_id IS NOT NULL
AND employee_id NOT IN (
SELECT employee_id FROM job_history
);

/*markdown
Bổ trợ câu lệnh INSERT ALL trong SQL
*/

-- Khi thực hiện INSERT dữ liệu vào bảng, ta có thể thực hiện INSERT nhiều bản ghi hay nhiều bảng cùng lúc sử dụng mệnh đề INSERT ALL như sau.

INSERT ALL
    INTO employees VALUES (10, 'Huy', 'Tran Quoc', 'huytq@wecommit.com.vn', '511.111.4567', '05-OCT-16', 'AD_PRES', 5000, NULL, NULL, 10)
    INTO employees VALUES (11, 'Huy', 'Tran Dinh', 'huytd@wecommit.com.vn', '512.112.4568', '05-OCT-16', 'AD_VP', 4000, NULL, 10, 20)
    INTO employees VALUES (12, 'Oanh', 'Lai Thi', 'oanhlt@wecommit.com.vn', '513.113.4569', '16-MAY-20', 'FI_ACCOUNT', 1000, NULL, 10, 110)
SELECT * FROM DUAL;

-- Trong câu lệnh trên ta thấy cần có thêm một câu truy vấn con ở bên dưới mệnh đề INSERT chính. 
-- Theo tài liệu của hãng Oracle thì ta cần phải thêm một câu truy vấn con sau lệnh INSERT ALL thì 
-- mới có thể thực hiện thêm nhiều bản ghi cùng lúc trong 1 câu lệnh INSERT được.