-- 1) Returning the number of students supervised by each Academic Advisor --

SELECT COUNT(StudentID) AS NumberOfStudents,Program.GroupName,AcademicAdvisors.AcademicAdvisorID,
AcademicAdvisors.FirstName,
AcademicAdvisors.LastName
FROM AcademicAdvisors
JOIN Program ON AcademicAdvisors.AcademicAdvisorID=Program.AcademicAdvisorID
JOIN Students ON Program.GroupID=Students.GroupID
GROUP BY AcademicAdvisors.AcademicAdvisorID,Program.GroupName
HAVING AcademicAdvisors.AcademicAdvisorID="1" OR (AcademicAdvisors.AcademicAdvisorID="2"
OR AcademicAdvisors.AcademicAdvisorID="3")
ORDER BY AcademicAdvisors.AcademicAdvisorID,Program.GroupName
ASC;

-- 2) Returning the program having the most failures,i.e,grades of less than 60 --

SELECT Grades.Grade,GroupOfProgram.ProgramName,COUNT(*) AS No_OfStudents
FROM Grades
JOIN Students ON Grades.StudentID=Students.StudentID
JOIN Program ON Grades.ProgramID=Program.ProgramID
JOIN GroupOfProgram ON Program.GroupID=GroupOfProgram.GroupID
GROUP BY Grades.Grade,GroupOfProgram.ProgramName
HAVING Grades.Grade<60
ORDER BY Grades.Grade,COUNT(*) 
DESC
LIMIT 1,1;

-- 3) Returning the name of teacher who has earned the most money and also its amount --

SELECT FirstName,LastName,HourlySalary FROM Teachers
WHERE HourlySalary=(SELECT MAX(HourlySalary) FROM Teachers);

-- 4) Returning the students with highest and lowest grade average per program --

SELECT GroupOfProgram.ProgramName,Students.StudentID,AVG(Grades.Grade)AS LowestAvg
FROM Grades 
JOIN Students ON Grades.StudentID=Students.StudentID
JOIN Program ON Grades.ProgramID=Program.ProgramID
JOIN GroupOfProgram ON Program.GroupID=GroupOfProgram.GroupID
GROUP BY Students.StudentID,GroupOfProgram.ProgramName,Students.StudentID
HAVING GroupOfProgram.ProgramName="MAD" OR GroupOfProgram.ProgramName="STS" 
ORDER BY AVG(Grades.Grade) 
ASC
LIMIT 2;

-- Students having the lowest grade average per program --

SELECT GroupOfProgram.ProgramName,Students.StudentID,AVG(Grades.Grade)AS HighestAvg
FROM Grades
JOIN Students ON Grades.StudentID=Students.StudentID
JOIN Program ON Grades.ProgramID=Program.ProgramID
JOIN GroupOfProgram ON Program.GroupID=GroupOfProgram.GroupID
GROUP BY Students.StudentID,GroupOfProgram.ProgramName,Students.StudentID
HAVING GroupOfProgram.ProgramName="MAD" OR GroupOfProgram.ProgramName="STS" 
ORDER BY AVG(Grades.Grade) 
DESC
LIMIT 2;

-- Students having the highest grade average per program --

-- 5) Returning the overall grade percentage of males and females --

SELECT AVG(AVGgrade) FROM
(SELECT AVG(Grades.Grade)AS AVGgrade,Students.FirstName,Students.LastName,Students.Sex
FROM Students
JOIN Grades ON Students.StudentID=Grades.StudentID
GROUP BY Students.FirstName,Students.LastName,Students.Sex
HAVING Students.Sex="Male")
AS Avg;

SELECT AVG(AVGgrade) FROM
(SELECT AVG(Grades.Grade)AS AVGgrade,Students.FirstName,Students.LastName,Students.Sex
FROM Students
JOIN Grades ON Students.StudentID=Grades.StudentID
GROUP BY Students.FirstName,Students.LastName,Students.Sex
HAVING Students.Sex="Female")
AS Avg;

-- Males are having the highest grade average than the females --

-- 6) Returning the students that are advised by the Academic Advisor having the lowest salary --

SELECT Students.StudentID,Students.FirstName,Students.LastName
FROM Students
JOIN GroupOfProgram ON Students.GroupID=GroupOfProgram.GroupID
JOIN Program ON GroupOfProgram.GroupID=Program.GroupID
JOIN AcademicAdvisors ON Program.AcademicAdvisorID=AcademicAdvisors.AcademicAdvisorID
WHERE AcademicAdvisors.YearlySalary=(SELECT MIN(YearlySalary) FROM AcademicAdvisors);

-- 7) Returning the lowest grade recorded per course per semester --

SELECT Courses.CourseNumber,Semesters.SemesterID,Program.GroupName, MIN(Grades.Grade) AS LowestGrade
FROM Grades
JOIN Courses ON Grades.CourseID=Courses.CourseID
JOIN Semesters ON Grades.SemesterID=Semesters.SemesterID
JOIN Program ON Grades.ProgramID=Program.ProgramID
JOIN GroupOfProgram ON Program.GroupID=GroupOfProgram.GroupID
JOIN Students ON GroupOfProgram.GroupID=Students.GroupID
AND 
Grades.StudentID=Students.StudentID
GROUP BY Courses.CourseNumber,Semesters.SemesterID,Program.GroupName
ORDER BY Semesters.SemesterID;

-- 8) Returning the student with the second highest grade average overall --

SELECT AVG(Grades.Grade)AS SecondHighestAvg,Students.StudentID,Students.FirstName,Students.LastName
FROM Grades
JOIN Students ON Grades.StudentID=Students.StudentID
JOIN Program ON Grades.ProgramID=Program.ProgramID
JOIN GroupOfProgram ON Program.GroupID=GroupOfProgram.GroupID
GROUP BY Students.StudentID,Students.StudentID,Students.FirstName,Students.LastName
ORDER BY AVG(Grades.Grade)
DESC
LIMIT 1,1;

-- 9) Returning the subjects having an overall average grade of more than 60% --

SELECT AVG(Grades.Grade)AS AVGgrade,Courses.Subject
FROM Grades
JOIN Courses ON Grades.CourseID=Courses.CourseID
WHERE Grades.Grade>60
GROUP BY Courses.Subject;

-- 10) Returning the number of hours taken by each teacher for teaching each course --

SELECT Teachers.FirstName,Teachers.LastName,
Courses.CourseNumber,Program.GroupName,Courses.CourseHours
FROM Courses
JOIN CourseOffering ON Courses.CourseID=CourseOffering.CourseID
JOIN Teachers ON CourseOffering.TeacherID=Teachers.TeacherID
JOIN GroupOfProgram ON CourseOffering.GroupID=GroupOfProgram.GroupID
JOIN Program ON GroupOfProgram.GroupID=Program.GroupID
GROUP BY Teachers.FirstName,Teachers.LastName,Courses.CourseNumber,
Program.GroupName,Courses.CourseHours;
