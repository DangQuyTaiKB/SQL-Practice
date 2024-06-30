-- Tạo các bảng mẫu dữ liệu về sách và phân loại sách như sau và thêm bản ghi từng bảng.
create table books (
  book_id    integer,
  category   varchar2(10)
);
create table categories (
  category_name    varchar2(10),
  minimum_quantity integer
);
insert into categories values ( 'Oracle', 4 );
insert into categories values ( 'SQL Server', 3 );
insert into categories values ( 'PostgreSQL', 2 );
insert into categories values ( 'MySQL', 1);
insert into categories values ( 'MongoDB', 1 );
insert into books values ( 1, 'Oracle' );
insert into books values ( 2, 'Oracle' );
insert into books values ( 3, 'Oracle' );
insert into books values ( 4, 'SQL Server' );
insert into books values ( 5, 'SQL Server' );
insert into books values ( 6, 'PostgreSQL' );
insert into books values ( 7, 'PostgreSQL' );
insert into books values ( 8, 'PostgreSQL' );
insert into books values ( 9, null );
insert into books values ( 10, 'MySQL' );
commit;

-- Truy vấn toàn bộ dữ liệu các bảng vừa tạo.
select * from books;
select * from categories;

/*markdown
Khi thực hiện các câu lệnh truy vấn con trong SQL, câu truy vấn nằm trong mệnh đề FROM được gọi là Inline View (hay Derived Table theo thuật ngữ của các hệ quản trị  CSDL khác). 

Ví dụ trong câu lệnh truy vấn như sau thì select * from books là một Inline View.
*/

select * from (
select * from books
);

-- Có thể dùng Inline View để thực hiện tính toán trung gian trong kết quả trả về từ truy vấn. 
-- Ví dụ đếm số lượng các loại sách hiện đang có trong bảng books.

select * from (
  select 
    nvl( category, 'N/A') AS category, 
    count(*) as quantity
  from   books
  group  by category
) book_counts;

-- Có thể sử dụng thêm mệnh đề JOIN trong câu lệnh truy vấn lồng để hiển thị kết quả thêm trực quan hơn. 
-- Ví dụ sau thực hiện truy vấn các loại sách hiện đang có ít hơn số lượng tối thiểu được đặt trước.
select * from (
  select category, 
    count(*) category_counts
  from  books
  group by category
) book_counts right join categories
on book_counts.category = categories.category_name
where nvl ( book_counts.category_counts, 0 ) < categories.minimum_quantity;