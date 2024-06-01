/*markdown
- Sử dụng mệnh đề WHERE trong câu lệnh SELECT.
- Cách kết hợp các điều kiện với nhau khi chọn lọc dữ liệu.
- Lưu ý giá trị NULL khi sử dụng câu lệnh SELECT.
- Sắp xếp dữ liệu khi truy vấn với mệnh đề ORDER BY.
- Using EMP and DEPT tables. Classic tables with 4 departments and 14 employees.
*/

-- check data
SELECT * FROM emp;

-- tìm những nhân viên có lương hơn 2000
SELECT * FROM emp WHERE sal > 2000;

SELECT ename, job, sal FROM emp WHERE sal > 2000;

-- and
SELECT ename, job, sal FROM emp WHERE sal > 2000 AND deptno = 10;

-- or
SELECT ename, job, sal FROM emp WHERE sal > 2000 OR deptno = 10;

-- lọc những nhân viên có COMMISSION IS NULL
-- NULL là giá trị không xác định không được dùng các giá trị so sánh như =, <, >, <=, >=
SELECT * from emp WHERE comm IS NULL;

select * from emp where comm is not null;

-- săp xếp dữ liệu sử dụng order by
--  mặc định là sắp xếp dữ liệu theo cột sal tăng dần
select * from emp where comm is not null order by sal;

-- dùng desc để sắp xếp dữ liệu theo cột sal giảm dần
select * from emp where comm is not null order by sal desc;


-- Thứ tự ưu tiên khi thực hiện nhiều điều kiện and và or lồng nhau
-- and có độ ưu tiên cao hơn or
-- trong thực tế nên sử dụng dấu ngoặc để rõ ràng hơn

select * from emp where ename like '%N%' and sal > 1000 or deptno = 30;

-- tương đương với
select * from emp where (ename like '%N%' and sal > 1000) or deptno = 30;

-- tương đương với
select * from emp where deptno = 30 or (ename like '%N%' and sal > 1000);
