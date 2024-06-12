/*markdown
- Cách thức thực hiện các lệnh truy vấn lồng trong SQL.
- Các toán tử và mệnh đề thường được sử dụng khi thực hiện truy vấn lồng.
*/

-- Single-row query
SELECT last_name, job_id, salary
FROM employees
WHERE   job_id = (SELECT job_id
                    FROM employees
                    WHERE last_name = 'Taylor' AND first_name = 'Jonathon')
        AND salary > (SELECT salary
                        FROM employees
                        WHERE last_name = 'Taylor' AND first_name = 'Jonathon');

-- min
SELECT last_name, job_id, salary
FROM employees
WHERE   salary = (SELECT MAX(salary)
                    FROM employees);



-- multiple-row query

-- ALL
SELECT employee_id, job_id, salary
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
        AND job_id <> 'IT_PROG';

-- ANY
SELECT employee_id, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG')
        AND job_id <> 'IT_PROG';

-- IN 
SELECT employee_id, job_id, salary
FROM employees
WHERE job_id IN (SELECT job_id
                    FROM employees
                    WHERE job_id = 'IT_PROG')
        AND job_id <> 'IT_PROG';


