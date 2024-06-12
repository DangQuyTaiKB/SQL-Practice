/*markdown
8/6/2024
Tìm hiểu về:
- Outer Join
- Left Join
- Right Join 
- Full Outer Join
- using HR Schema (Oracle Live SQL)
https://livesql.oracle.com/apex/f?p=590:41:15929362708296:::41:P41_ID:148405776030629168359882238551164482016



*/

-- đếm số bản ghi khi sử dụng các phép join

-- left outer join
select count(*) from employees e left outer join departments d 
on e.department_id = d.department_id;  --- 107 rows

-- right join
select count(*) from employees e right outer join departments d
on e.department_id = d.department_id;  --- 122 rows

-- full join
select count(*) from employees e full outer join departments d
on e.department_id = d.department_id;  --- 122 rows




-- Viết câu lệnh hiển thị tên nhân viên, mã nhân viên và thông tin của người quản lý của nhân viên đó.

SELECT 
   e.last_name employee, e.employee_id emp_id, 
   m.last_name manager, m.employee_id mng_id 
FROM employees e JOIN employees m 
   ON e.manager_id = m.employee_id;

-- Chỉnh sửa câu lệnh ở trên để sao cho hiển thị cả những nhân viên không có người quản lý.

SELECT 
   e.last_name employee, e.employee_id emp_id, 
   m.last_name manager, m.employee_id mng_id
FROM employees e LEFT OUTER JOIN employees m
    ON e.manager_id = m.employee_id;

-- Viết câu lệnh hiển thị tất cả Last name, mã phòng ban và tên của các đồng nghiệp làm cùng phòng ban với người đó.
SELECT 
   e.department_id department, 
   e.last_name employee,
   c.last_name colleague
FROM employees e JOIN employees c
   ON e.department_id = c.department_id
WHERE e.employee_id <> c.employee_id;

-- Viết câu lệnhhiển thị các nhân viên được tuyển dụng sau nhân viên Davies..
SELECT 
   e.last_name, e.hire_date 
FROM employees e JOIN employees davies 
   ON davies.last_name = 'Davies' 
WHERE davies.hire_date < e.hire_date;

-- Viết câu lệnh hiển thị các nhân viên được tuyển vào trước người quản lý của họ.
SELECT 
   w.last_name, w.hire_date, 
   m.last_name, m.hire_date
FROM employees w JOIN employees m 
   ON w.manager_id = m.employee_id
WHERE w.hire_date < m.hire_date;