-- SUBMITTED BY : SAMEER OHRI 1994886, ANMOL PREET 1995356, ROBIN SHARMA 1995117 --

-- Creating the Database named "CegepCollege" --

CREATE DATABASE CegepCollege;
USE CegepCollege;

-- Creating the table named Students --

CREATE TABLE Students(
StudentID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
FirstName char(30) NOT NULL,
LastName char(30) NOT NULL,
Address char(50) NOT NULL,
Email char(255) NOT NULL UNIQUE,
DateOfBirth date NOT NULL,
Sex char(20) NOT NULL, 
ProgramName char(50) NOT NUll,
GroupID int NOT NULL,
FOREIGN KEY(GroupID) REFERENCES GroupOfProgram(GroupID)
);

-- Creating the table named Teachers --

CREATE TABLE Teachers(
TeacherID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
FirstName char(30) NOT NULL,
LastName char(30) NOT NULL,
Address char(50) NOT NULL,
Email char(255) NOT NULL UNIQUE,
DateOfBirth date NOT NULL,
Sex char(20) NOT NULL,
HourlySalary decimal(5,2) NOT NULL
);

-- Creating the table named AcademicAdvisors --

CREATE TABLE AcademicAdvisors(
AcademicAdvisorID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
FirstName char(30) NOT NULL,
LastName char(30) NOT NULL,
Address char(50) NOT NULL,
Email char(255) NOT NULL UNIQUE,
DateOfBirth date NOT NULL,
Sex char(20) NOT NULL,
YearlySalary decimal(7,2) NOT NULL
);

-- Creating the table named Program --

CREATE TABLE Program(
GroupID int NOT NULL,
ProgramID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
GroupName char(30) NOT NULL ,
AcademicAdvisorID int NOT NULL,
FOREIGN KEY(GroupID) REFERENCES GroupOfProgram(GroupID),
FOREIGN KEY(AcademicAdvisorID) REFERENCES AcademicAdvisors(AcademicAdvisorID)
);

-- Creating the table named GroupOfProgram --

CREATE TABLE GroupOfProgram(
GroupID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
ProgramName char(30) NOT NULL,
GroupNumber int NOT NULL UNIQUE
);

-- Creating the table named Courses --

CREATE TABLE Courses(
CourseID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
CourseNumber char(10) NOT NULL,
Subject char(50) NOT NULL,
CourseHours int NOT NULL
);

-- Creating the table named Semesters --

CREATE TABLE Semesters(
SemesterID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
Season char(10) NOT NULL,
Year int NOT NULL
);

-- Creating the table named CourseOffering --

CREATE TABLE CourseOffering(
CourseOfferingID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
CourseID int NOT NULL,
SemesterID int NOT NULL,
TeacherID int NOT NULL,
GroupID int NOT NULL,
FOREIGN KEY(CourseID) REFERENCES Courses(CourseID),
FOREIGN KEY(SemesterID) REFERENCES Semesters(SemesterID),
FOREIGN KEY(TeacherID) REFERENCES Teachers(TeacherID),
FOREIGN KEY(GroupID) REFERENCES GroupOfProgram(GroupID)
);

-- Creating the table named Grades --

CREATE TABLE Grades(
CourseID int NOT NULL,
StudentID int NOT NULL,
SemesterID int NOT NULL,
ProgramID int NOT NULL,
Grade decimal NOT NULL,
FOREIGN KEY(CourseID) REFERENCES Courses(CourseID),
FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
FOREIGN KEY(SemesterID) REFERENCES Semesters(SemesterID),
FOREIGN KEY(ProgramID) REFERENCES Program(ProgramID)
);


