/*markdown
Common Table Expression cho phép người dùng đặt tên cho 1 đoạn truy vấn trong SQL. Sau đó ta có thể sử dụng lại nó ở bất kỳ đâu trong câu lệnh truy vấn của mình. Mục đích chính của Common Table Expression là để tránh lặp lại 1 đoạn code quá nhiều lần mà vẫn đảm bảo câu lệnh dễ hiểu và dễ thực thi nhất có thể.

Common Table Expression đi với từ khóa with as như sau. Ví dụ câu lệnh truy vấn đếm số sách cho từng danh mục sử dụng Common Table Expression
*/

with book_category_counts as (
  select category, count(*) 
  from   books
  group  by category
) select * from book_category_counts;

/*markdown
Vì Common Table Expression được sử dụng như 1 bảng thông thường trong câu lệnh truy vấn, nên ta có thể sử dụng lại bất kỳ đâu, bao nhiêu lần tùy ý trong câu lệnh SQL của mình.
*/

-- Ví dụ câu lệnh truy vấn sau tìm danh mục có số lượng sách nhiều hơn số lượng tối thiểu và số lượng sách trung bình của danh mục đó.
select c.category_name, 
       c.minimum_quantity, (
         select avg ( count(*) )
         from   books b
         group  by b.category
       ) mean_books_per_category
from   categories c
where  c.minimum_quantity < (
  select count(*) c
  from   books b
  where  b.category = c.category_name
  group  by b.category
);


/*markdown
Để ý trong câu lệnh trên ta sử dụng mệnh đề group by category 2 lần. Nếu giả sử ta thay đổi thành join bảng sách với bảng nào đó khác không phải category thì ta sẽ phải sửa mệnh đề group by nhiều lần. Sử dụng Common Table Expression ta chỉ cần viết 1 lần mệnh đề group by như sau, kết quả trả về cũng tương tự như câu lệnh truy vấn bên trên.
*/

with book_counts as (
  select b.category, count(*) c
  from   books b
  group  by b.category
)
select c.category_name, 
c.minimum_quantity, (
        select avg ( bc.c )
        from   book_counts bc
    ) mean_books_per_category
from   categories c
where  c.minimum_quantity < (
select bc.c
from   book_counts bc
where  bc.category = c.category_name
);

/*markdown
Việc sử dụng mệnh đề with as với Common Table Expression có nhiều lợi ích hơn bạn tưởng. Khi viết các câu lệnh truy vấn, để người đọc dễ hình dung và dễ hiểu câu lệnh SQL hơn (human readable code), ta nên viết code cho câu lệnh một cách rõ ràng rành mạch lần lượt từng ý. 

SỬ dụng truy vấn con cũng tốt nhưng nó thường làm người đọc bị rối khi đọc hiểu code không phải do mình viết ra. Với with as và Common Table Expression, ta hoàn toàn có thể làm được điều này. 

Ví dụ muốn tìm sách nào có số lượng ít hơn trung bình từng danh mục ta cần thực hiện 3 bước như sau:

1. Đếm số lượng sách theo từng danh mục
2. Tính trung bình mỗi danh mục
3. Trả về sách có kết quả từ bước 2 lớn kết quả từ bước 1
*/

-- Nếu sử dụng truy vấn con thì câu lệnh SQL sẽ như sau.
select category from   books
group  by category  
having count (*) < (
  select avg ( category_count ) 
  from (select category, count (*) category_count
    from   books group  by category)
);

/*markdown
Câu lệnh trên dù trông khá ngắn nhưng lại tương đối khó hiểu, không rõ ý 3 bước như ta mường tượng trước đó. Sử dụng  with as và Common Table Expression ta sẽ có câu lệnh như sau thỏa mãn mong muốn đặt ra trước đo.
*/

with book_counts as ( 
  -- 1. Đếm số lượng sách theo từng danh mục
  select b.category, count(*) c
  from   books b
  group  by b.category
), average_books_per_category as ( 
  -- 2. Tính trung bình mỗi danh mục (từ kết quả bước 1)
  select avg ( c ) average_count
  from   book_counts
) select * from book_counts bc  
  join   average_books_per_category ac
  -- 3. Trả về sách có kết quả từ bước 2 lớn kết quả từ bước 1
  on     bc.c < average_count;