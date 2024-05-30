/*markdown
Using EMP and DEPT tables. Classic tables with 4 departments and 14 employees.
*/

-- check data
SELECT * FROM emp;

-- tìm những nhân viên có lương hơn 2000
SELECT * FROM emp WHERE sal > 2000;

SELECT ename, job, sal FROM emp WHERE sal > 2000;