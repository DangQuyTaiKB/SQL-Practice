/*markdown
View trong Oracle về cơ bản chính là câu lệnh truy vấn được lưu lại trong Database. Giả sử có một câu lệnh truy vấn rất dài nào đấy và hàng tháng bạn phải thực hiện lại câu lệnh truy vấn này để báo cáo nên bạn sẽ tìm cách lưu nó vào đâu đấy dưới dạng text. Cách này không thực sự tối ưu vì mỗi lần cần thực hiện truy vấn bạn lại phải mở file text đó ra, copy rồi paste vào hệ thống để chạy. Oracle có 1 cách tối ưu nhanh hơn một chút đó là sử dụng View. Ta sẽ tạo 1 View để lưu lại câu truy vấn tìm tìm nhân viên lương cao nhất mỗi phòng ban như sau.
*/

CREATE VIEW max_salary_emp_each_dept_v
AS 
    SELECT department_id, first_name || ' ' || last_name AS full_name, 
    salary FROM employees e WHERE salary = ( 
        SELECT MAX(salary) FROM employees 
        WHERE department_id = e.department_id
    );

-- Sau này khi cần thực hiện truy vấn bạn sẽ không cần phải gõ lại câu lệnh SQL cũ nữa mà thay vào đó ta sẽ sử dụng View như sau.
SELECT * FROM max_salary_emp_each_dept_v;

/*markdown
Lưu ý 1 điều dễ hiểu nhầm khi sử dụng View đó là View không phải là 1 bảng nên nó không chứa dữ liệu bên trong, nội dung của nó được định nghĩa là do câu lệnh truy vấn tạo nên. Dữ liệu trả về khi truy vấn View thực tế vẫn nằm ở bảng mà nó được lấy ra chứ không được chuyển vào hay copy sang View để lưu như nhiều người lầm tưởng.
*/

/*markdown

Ngoài các kiểu dữ liệu cơ bản thông thường, Oracle còn hỗ trợ các kiểu dữ liệu đặc biệt khác gọi là kiểu dữ liệu “lớn” hay Large Object Data  (LOB). Đúng như tên gọi của mình, các kiểu dữ liệu này được dùng để lưu dữ liệu có kích thước lớn hơn dữ liệu text thông thường trên các bản ghi như ảnh, video, file PDF, v.v… .

- Đầu tiên là kiểu dữ liệu BLOB hay Binary LOB dùng để lưu dữ liệu dạng Binary như file ảnh, âm thanh hay video.
- Tiếp theo là CLOB (Character LOB) và NCLOB (National CLOB), dùng để lưu dữ liệu dạng chuỗi ký tự.
- Cuối cùng là BFILE hay Binary File, dùng để lưu dữ liệu là các binary file. Thực chất là lưu 1 địa chỉ hay con trỏ đến file đó nằm bên ngoài Database (filesystem trên máy chủ).

Một lưu ý quan trọng với kiểu dữ liệu dạng LOB đó là bạn không thể đặt cột có kiểu dữ liệu này làm Primary Key. Các kiểu dữ liệu LOB cũng không thể dùng trong các mệnh đề thông thường như ORDER BY, GROUP BY hay từ khóa DISTINCT.
*/