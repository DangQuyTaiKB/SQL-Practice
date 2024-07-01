/*markdown
tạo bảng mẫu:
*/

create table courses (
  course_name  varchar2(30),
  rank         integer,
  price        number(5,2),
  purchased_date date,
  expried_date   date
);
insert into courses values ('SQL nang cao', 4,  9.99,  date'2018-02-01', date'2018-06-01');
insert into courses values ('SQL co ban',   1,  5.00,  date'2016-09-01', date'2017-03-03');
insert into courses values ('Quan Tri Oracle',      10, 29.99, date'2017-03-01', date'2018-06-01');
insert into courses values ('Quan Tri SQL Server',  8,  29.99, date'2018-02-01', null);
commit;

-- Khi thực hiện truy vấn mà không có sắp xếp dữ liệu thì các bản ghi được trả về từ kết quả câu truy vấn sẽ được xếp theo thứ tự INSERT vào bảng lúc đầu. 
-- Ví dụ SELECT tất cả bản ghi từ bảng trên sẽ trả về kết quả như sau.

select * from courses;

-- Để có thể sắp xếp dữ liệu theo một thứ tự nhất định, trong câu lệnh truy vấn phải có thêm mệnh đề order by, sau đó là cột muốn dùng để sắp theo thứ tự các bản ghi theo. 
-- Ví dụ sắp xếp khóa học theo giá tiền của các khóa
SELECT * FROM courses ORDER BY price;

-- sắp xếp khóa học theo ngày tháng đăng ký học
SELECT * FROM courses ORDER BY purchased_date;

-- sắp xếp theo tên khóa học
SELECT * FROM courses ORDER BY course_name;


/*markdown
Mệnh đề order by mặc định sẽ sắp xếp theo thứ tự từ nhỏ đến lớn hoặc từ A-Z trong bảng chữ cái. 
Nếu muốn đảo ngược các thứ tự này ta sẽ sử dụng thêm từ khóa desc sau tên cột cần sắp xếp. 
*/

-- sắp xếp theo giá tiền của khóa học từ nhiều đến ít
SELECT * FROM courses ORDER BY price DESC;

-- Ngược lại với từ khóa desc là asc, nghĩa là sắp xếp theo chiều xuôi, hay tăng dần. Ví dụ sắp xếp theo giá tiền của khóa học từ nhỏ đến lớn.
SELECT * FROM courses ORDER BY price ASC;

/*markdown
Khi thực hiện sắp xếp theo một cột duy nhất, nếu có 2 giá trị bằng nhau thì CSDL sẽ lại sắp xếp theo thứ tự được insert vào bảng. Để tránh điều này xảy ra ta có thể chỉ định mệnh đề order by sắp xếp theo 2 cột trong bảng.
*/

-- Ví dụ sắp xếp theo giá tiền và cấp độ (rank) của khóa học theo thứ tự tăng dần.
SELECT * FROM courses ORDER BY price ASC, rank ASC;

/*markdown
Có thể thực hiện sắp xếp mà không cần chỉ định rõ tên cột mà chỉ cần vị trí hay số thứ tự của cột đó trong câu lệnh truy vấn như sau.
*/

-- Ví dụ sắp xếp khóa học theo giá tiền và ngày tháng đăng ký.
select course_name, price, rank, purchased_date from courses order by 2, 4;

-- Nếu trong cột có giá trị null thì bản ghi chứa giá trị null đó sẽ được xếp cuối cùng.
select * from courses order by expried_date;


/*markdown
Nếu muốn các giá trị null này đẩy lên đầu kết quả mà không làm thay đổi thứ tự mong muốn (không dùng desc để đảo lại lên đầu) ta sẽ dùng từ khóa nulls first như sau.
*/

select * from courses order by expried_date nulls first;