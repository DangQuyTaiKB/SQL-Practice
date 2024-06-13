/*markdown
Correlated Subquery là gì ?
    • Không giống các câu lệnh truy vấn con thông thường, Correlated Subquery hay dịch ra là “truy vấn con tương quan” sẽ sử dụng chính dữ liệu từ câu lệnh truy vấn cha làm input cho mình để trả về kết quả mong muốn cho người dùng. 
*/

    -- • Sau đây là ví dụ về Correlated Subquery, câu lệnh sau sẽ trả về các nhân viên có lương cao hơn trung bình lương phòng ban của họ:
    SELECT 
      employee, first_name || ' ' || last_name AS full_name, salary, department_id
      FROM
         employees e
      WHERE
      salary > (SELECT AVG(salary) FROM employees
      WHERE department_id = e.department_id);

/*markdown
Trong ví dụ trên truy vấn cha là:
SELECT
   employee_id, first_name || ' ' || last_name AS full_name, 
   salary, department_id
FROM employees e
WHERE salary >

Còn câu lệnh truy vấn con chính là:
SELECT AVG(salary) FROM employees
WHERE department_id = e.department_id

Câu lệnh truy vấn con bên trên sẽ phụ thuộc vào truy vấn cha bên ngoài để có thể thực hiện tính toán. Với mỗi nhân viên từ bảng EMPLOYEES, Database sẽ thực hiện truy vấn con để tính toán trung bình lương cho mỗi phòng ban.

*/

/*markdown
    • Toán tử EXISTS là 1 toán tử Boolean, tức là chỉ có 2 giá trị được trả về là True hoặc False, thường được sử dụng với các câu lệnh truy vấn con tương quan để kiểm tra sự tồn tại của các bản ghi dữ liệu. EXISTS sẽ trả về True nếu truy vấn trả về bất kỳ bản ghi nào, ngược lại thì sẽ trả về False.
*/

--  Sau đây là ví dụ về cách sử dụng toán tử EXISTS. Câu lệnh sau sẽ trả về các nhân viên không có trong danh sách làm việc ở quá khứ.

SELECT
    employee_id, 
    first_name || ' ' || last_name AS full_name
FROM employees e
WHERE NOT EXISTS (
    SELECT * FROM job_history j
    WHERE j.employee_id = e.employee_id
);


-- Câu lệnh trên sẽ tương đương với câu lệnh sử dụng truy vấn con thông thường như sau.
SELECT
    employee_id, 
    first_name || ' ' || last_name AS full_name
FROM employees
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM job_history
);


/*markdown
EXISTS vs IN
Nội dung bài học
    • Khi Toán tử EXISTS sẽ dừng tiến trình quét các bản ghi một khi truy vấn con trả về bản ghi đầu tiên (True nếu có bất kỳ bản ghi nào được trả về). Còn toán tử IN buộc phải quét tất cả bản ghi trả về từ truy vấn con thì với ra kết quả được.
    • Hơn nữa, toán tử IN không so sánh được với giá trị NULL, nhưng toán tử EXISTS thì có. 

*/

-- Ví dụ với 2 câu lệnh sau đây, câu lệnh thứ nhất sẽ không trả về dữ liệu nào cả còn câu lệnh thứ hai sẽ trả về tất cả bản ghi từ bảng EMPLOYEES.
SELECT * FROM employees
WHERE employee_id IN (NULL);
----------------------------
SELECT * FROM employees
WHERE EXISTS (
   SELECT NULL FROM DUAL
);
