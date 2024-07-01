/*markdown
Truy vấn con vô hướng hay Scalar Subquery là câu lệnh truy vấn chỉ trả về 1 cột và tối đa 1 bản ghi. Ví dụ câu lệnh truy vấn trả về số lượng sách ứng với mỗi danh mục (sử dụng lại bảng sách và danh mục đã tạo bên trên).
*/

select category_name, (
select count(*) from books b
where  b.category = c.category_name
group  by b.category
) book_counts from categories c;

/*markdown
Trong câu lệnh truy vấn trên, ta cần phải join bảng sách và danh mục với nhau ở mệnh đề where b.category = c.category_name. Nếu không làm như vậy, kết quả trả về sẽ có 4 dòng cho mỗi danh mục khác nhau của sách và dẫn đến thông báo lỗi ORA-01427.
*/

select category_name, (
select count(*) from books b
group  by b.category
) book_counts from categories c;

/*markdown
Thông thường bạn sẽ dùng truy vấn con vô hướng tương quan với bảng cha để trả về kết quả chính xác. Ví dụ thay vì sử dụng join như bên trên, ta có thể viết truy vấn để tìm sách có số lượng ít hơn số lượng tối thiểu cho phép như sau.
*/

select category, count(*) c
from   books b
group  by category
having count(*) < (
  select c.minimum_quantity
  from   categories c
  where  c.category_name = b.category
);