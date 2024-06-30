/*markdown
Không giống các câu lệnh truy vấn con thông thường, Correlated Subquery hay dịch ra là “truy vấn con tương quan” sẽ sử dụng chính dữ liệu từ câu lệnh truy vấn cha làm input cho mình để trả về kết quả mong muốn cho người dùng. 

Thực hiện tạo 3 bảng như sau mô tả nhân viên, phòng ban và danh sách làm việc quá khứ để mô tả truy vấn con tương quan.
*/

create table employees (
  employee_id    integer,
  employee_name  varchar2(10),
  department_id  integer,
  salary  integer
);
create table departments (
  department_id    integer,
  department_name  varchar2(10)
);
create table job_history (
  employee_id   integer,
  start_date    date, 
  end_date      date  
);
insert into employees values ( 1, 'HuyTQ', 1, 3000 );
insert into employees values ( 2, 'HuyTD', 1, 3000 );
insert into employees values ( 3, 'OanhLT', 2, 2000 );
insert into employees values ( 4, 'TuanTD', 3, 1500 );
insert into employees values ( 5, 'NamNK', 3, 1000 );
insert into employees values ( 6, 'DuongVP', 4, 1800 );
insert into employees values ( 7, 'DongPV', 4, 1500 );
insert into departments values ( 1, 'MNG');
insert into departments values ( 2, 'ACC');
insert into departments values ( 3, 'TEC');
insert into departments values ( 4, 'SUP');
insert into job_history values ( 1, '05-OCT-16', '22-MAR-23');
insert into job_history values ( 2, '05-OCT-16', '22-MAR-23');
insert into job_history values ( 4, '20-MAR-20', '22-MAR-23');
insert into job_history values ( 6, '14-JUL-21', '22-MAR-23');
insert into job_history values ( 7, '14-JUL-21', '22-MAR-23');
commit;

-- Ví dụ tìm nhân viên có lương cao hơn trung bình lương phòng ban của mình.
select * from employees e
where salary > (
   select avg(salary) from employees
   where department_id = e.department_id
);

Trong ví dụ trên thì truy vấn cha là:
select * from employees e
where salary > ...

-- Còn câu lệnh truy vấn con là:
select avg(salary) from employees
   where department_id = e.department_id

/*markdown
Câu lệnh truy vấn con bên trên sẽ phụ thuộc tương quan vào truy vấn cha bên ngoài để có thể thực hiện tính toán kết quả của nó. Với mỗi nhân viên từ bảng EMPLOYEES, câu lệnh sẽ thực hiện truy vấn con để tính toán trung bình lương cho mỗi phòng ban.
*/