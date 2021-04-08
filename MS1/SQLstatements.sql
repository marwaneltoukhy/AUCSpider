CREATE SCHEMA IF NOT EXISTS project1;
USE project1;
CREATE TABLE IF NOT EXISTS department(
	Dept_Code VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS CourseOffering(
	Course_Name VARCHAR(300) NOT NULL,
    Course_Number INT NOT NULL,
    Dept_Code VARCHAR(10), 
    Description TEXT,
    Notes TEXT,
    NumberOfCredits INT,
    SemesterOffered TEXT,
    prereq VARCHAR(30),
    CrossListed VARCHAR(30),
    FOREIGN KEY(Dept_Code) 									REFERENCES department(Dept_Code) ON UPDATE CASCADE,
    PRIMARY KEY (Course_Number, Dept_Code)
);

CREATE TABLE IF NOT EXISTS student(
	AUC_ID INT NOT NULL PRIMARY KEY,
    Grade VARCHAR(30),
    Fname VARCHAR(30) NOT NULL,
    Mname VARCHAR(30),
    Lname VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS StudentReview(
    Rating INT,
    TextReview TEXT,
    AUC_ID INT,
    Course_Number INT,
    Dept_Code VARCHAR(10),
    FOREIGN KEY(AUC_ID) 								REFERENCES student(AUC_ID) ON UPDATE CASCADE,
    FOREIGN KEY(Course_Number,Dept_Code) 				REFERENCES CourseOffering(Course_Number,Dept_Code) ON UPDATE CASCADE
);

-- CREATE VIEW verify as
-- 		SELECT Course_Number, Dept_Code 
--         FROM coursestudent
--         WHERE AUC_ID =  900129248
--         AND Course_Number = 1000
--         AND Dept_Code = Dept_Code;

CREATE TABLE IF NOT EXISTS CourseStudent(
	LetterGrade char(2),
    year INT,
    semester VARCHAR(10),
    Dept_Code VARCHAR(10),
    Course_Number INT ,
    AUC_ID INT,
    FOREIGN KEY(AUC_ID) 										REFERENCES student(AUC_ID) ON UPDATE CASCADE,
    FOREIGN KEY(Course_Number,Dept_Code) 						REFERENCES CourseOffering(Course_Number,Dept_Code) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DepartmentStudent(
	Dept_Code VARCHAR(10),
    AUC_ID INT,
    FOREIGN KEY(AUC_ID) 								REFERENCES student(AUC_ID) ON UPDATE CASCADE,
    FOREIGN KEY(Dept_Code) 									REFERENCES department(Dept_Code) ON UPDATE CASCADE
);


