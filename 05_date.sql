/*markdown
- Giới thiệu kiểu dữ liệu ngày tháng và các hàm chuyển đổi dữ liệu với ngày tháng trong SQL.
- Sử dụng các hàm phổ biến thường gặp khi thao tác với ngày tháng.
https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Single-Row-Functions.html#GUID-5652DBC2-41C7-4F07-BEDD-DAF620E35F3C
*/

-- Viết câu lệnh xem ngày tháng hiện tại trong Oracle
SELECT SYSDATE AS CURRENT_DATE 
FROM DUAL; 
-- hoặc
SELECT CURRENT_DATE 
FROM DUAL;
-- Lưu ý sự khác biệt của 2 hàm trên:
-- SYSDATE trả về ngày tháng của OS hiện đang chứa Database
-- CURRENT_DATE trả về ngày tháng dựa theo Timezone

-- Viết câu lệnh xem ngày tháng hôm qua và hôm kia trong Oracle
SELECT SYSDATE - 1 AS YESTERDAY,
       SYSDATE - 2 AS DAY_BEFORE_YESTERDAY
FROM DUAL;

-- Viết câu lệnh xem ngày tháng hiện tại có hiển thị thêm Timestamp và Timezone

SELECT SYSTIMESTAMP AS DATE_WITH_TIMESTAMP_TZ
FROM DUAL;

-- Viết câu lệnh chuyển định dạng ngày tháng hiện tại thành ví dụ như sau 2022-11-14
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS DATE_FORMAT
FROM DUAL;

-- Viết câu lệnh chuyển ngày tháng hiện tại thành định dạng giờ phút ví dụ như sau 12:37:45
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS TIME_FORMAT
FROM DUAL;


-- Viết câu lệnh hiển thị thời gian làm việc tính bằng tháng đã làm việc tại công ty đối với từng nhân viên, sắp xếp kết quả số tháng theo chiều giảm dần.
select ename, months_between(sysdate, hiredate) as months_worked from emp order by months_worked desc;

-- hoặc
SELECT 
   last_name, 
   ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) months_worked
FROM employees 
ORDER BY months_worked;


