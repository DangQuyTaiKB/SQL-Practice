/*markdown
- Giới thiệu kiểu dữ liệu số và các hàm chuyển đổi dữ liệu với số trong SQL.
- Sử dụng các hàm phổ biến thường gặp khi thao tác với số.
- Cách sử dụng bảng ảo DUAL để thao tác với dữ liệu không lấy từ các bảng cụ thể nào cả.

https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Single-Row-Functions.html#GUID-AC0E8A99-5097-4147-8295-C88EAC5AA362
*/

-- round, truncate, mod functions
select round(123.456, 2) as round, truncate(123.456, 2) as truncate, mod(123, 10) as mod
from dual;



select ename, sal, mod(sal, 1000) from emp
order by 3 desc;

-- Viết câu lệnh tính giá trị làm tròn lên của 1 số thập phân.
SELECT CEIL(3.56) FROM DUAL;
-- hàm CEIL() sẽ làm tròn lên số nguyên nhỏ nhất lớn hơn số được chỉ định

-- Viết câu lệnh tính giá trị làm tròn xuống của 1 số thập phân.
SELECT FLOOR(3.56) FROM DUAL;
-- hàm FLOOR() sẽ làm tròn xuống số nguyên lớn nhất nhỏ hơn số được chỉ định