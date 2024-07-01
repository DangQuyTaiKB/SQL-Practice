/*markdown
Toán tử EXISTS là 1 toán tử Boolean, tức là chỉ có 2 giá trị được trả về là True hoặc False, thường được sử dụng với các câu lệnh truy vấn con tương quan để kiểm tra sự tồn tại của các bản ghi dữ liệu. EXISTS sẽ trả về True nếu truy vấn trả về bất kỳ bản ghi nào, ngược lại thì sẽ trả về False.

Sau đây là ví dụ về cách sử dụng toán tử EXISTS. Câu lệnh sau sẽ trả về các nhân viên có trong danh sách làm việc ở quá khứ.
*/

select * from employees e
where exists (
    select * from job_history j
    where j.employee_id = e.employee_id
);

-- Hoặc ngược lại trả về các nhân viên không có trong danh sách làm việc ở quá khứ thêm toán tử NOT.
select * from employees e
where not exists (
    select * from job_history j
    where j.employee_id = e.employee_id
);

/*markdown
EXISTS vs. IN 

Khi Toán tử EXISTS sẽ dừng tiến trình quét các bản ghi một khi truy vấn con trả về bản ghi đầu tiên (True nếu có bất kỳ bản ghi nào được trả về). Còn toán tử IN buộc phải quét tất cả bản ghi trả về từ truy vấn con thì với ra kết quả được.
Hơn nữa, toán tử IN không so sánh được với giá trị NULL, nhưng toán tử EXISTS thì có. Ví dụ với 2 câu lệnh sau đây, câu lệnh thứ nhất sẽ không trả về dữ liệu nào cả còn câu lệnh thứ hai sẽ trả về tất cả bản ghi từ bảng EMPLOYEES.
*/

select * from employees
where employee_id in (null);

select * from employees
where exists ( select null from DUAL );