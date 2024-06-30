-- Tạo bảng mẫu dữ liệu về sách như sau và thêm bản ghi vào bảng.
create table books (
  book_id              integer not null primary key,
  book_name            varchar2(100) not null,
  price                integer not null,
  author               varchar2(100),
  category             integer,
  volume_of_carton     integer
);
insert into books 
values (1, 'Toi uu CSDL', 100, 'Huy TQ', null, 10);
insert into books 
values (2, 'Toi uu SQL', 80, 'Huy TD', 1, null);
insert into books 
values (3, 'Quan tri CSDL', 50, null, 2, 1);
commit; 

-- Truy vấn toàn bộ bảng vừa tạo trên sẽ thấy các giá trị NULL (hiển thị là dấu “-” trong Oracle LiveSQL).
select * from books;

-- Giá trị NULL không thể được so sánh với bất kỳ giá trị nào khác vì NULL thực chất không có gì cả. 
-- Khi thực hiện truy vấn với mệnh đề WHERE, điều kiện sau sẽ là vô nghĩa trong SQL: null = <…>.

-- Ví dụ câu lệnh truy vấn sau để tìm sách không có tên tác giả sẽ không trả về bản ghi nào trên bảng vì các phép so sánh thông thường với NULL là vô nghĩa.
select * from books
where author = null;

select * from books
where author <> null;

-- Để tìm các bản ghi có chứa giá trị NULL, ta phải dùng đến toán tử IS như sau để so sánh được với các giá trị là NULL.

-- Ví dụ câu lệnh truy vấn tìm các quyển sách không được phân loại danh mục hay danh mục của nó là NULL trong bảng.
select * from books
where category is null;

-- Hoặc tìm các quyển sách đã được phân loại danh mục (không phải giá trị NULL trên cột danh mục). 
select * from books
where category is not null;

-- Với các phép so sánh hơn hoặc kém, các bản ghi có NULL sẽ bị loại khỏi kết quả trả về từ câu truy vấn.

-- Ví dụ câu lệnh sau tìm các quyển sách có lượng bìa các-tông nhờ hơn 15%.

select * from books
where volume_of_carton < 15;

-- Để kết quả trả về có thêm cả các bản ghi có giá trị NULL ở cột lượng bìa các-tông, ta sẽ thêm điều kiện sau trong câu lệnh. 
select * from books
where volume_of_carton < 15 or volume_of_carton is null;