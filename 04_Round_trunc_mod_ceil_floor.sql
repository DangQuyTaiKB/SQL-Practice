/*markdown
- Giới thiệu kiểu dữ liệu số và các hàm chuyển đổi dữ liệu với số trong SQL.
- Sử dụng các hàm phổ biến thường gặp khi thao tác với số.
- Cách sử dụng bảng ảo DUAL để thao tác với dữ liệu không lấy từ các bảng cụ thể nào cả.
*/

-- round, truncate, mod functions
select round(123.456, 2) as round, truncate(123.456, 2) as truncate, mod(123, 10) as mod
from dual;


select ename, sal, mod(sal, 1000) from emp
order by 3 desc;