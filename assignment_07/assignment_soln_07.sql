--Part A: Basic Subqueries 
--1. Display names of students who belong to the same department as student ‘S401

SELECT Name
FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Student
    WHERE Student_ID = 'S401'
);

--2. Display students who have the same gender as student ‘S402’
SELECT Name
FROM Student
WHERE Gender = (
    SELECT Gender
    FROM Student
    WHERE Student_ID = 'S402'
);

--3. Display students belonging to the same department as ‘S403’.
SELECT Name
FROM Student
WHERE Dept_ID = (
    SELECT Dept_ID
    FROM Student
    WHERE Student_ID = 'S403'
);

--Part B: Subqueries with IN 
--4. Display students whose DepartmentID exists where Gender is ‘Female’. 

SELECT Name
FROM Student
WHERE Dept_ID IN (
    SELECT Dept_ID
    FROM Student
    WHERE Gender = 'Female'
);

--5. Display students whose StudentID appears in the Enrollment table. 
select name 
from student 
where student_id in(
 select student_id 
from enrollment
 );

--6. Display students who are enrolled in any course.
SELECT Name
FROM Student
WHERE EXISTS (
    SELECT *
    FROM Enrollment
    WHERE Student.Student_ID = Enrollment.Student_ID
);

--Part C: Subqueries with Aggregate Functions 
--7. Display courses having credits greater than average credits.
SELECT Course_Name
FROM Course
WHERE Credits > (
    SELECT AVG(Credits)
    FROM Course
);

--8. Display students whose StudentID is greater than the average StudentID (assume numeric comparison).
SELECT Name
FROM Student
WHERE Student_ID > (
    SELECT AVG(Student_ID)
    FROM Student
);
 
--9. Display departments having more students than the average number of students per department.
SELECT Dept_ID
FROM Student
GROUP BY Dept_ID
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Student
        GROUP BY Dept_ID
    )
);

--Part D: Subqueries Instead of JOIN 
--10. Display names of students who are enrolled in courses (without using JOIN).
department.
SELECT Name
FROM Student
WHERE Student_ID IN (
    SELECT Student_ID
    FROM Enrollment
);

--11. Display students who are allocated to any department (using subquery logic).
SELECT Name
FROM Student
WHERE Dept_ID IN (
    SELECT Dept_ID
    FROM Student
);

--12. Display courses that have at least one student enrolled .
SELECT Course_Name
FROM Course
WHERE Course_ID IN (
    SELECT Course_ID
    FROM Enrollment
);

--Part E: Analytical Subqueries 
--13. Display the course with maximum credits
SELECT Course_Name
FROM Course
WHERE Credits = (
    SELECT MAX(Credits)
    FROM Course
);

--14. Display students who are enrolled in more than one course
SELECT Student_ID
FROM Enrollment
GROUP BY Student_ID
HAVING COUNT(Course_ID) > 1;


--15. Display departments having the maximum number of students.
SELECT Student_ID
FROM Enrollment
GROUP BY Student_ID
HAVING COUNT(Course_ID) > 1;
SELECT Dept_ID
FROM Student
GROUP BY Dept_ID
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Student
        GROUP BY Dept_ID
    )
);

--Part F: Challenging Questions 
--16. Display students who are enrolled in the same course as student ‘S401'.
SELECT Name
FROM Student
WHERE Student_ID IN (
    SELECT Student_ID
    FROM Enrollment
    WHERE Course_ID IN (
        SELECT Course_ID
        FROM Enrollment
        WHERE Student_ID = 'S401'
    )
);

--17. Display students who are not enrolled in any course
SELECT Name
FROM Student
WHERE Student_ID NOT IN (
    SELECT Student_ID
    FROM Enrollment
);

--18. Display courses that have no students enrolled
SELECT Course_Name
FROM Course
WHERE Course_ID NOT IN (
    SELECT Course_ID
    FROM Enrollment
);