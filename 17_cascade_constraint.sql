/*markdown
Trong Oracle còn có 1 loại ràng buộc nữa gọi là Cascade, ràng buộc này cho phép thực hiện các lệnh DROP cột hay bảng hay DELETE bản ghi có ràng buộc Foreign Key với bảng khác. 
Khi thực hiện tạo bảng với khóa ngoại, ta có thể chỉ định thêm điều kiện ON DELETE CASCADE như sau. 
Lấy ví dụ tạo 2 bảng sau có liên kết với nhau bằng khóa ngoại như sau.
*/

CREATE TABLE supplier
( supplier_id numeric(10) not null,
  supplier_name varchar2(50) not null,
  contact_name varchar2(50),
  CONSTRAINT supplier_pk PRIMARY KEY (supplier_id)
);

CREATE TABLE products
( product_id numeric(10) not null,
  supplier_id numeric(10) not null,
  CONSTRAINT fk_supplier
    FOREIGN KEY (supplier_id)
    REFERENCES supplier(supplier_id)
);

INSERT INTO supplier values(10, '1st Supplier', 'John Dollan');
INSERT INTO supplier values(20, '2nd Supplier', 'Steve Reeves');
INSERT INTO supplier values(30, '3rd Supplier', 'Peter Marcello');

INSERT INTO products values(1, 10);
INSERT INTO products values(2, 10);
INSERT INTO products values(3, 10);
INSERT INTO products values(4, 20);
INSERT INTO products values(5, 20);
INSERT INTO products values(6, 30);

/*markdown
Ta sẽ thực hiện xóa dữ liệu trên bảng cha và nhận được thông báo lỗi như sau. Cụ thể thì Oracle không cho phép thực hiện xóa bản ghi trên bảng cha vì bản ghi đó đang có khóa ngoại tương ứng trên bảng.

DELETE FROM supplier WHERE supplier_id = 10;

    ORA-e2292: integrity constraint (SQL_MKDZAZBIJIFIWGKUPBLMCDVRN. FK_SUPPLIER) violated child record found ORA-ess12; at "sys.D3Ms_SQL", line 1721 


*/

-- Sau đây ta sẽ thực hiện xóa ràng buộc khóa ngoại trên bảng con đi và tạo lại khóa ngoại mới với điều kiện ON DELETE CASCADE như sau.
ALTER TABLE products
DROP CONSTRAINT fk_supplier;

ALTER TABLE products
ADD CONSTRAINT fk_supplier
  FOREIGN KEY (supplier_id)
  REFERENCES supplier(supplier_id)
  ON DELETE CASCADE;

--   Ta thấy câu lệnh xóa bản ghi bên trên đã thực hiện thành công và bản ghi trên bảng con cũng tự động được xóa theo bảng cha nhờ điều kiện ON DELETE CASCADE.
DELETE FROM supplier WHERE supplier_id = 10;
SELECT * FROM products WHERE supplier_id = 10;

-- Khi muốn DROP bảng cha ta sẽ gặp lỗi như sau do bảng cha đang có liên kết khóa ngoại với bảng con.
DROP TABLE supplier;

-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- Lúc này ta sẽ sử dụng thêm mệnh đề CASCADE CONSTRAINT như sau trong câu lệnh DROP TABLE. Mệnh đề CASCADE CONSTRAINT không chỉ xóa bảng mà còn xóa luôn cả khóa ngoại trên bảng con (products). Nếu bạn thực hiện truy vấn để xem thông tin khóa ngoại trên bảng con, sẽ không có kết quả nào trả về cả.
DROP TABLE supplier CASCADE CONSTRAINTS;