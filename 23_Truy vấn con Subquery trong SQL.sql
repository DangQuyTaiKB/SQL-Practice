/*markdown
Gần giống với Inline View, truy vấn con nằm sẽ nằm ở mệnh đề WHERE trong câu lệnh SQL. Câu truy vấn sẽ lọc dữ liệu trên bảng cha từ truy vấn trên bảng con.

Ví dụ tìm tất cả danh mục có trong bảng sách, sử dụng toán tử IN để lọc các bản ghi có trong truy vấn bảng cha bên ngoài từ các bản ghi trả về từ truy vấn con.
*/

select * from categories c
where  c.category_name in (
  select b.category from books b
);

-- Ví dụ câu lệnh sau dùng 2 truy vấn con lồng nhau để tìm xem những quyển sách  nào danh mục mà số lượng cho phép tối thiểu của nó lớn nhất trong số tất cả danh mục.
select * from books
where category = (
    select category_name from categories
where minimum_quantity = (
select max(minimum_quantity) 
     from categories
));