--/TABLE CREATION/
--1 PROGRAMMES TABLE
CREATE TABLE Programmes (
ProgrammeCode VARCHAR2(10) PRIMARY KEY,
Levels VARCHAR2(20) NOT NULL,
Points NUMBER CHECK (Points > 0),
Duration NUMBER CHECK (Duration > 0),
Campus VARCHAR2(100) NOT NULL,
Semester VARCHAR2(20) NOT NULL
);

--2 COURSES TABLE
CREATE TABLE Courses (
CourseCode VARCHAR2(10) PRIMARY KEY,
CourseName VARCHAR2(200) NOT NULL,
Credits NUMBER CHECK (Credits > 0)
);

--3 PROGRAMMECOURSES
CREATE TABLE ProgrammeCourses (
ProgrammeCode VARCHAR2(10),
CourseCode VARCHAR2(10),
PRIMARY KEY (ProgrammeCode, CourseCode),
FOREIGN KEY (ProgrammeCode) REFERENCES Programmes(ProgrammeCode),
FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

--4 DEPARTMENTS TABLE
CREATE TABLE Departments (
DepartmentCode VARCHAR2(10) PRIMARY KEY,
DepartmentName VARCHAR2(200) NOT NULL,
DepartmentPhone VARCHAR2(20) NOT NULL,
DepartmentLocation VARCHAR2(100) NOT NULL
);

--5 ACADEMICSTAFF TABLE
CREATE TABLE AcademicStaff (
StaffID NUMBER PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
EmploymentStartDate DATE NOT NULL,
PhoneExtension VARCHAR2(20) NOT NULL,
OfficeNumber VARCHAR2(20) NOT NULL,
Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
Salary NUMBER(10,2) CHECK (Salary > 0),
Position VARCHAR2(100) NOT NULL,
HighestQualification VARCHAR2(100) NOT NULL,
DepartmentCode VARCHAR2(10) NOT NULL,
FOREIGN KEY (DepartmentCode) REFERENCES Departments(DepartmentCode)
);

--6 DEPARTMENTHEADS TABLE
CREATE TABLE DepartmentHeads (
DepartmentCode VARCHAR2(10),
StaffID NUMBER,
StartDate DATE NOT NULL,
PRIMARY KEY (DepartmentCode, StaffID),
FOREIGN KEY (DepartmentCode) REFERENCES Departments(DepartmentCode),
FOREIGN KEY (StaffID) REFERENCES AcademicStaff(StaffID)
);

--7 STUDENTS TABLE
CREATE TABLE Students (
StudentID NUMBER PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
Address VARCHAR2(200) NOT NULL,
Town VARCHAR2(100) NOT NULL,
Postcode VARCHAR2(20) NOT NULL,
DOB DATE NOT NULL,
Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
HasStudentLoan NUMBER(1,0) NOT NULL CHECK (HasStudentLoan IN (0, 1))
);

--8 NEXTOFKIN TABLE
CREATE TABLE NextOfKin (
NextOfKinID NUMBER PRIMARY KEY,
StudentID NUMBER NOT NULL UNIQUE,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
Address VARCHAR2(200) NOT NULL,
Phone VARCHAR2(20) NOT NULL,
Relationship VARCHAR2(50) NOT NULL,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

--9 STUDENTPERFORMANCE TABLE
CREATE TABLE StudentPerformance (
StudentID NUMBER,
ProgrammeCode VARCHAR2(10),
CourseCode VARCHAR2(10),
Grade VARCHAR2(10) NOT NULL,
PRIMARY KEY (StudentID, ProgrammeCode, CourseCode),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (ProgrammeCode) REFERENCES Programmes(ProgrammeCode),
FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

--10. COURSECOORDINATOR TABLE
CREATE TABLE CourseCoordinators (
StaffID NUMBER,
CourseCode VARCHAR2(10),
PRIMARY KEY (StaffID, CourseCode),
FOREIGN KEY (StaffID) REFERENCES AcademicStaff(StaffID),
FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

--11 PROGRAMMEDIRECTORS TABLE
CREATE TABLE ProgrammeDirectors (
StaffID NUMBER,
ProgrammeCode VARCHAR2(10),
PRIMARY KEY (StaffID, ProgrammeCode),
FOREIGN KEY (StaffID) REFERENCES AcademicStaff(StaffID),
FOREIGN KEY (ProgrammeCode) REFERENCES Programmes(ProgrammeCode)
);

--12 COURSETEACHING TABLE
CREATE TABLE CourseTeaching (
StaffID NUMBER,
CourseCode VARCHAR2(10),
TeachingHoursPerWeek NUMBER CHECK (TeachingHoursPerWeek > 0),
PRIMARY KEY (StaffID, CourseCode),
FOREIGN KEY (StaffID) REFERENCES AcademicStaff(StaffID),
FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

--13 ADITIONAL INDEX TO INCREMENT THE PERFORMANCE
CREATE INDEX idx_students_lastname ON Students(LastName);
CREATE INDEX idx_courses_name ON Courses(CourseName);
CREATE INDEX idx_staff_lastname ON AcademicStaff(LastName);


--/POPULATE DATA/
--PROGRAMMES DATA INSERTION
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('BIT', 'Bachelor', 360, 3, 'City Campus', 'Semester 1');
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('BSE', 'Bachelor', 360, 3, 'City Campus', 'Semester 1');
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('BCS', 'Bachelor', 360, 3, 'City Campus', 'Semester 2');
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('BCOM', 'Bachelor', 360, 3, 'Suburban Campus', 'Semester 1');
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('MIS', 'Master', 180, 2, 'City Campus', 'Semester 2');
INSERT INTO Programmes (ProgrammeCode, Levels, Points, Duration, Campus, Semester)
VALUES ('PHD', 'Doctorate', 360, 4, 'City Campus', 'Semester 1');

--COURSES DATA INSERTION
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('PROG101', 'Programming I', 15);
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('DBMS202', 'Database Systems', 15);
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('NETW301', 'Computer Networks', 15);
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('ALGO303', 'Algorithms', 15);
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('PROJ401', 'Final Year Project', 30);
INSERT INTO Courses (CourseCode, CourseName, Credits)
VALUES ('THESIS601', 'PhD Thesis', 120);

--PROGRAMMECOURSES DATA INSERTION
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BIT', 'PROG101');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BIT', 'DBMS202');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BSE', 'PROG101');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BSE', 'DBMS202');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BCS', 'PROG101');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BCS', 'DBMS202');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('BCOM', 'DBMS202');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('MIS', 'NETW301');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('MIS', 'ALGO303');
INSERT INTO ProgrammeCourses (ProgrammeCode, CourseCode)
VALUES ('PHD', 'THESIS601');

--STUDENTS DATA INSERTION
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1001, 'John', 'Smith', '123 Main St', 'Whangarei', '0112', TO_DATE('1995-03-15', 'YYYY-MM-DD'),
'Male', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1002, 'Emma', 'Johnson', '456 Oak Rd', 'Whangarei', '0110', TO_DATE('1998-07-22', 'YYYY-MM-
DD'), 'Female', 0);
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1003, 'Michael', 'Williams', '789 Elm St', 'Kaikohe', '0471', TO_DATE('1997-11-03', 'YYYY-MM-DD'),
'Male', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1004, 'Sophia', 'Brown', '321 Pine Ave', 'Kerikeri', '0230', TO_DATE('1996-06-28', 'YYYY-MM-DD'),
'Female', 0);
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1005, 'Daniel', 'Jones', '159 Cedar Ln', 'Whangarei', '0112', TO_DATE('1994-02-10', 'YYYY-MM-DD'),
'Male', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Address, Town, Postcode, DOB, Gender,
HasStudentLoan)
VALUES (1006, 'Olivia', 'Garcia', '753 Maple Dr', 'Whangarei', '0110', TO_DATE('1999-09-18', 'YYYY-MM-
DD'), 'Female', 1);

--NEXTOFKIN DATA INSERTION
INSERT INTO NextOfKin (NextOfKinID, StudentID, FirstName, LastName, Address, Phone, Relationship)
VALUES (2001, 1001, 'Jane', 'Smith', '123 Main St, Whangarei', '09-1234567', 'Mother');
INSERT INTO NextOfKin (NextOfKinID, StudentID, FirstName, LastName, Address, Phone, Relationship)
VALUES (2002, 1002, 'Robert', 'Johnson', '456 Oak Rd, Whangarei', '09-8765432', 'Father');
INSERT INTO NextOfKin (NextOfKinID, StudentID, FirstName, LastName, Address, Phone, Relationship)
VALUES (2003, 1003, 'Emily', 'Williams', '789 Elm St, Kaikohe', '09-2468013', 'Sister');
INSERT INTO NextOfKin (NextOfKinID, StudentID, FirstName, LastName, Address, Phone, Relationship)
VALUES (2004, 1004, 'David', 'Brown', '321 Pine Ave, Kerikeri', '09-5679012', 'Brother');
INSERT INTO NextOfKin (NextOfKinID, StudentID, FirstName, LastName, Address, Phone, Relationship)
VALUES (2005, 1005, 'Sarah', 'Jones', '159 Cedar Ln, Whangarei', '09-3456789', 'Mother');

--DEPARTMENTS DATA INSERTION
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('COMP', 'Department of Computer Science', '09-1234567', 'Z Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('INFO', 'Department of Information Systems', '09-2345678', 'X Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('SOFT', 'Department of Software Engineering', '09-3456789', 'Y Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('BUSI', 'Department of Business', '09-4567890', 'W Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('MATH', 'Department of Mathematics', '09-5678901', 'V Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('ENGL', 'Department of English', '09-6789012', 'A Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('HIST', 'Department of History', '09-7890123', 'B Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('CHEM', 'Department of Chemistry', '09-8901234', 'C Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('PHYS', 'Department of Physics', '09-9012345', 'D Building');
INSERT INTO Departments (DepartmentCode, DepartmentName, DepartmentPhone, DepartmentLocation)
VALUES ('BIOL', 'Department of Biology', '09-0123456', 'E Building');

--ACADEMICSTAFF DATA INSERTION
INSERT INTO AcademicStaff (StaffID, FirstName, LastName, EmploymentStartDate, PhoneExtension,
OfficeNumber, Gender, Salary, Position, HighestQualification, DepartmentCode)
VALUES (1001, 'Manuel', 'Santos', TO_DATE('2010-01-01', 'YYYY-MM-DD'), '1001', 'Z101', 'Male', 80000.00,
'Professor', 'PhD', 'COMP');
INSERT INTO AcademicStaff (StaffID, FirstName, LastName, EmploymentStartDate, PhoneExtension,
OfficeNumber, Gender, Salary, Position, HighestQualification, DepartmentCode)
VALUES (1002, 'Sarah', 'Vidal', TO_DATE('2015-06-15', 'YYYY-MM-DD'), '1002', 'X201', 'Female', 65000.00,
'Senior Lecturer', 'Master', 'INFO');
INSERT INTO AcademicStaff (StaffID, FirstName, LastName, EmploymentStartDate, PhoneExtension,
OfficeNumber, Gender, Salary, Position, HighestQualification, DepartmentCode)
VALUES (1003, 'Jorge', 'Guillen', TO_DATE('2012-09-01', 'YYYY-MM-DD'), '1003', 'Y102', 'Male', 70000.00,
'Lecturer', 'PhD', 'SOFT');
INSERT INTO AcademicStaff (StaffID, FirstName, LastName, EmploymentStartDate, PhoneExtension,
OfficeNumber, Gender, Salary, Position, HighestQualification, DepartmentCode)
VALUES (1004, 'Sofia', 'Suarez', TO_DATE('2018-03-01', 'YYYY-MM-DD'), '1004', 'W301', 'Female', 55000.00,
'Lecturer', 'Master', 'BUSI');
INSERT INTO AcademicStaff (StaffID, FirstName, LastName, EmploymentStartDate, PhoneExtension,
OfficeNumber, Gender, Salary, Position, HighestQualification, DepartmentCode)
VALUES (1005, 'Drielly', 'Velasco', TO_DATE('2020-07-01', 'YYYY-MM-DD'), '1005', 'V101', 'Male', 60000.00,
'Senior Lecturer', 'PhD', 'MATH');

--DEPARTMENTHEADS DATA INSERTION
INSERT INTO DepartmentHeads (DepartmentCode, StaffID, StartDate)
VALUES ('COMP', 1001, TO_DATE('2015-01-01', 'YYYY-MM-DD'));
INSERT INTO DepartmentHeads (DepartmentCode, StaffID, StartDate)
VALUES ('INFO', 1002, TO_DATE('2018-06-01', 'YYYY-MM-DD'));
INSERT INTO DepartmentHeads (DepartmentCode, StaffID, StartDate)
VALUES ('SOFT', 1003, TO_DATE('2017-02-15', 'YYYY-MM-DD'));
INSERT INTO DepartmentHeads (DepartmentCode, StaffID, StartDate)
VALUES ('BUSI', 1004, TO_DATE('2020-03-01', 'YYYY-MM-DD'));
INSERT INTO DepartmentHeads (DepartmentCode, StaffID, StartDate)
VALUES ('MATH', 1005, TO_DATE('2022-09-01', 'YYYY-MM-DD'));

--PROGRAMMEDIRECTORS DATA INSERTION
INSERT INTO ProgrammeDirectors (StaffID, ProgrammeCode)
VALUES (1001, 'BIT');
INSERT INTO ProgrammeDirectors (StaffID, ProgrammeCode)
VALUES (1002, 'MIS');
INSERT INTO ProgrammeDirectors (StaffID, ProgrammeCode)
VALUES (1003, 'BSE');
INSERT INTO ProgrammeDirectors (StaffID, ProgrammeCode)
VALUES (1004, 'BCOM');
INSERT INTO ProgrammeDirectors (StaffID, ProgrammeCode)
VALUES (1005, 'BCS');

--COURSECOORDINATORS DATA INSERTION
INSERT INTO CourseCoordinators (StaffID, CourseCode)
VALUES (1001, 'PROG101');
INSERT INTO CourseCoordinators (StaffID, CourseCode)
VALUES (1002, 'DBMS202');
INSERT INTO CourseCoordinators (StaffID, CourseCode)
VALUES (1003, 'NETW301');
INSERT INTO CourseCoordinators (StaffID, CourseCode)
VALUES (1004, 'ALGO303');
INSERT INTO CourseCoordinators (StaffID, CourseCode)
VALUES (1005, 'PROJ401');

--COURSETEACHING DATA INSERTION
INSERT INTO CourseTeaching (StaffID, CourseCode, TeachingHoursPerWeek)
VALUES (1001, 'PROG101', 4);
INSERT INTO CourseTeaching (StaffID, CourseCode, TeachingHoursPerWeek)
VALUES (1002, 'DBMS202', 3);
INSERT INTO CourseTeaching (StaffID, CourseCode, TeachingHoursPerWeek)
VALUES (1003, 'NETW301', 5);
INSERT INTO CourseTeaching (StaffID, CourseCode, TeachingHoursPerWeek)
VALUES (1004, 'ALGO303', 4);
INSERT INTO CourseTeaching (StaffID, CourseCode, TeachingHoursPerWeek)
VALUES (1005, 'PROJ401', 2);

--STUDENTPERFORMANCE DATA INSERTION
INSERT INTO StudentPerformance (StudentID, ProgrammeCode, CourseCode, Grade)
VALUES (1001, 'BIT', 'PROG101', 'A');
INSERT INTO StudentPerformance (StudentID, ProgrammeCode, CourseCode, Grade)
VALUES (1002, 'MIS', 'DBMS202', 'B+');
INSERT INTO StudentPerformance (StudentID, ProgrammeCode, CourseCode, Grade)
VALUES (1003, 'BSE', 'PROG101', 'A-');
INSERT INTO StudentPerformance (StudentID, ProgrammeCode, CourseCode, Grade)
VALUES (1004, 'BCOM', 'DBMS202', 'B');
INSERT INTO StudentPerformance (StudentID, ProgrammeCode, CourseCode, Grade)
VALUES (1005, 'BCS', 'PROG101', 'A');