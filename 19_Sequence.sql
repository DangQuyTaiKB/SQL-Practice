/*markdown
Sequence trong Oracle là 1 chuỗi số nguyên (Integer) có thứ tự, tuân theo 1 quy tắc cố định mà người dùng đặt ra khi tạo ra Sequence. Ví dụ khi bạn muốn các cột trong bảng như ID, số thứ tự, v.v… có giá trị tự tăng dần mỗi khi thực hiện INSERT dữ liệu thay vì chỉ định thủ công viết giá trị bằng tay thì bạn có thể sử dụng đến Sequence.
*/

-- Để tạo Sequence ta sử dụng câu lệnh như sau.
CREATE SEQUENCE emp_seq
    MINVALUE 1000
    MAXVALUE 9999
    START WITH 1100
    INCREMENT BY 1
    CACHE 5;

/*markdown
Câu lệnh trên sẽ tạo 1 Sequence cho bảng nhân viên với giá trị nhỏ nhất MINVALUE là 1000, lớn nhất MAXVALUE là 9999. Số bắt đầu Sequence là 1100, mặc định nếu không chỉ định trong START WITH thì số bắt đầu sẽ là MINVALUE. Giá trị tăng INCREMENT BY của Sequence là 1.

Ngoài ra còn một vài tham số khác cũng quan trọng trong câu lệnh tạo Sequence như sau. Tham số CACHE <n> sẽ cấp phát trước bộ nhớ cho n giá trị tiếp của Sequence, giúp cho Oracle truy cập nhanh hơn, mặc định n = 2. Tham số CYCLE sẽ chỉ định Sequence tự tạo lại chuỗi số từ đầu khi chạm đến ngưỡng MAXVALUE. Ngược lại mặc định khi tạo Sequence nếu không chỉ định sẽ là NOCYCLE. 
*/

-- Ví dụ sau ta sẽ xem thử các giá trị trong Sequence với hàm NEXTVAL của Sequence (thêm “CONNECT BY LEVEL <= 5” để thực hiện lại câu lệnh 5 lần).
SELECT emp_seq.NEXTVAL AS EMP_SEQ_VALUE FROM DUAL
CONNECT BY level <= 5;

-- Sau đây ta sẽ thực hiện sử dụng Sequence khi INSERT dữ liệu trong 1 bảng để xem các giá trị của bản ghi đó với Sequence ra sao.
CREATE TABLE emp(
    id NUMBER PRIMARY KEY,
    name VARCHAR2(25) NOT NULL
);
INSERT INTO emp VALUES (emp_seq.NEXTVAL, 'ABC');
INSERT INTO emp VALUES (emp_seq.NEXTVAL, 'DEF');
INSERT INTO emp VALUES (emp_seq.NEXTVAL, 'XYZ');
SELECT * FROM EMP;

/*markdown
Ở đây ta thấy các giá trị của Sequence đã được tự động tạo ra và được INSERT vào bảng emp. Vì trước đó ta đã thực hiện emp.NEXTVAL 5 lần nên giá trị trong bảng sẽ là 1105, 1106 và 1107. Lưu ý khi thực hiện INSERT với Sequence, ta sẽ không thực hiện INSERT ALL nhiều bản ghi cùng lúc được vì INSERT ALL thực chất chỉ là 1 câu lệnh SQL. Khi đó giá trị tạo ra bởi Sequence sẽ giống hệt nhau thay vì tăng dần như đã đặt, dẫn đến lỗi nếu như cột sử dụng Sequence có ràng buộc Primary Key.
*/

-- Cũng như các Object khác trong Database, ta có thể chỉnh sửa hoặc xóa Sequence với câu lệnh ALTER và DROP như sau.
ALTER SEQUENCE emp_seq CACHE 10;
ALTER SEQUENCE emp_seq START WITH 2000;
DROP SEQUENCE emp_seq;