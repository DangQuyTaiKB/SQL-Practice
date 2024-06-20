/*markdown
- Tạo bảng trong cơ sở dữ liệu với câu lệnh CREATE TABLE.
- Chú ý kiểu dữ liệu cho các cột khi tạo bảng.
- Khái niệm ràng buộc hay CONSTRAINT trong SQL.
- Cách sử dụng khóa chính, khóa ngoại trong cơ sở dữ liệu.
*/

-- tạo bảng
CREATE TABLE wecommit (
    id NUMBER NOT NULL PRIMARY KEY,
    name VARCHAR2(100) DEFAULT 'Wecommit',
    salary NUMBER NOT NULL CHECK (salary > 1000),
    deptno NUMBER,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES depttb(deptno)
);

-- constraint bản chất là ràng buộc dữ liệu
-- constraint có thể là ràng buộc dữ liệu hoặc ràng buộc khóa ngoại
-- ràng buộc dữ liệu: check, unique, not null
-- ràng buộc khóa ngoại: foreign key
-- ràng buộc khóa chính: primary key = unique + not null

-- foreign key: ràng buộc khóa ngoại
-- foreign key (deptno) references depttb(deptno)
-- deptno là khóa ngoại, depttb là bảng chứa khóa chính, deptno là khóa chính

-- unique: ràng buộc dữ liệu, giá trị không được trùng
-- unique (id)

-- not null: ràng buộc dữ liệu, giá trị không được null
-- not null (id)