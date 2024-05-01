--Demo Database for LaerskoolTheresaPark
/*MPHELA NAPO(578379)
DELIGHT CHIPRO(577454)
TSHEPANG MOKGOSI(577685)
MOSIFANE MOSIFANE(577306) 
ORATILE HLATSHWAYO (577279*/

--Skills used in this Database Creation:
--Triggers
--Views
--Stored Procedures
--Functions(Used for Calculations)

USE master;
CREATE DATABASE LaerskoolTheresaPark
ON PRIMARY
(
	NAME = 'TheresaParkDatabase',
	FILENAME = 'C:\DBD Project\TheresaParkData.mdf',
	SIZE = 100MB,
	MAXSIZE= 200MB,
	FILEGROWTH= 10%
)
LOG ON
(
	NAME = 'TheresaParkLOG',
	FILENAME = 'C:\DBD Project\TheresaParkLog.ldf',
	SIZE = 10MB,
	MAXSIZE = 300MB,
	FILEGROWTH = 10%
)



--LOGINS AND BACKUPS

GO 
USE LaerskoolTheresapark
GO
CREATE LOGIN [WalterBosman] WITH PASSWORD = 'password';
GO
USE [LaerskoolTheresapark] 
GO
CREATE USER [WalterBosman] FOR LOGIN [WalterBosman];
GO
EXEC sp_addrolemember 'prin', 'WalterBosman';
GO


USE Laerskool
GO
CREATE LOGIN ImanDuToit WITH PASSWORD = 'I_tDuimoa1a!', 
GO
CREATE LOGIN DeniseMabaso WITH PASSWORD = 'D_bMunase9o!', 
CREATE LOGIN karenFaure WITH PASSWORD = 'k_rFauae1u!', 
CREATE LOGIN DavidBrown WITH PASSWORD = 'D_wBavnido1!', 
CREATE LOGIN KevinStevens WITH PASSWORD = 'K_tSvneee8s!'

GO

USE Laerskool
GO
EXEC sp_addrolemember 'Head of Department', 'ImanDuToit'
EXEC sp_addrolemember 'Head of Department', 'DeniseMabaso'
EXEC sp_addrolemember 'Head of Department', 'karenFaure'
EXEC sp_addrolemember 'Head of Department', 'DavidBrown'
EXEC sp_addrolemember 'Head of Department', 'KevinStevens'

 

PRINT 'Login complete. Welcome! '

BackUp
-------------------------------------------------------------------------------------------------------------------------------------------------------------

----Tables
CREATE TABLE TeacherSubject
(
	EmployeeID	INT	FOREIGN KEY REFERENCES Employee(EmployeeID),
	SubjectCode VARCHAR(30)  NOT NULL
	PRIMARY KEY (EmployeeID , SubjectCode)



)
GO
CREATE TABLE Subjects
(
	SubjectCode		VARCHAR(30)		NOT NULL  PRIMARY KEY,
	StudentID		INT				FOREIGN KEY REFERENCES Students(StudentID),
	SubjectName		VARCHAR(50)		NOT NULL	,


)
GO
CREATE TABLE ExtraCurricular
(
	ExtraCurricularID	INT				NOT NULL					IDENTITY(7,1)	PRIMARY KEY,
	Name				VARCHAR(50)		NOT NULL,
	StudentID			INT				FOREIGN KEY REFERENCES Students(StudentID),
	HeadOfActivity		VARCHAR(30)		NOT NULL,
	Type				VARCHAR(10)		
	
)
GO
CREATE TABLE JobPosition
(
	PositionCode	VARCHAR(50)		NOT NULL	PRIMARY KEY,
	JobTitle		VARCHAR(30)		NOT NULL	,
	Description		VARCHAR(30)		NOT NULL	,

)
GO
CREATE TABLE ExtraCurricular
(
	ExtraCurricularID	INT				NOT NULL					IDENTITY(7,1)	PRIMARY KEY,
	Name				VARCHAR(50)		NOT NULL,
	StudentID			INT				FOREIGN KEY REFERENCES Students(StudentID),
	HeadOfActivity		VARCHAR(30)		NOT NULL,
	Type				VARCHAR(10)		
	
)
GO
CREATE TABLE Qualifications
(
    ID                      INT         PRIMARY KEY,
    qualification           VARCHAR,
    NQF_LEVEL               INT,
    INSTITUTION             VARCHAR(255),
)
GO
CREATE TABLE Department
(
	DepartmentID	INT			IDENTITY(1,1)		PRIMARY KEY,
	DepartmentName	VARCHAR(50)	NOT NULL,

)
GO
CREATE TABLE GuardiansDetails --CREATE THE Guardians Details
(
	GuardianID				INT   IDENTITY(1,1)	NOT NULL PRIMARY KEY,
	StudentID				INT						FOREIGN KEY REFERENCES Students(StudentID) ,
	[Name]					VARCHAR(50)				NOT NULL DEFAULT 'UNKOWN',
	LastName				VARCHAR(50)				NOT NULL DEFAULT 'UNKOWN', 
	AccountID				INT						FOREIGN KEY REFERENCES Accounts(AccountID),
	Phone					VARCHAR(10)				NOT NULL	UNIQUE,
	WorkTelephone			VARCHAR(10)				NULL,
	RelationshipToStudent	VARCHAR(30)				NOT NULL,
	MaritialStatus			VARCHAR (30)			,
	EmailAddress			VARCHAR (20)			NULL ,
	Gender					VARCHAR (10)			NOT NULL ,
	Occupation				VARCHAR(50)				NULL,


)




GO
CREATE TABLE Students
(
	StudentID				INT			IDENTITY(1260,1)		NOT NULL,
	FirstName			VARCHAR(50)		NOT NULL				DEFAULT'unknown',
	LastName			VARCHAR(50)		NOT NULL				DEFAULT'unknown',
	SubjectCode			VARCHAR(50),		
	ClassID				VARCHAR(50),
	IDNumber			INT				NOT NULL,
	PrimaryLanguage		VARCHAR(50)		NOT NULL,
	DateOfEnrollment	DATE			NOT NULL,
	Gender				VARCHAR(10)		NOT NULL,
	Grade				NVARCHAR(10)	NOT NULL,
	DateOfBirth			DATE			NOT NULL,
)

GO
CREATE TABLE StudentSubject
(
	StudentID				INT				FOREIGN KEY REFERENCES Students(StudentID),
	SubjectCode				VARCHAR(30)		FOREIGN KEY REFERENCES Subjects( SubjectCode),
	FirstTermMark			INT,
	SecondTermMark			INT,
	ThirdTermMark			INT,
	PRIMARY KEY ( StudentID , SubjectCode)
)
GO
CREATE TABLE StudentMed
(
	MedicalAidNo			INT				,
	StudentID				INT				REFERENCES Students(StudentID),
	MedicalAidName			VARCHAR(40),		
	SpecialCondition		VARCHAR(40)			NULL  DEFAULT 'None',
	PRIMARY KEY (MedicalAidNo, MedicalAidName)	
)

GO
CREATE TABLE StudentGuardians
(
	StudentID			INT		REFERENCES Students(StudentID),
	GuardianID			INT		REFERENCES GuardiansDetails(GuardianID),
	StreetNo			INT,
	StreetName			VARCHAR(40),
	PostalCode			INT,
	City				VARCHAR(40)
	PRIMARY KEY(StudentID,GuardianID)
)
GO 
CREATE TABLE StudentDiscipline
(
	StudentID					INT    REFERENCES Students(StudentID),
	DisciplinaryEntryNo			INT    REFERENCES DisciplinaryRecord(DiscliplinaryEntryNo),
	PRIMARY KEY ( StudentID , DisciplinaryEntryNo)
)
GO
CREATE TABLE StudentDaysAbsent
(
	StudentID		INT		FOREIGN KEY REFERENCES Students(StudentID),
	EntryID			INT		FOREIGN KEY REFERENCES DaysAbsent(EntryID),
	PRIMARY KEY( StudentID , EntryID)
)
GO
/*CREATE TABLE StudentCurricular
(

	StudentID					INT		REFERENCES Students(StudentID)    ,
	ExtraCurricularID			INT		REFERENCES ExtraCurricular(ExtraCurricularID)   ,	
	PRIMARY KEY (StudentID , ExtraCurricularID)

)*/
GO
CREATE TABLE StudentCurriculum
(
	ExtraCurricularID	INT FOREIGN KEY REFERENCES ExtraCurricular(ExtraCurricularID) ,
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	PRIMARY KEY ( ExtraCurricularID , StudentID)



)
GO

CREATE TABLE EmployeeQualifications
(
        EmployeeID           INT       REFERENCES Employee(EmployeeNo),
        QualificationID      INT       REFERENCES Qualifications(ID),
        Date_Completed       DATETIME,
        PRIMARY KEY(EmployeeID,QualificationID)

)

GO

CREATE TABLE Employee
(
    EmployeeNo      INT                             IDENTITY(1,1)    PRIMARY KEY,
    FirstName       VARCHAR(30)     NOT NULL, 
    LastName        VARCHAR(30)     NOT NULL,
    ID              VARCHAR(13)     NOT NULL         UNIQUE,
    DOB             DATETIME        NOT NULL,
    StreetNo        VARCHAR(3),
    PostalCode      VARCHAR(4),
    City            VARCHAR,
    Phone           VARCHAR(10)                     UNIQUE,
    Email           VARCHAR                         UNIQUE,
    PositionCode    VARCHAR(50)                                      REFERENCES JobPosition(PositionCode),
    [Status]          VARCHAR(10),
    salary          MONEY,
    TaxNumber       VARCHAR(10)     NOT NULL        UNIQUE,
    AccountID       INT                             UNIQUE          REFERENCES Accounts(AccountID),
    HireDate        DATETIME,
    DepartmentID    INT                                             REFERENCES Department(DepartmentID)
)
GO
CREATE TABLE Classroom
(
    ClassID     INT                         PRIMARY KEY,
    EmployeeNo  INT                         REFERENCES Employee(EmployeeNo),
    Class_Name  VARCHAR(20)     UNIQUE,
    Capacity    INT
)

GO

CREATE TABLE DisciplinaryRecord
(
	DiscliplinaryEntryNo		INT		NOT NULL		PRIMARY KEY,
	StudentID					INT		FOREIGN KEY REFERENCES Students(StudentID) ,
	TypeOfDiscipline			VARCHAR(40),
	DateOfTransgression			DATETIME	,	--ENSURE THAT Date is no further then today  
	ParentsNotified				VARCHAR(10)  
)

GO

CREATE TABLE DaysAbsent
(
	EntryID				INT			PRIMARY KEY,
	DayAbsent			DATETIME	,
	Reason				VARCHAR(30)		DEFAULT 'None Provided'

)

CREATE TABLE EmployeeMed
(
    MedicalAid_No       VARCHAR(9),
    EmployeeID          INT               REFERENCES Employee(EmployeeNo),
    MedicalAid_Name     VARCHAR(10),
    Special_Condition   VARCHAR(50)       DEFAULT('None'),
    PRIMARY KEY(MedicalAid_No,EmployeeID)
)

GO



CREATE TABLE Accounts
(
    AccountID       INT                 PRIMARY KEY,
    Branch_Code     INT     NOT NULL,
    AccountNo       INT     NOT NULL    UNIQUE,
    Bank_Name       VARCHAR(50)
)

GO

CREATE TABLE TransactionHistory
(
    TransactionNo       INT         IDENTITY(1,1)         PRIMARY KEY,
    paymentDate         DATETIME    DEFAULT(GETDATE()),
    Amount              MONEY,
    [Type]              VARCHAR(255),
    AmountDue           MONEY,
    Reference           VARCHAR(255)
)

GO 
CREATE TABLE GRADES
(
	StudentID INT Not Null FOREIGN KEY REFERENCES Students(StudentID),
	SubjectCode VARCHAR(30)  null FOREIGN KEY REFERENCES Subjects(SubjectCode),
	Term1 int Null,
	Term2 int Null,
	Term2 int Null,



)

GO 

INSERT INTO  [dbo].[Qualifications] (ID, qualification, NQF_Level, INSTITUTION)
VALUES
    (1, 'Bachelor of Education', 7, 'University of Johannesburg'),
    (2, 'Postgraduate Certificate in Education', 6, 'University of Cape Town'),
    (3, 'National Certificate in Early Childhood Development', 4, 'Northlink College'),
    (4, 'Diploma in Grade R Teaching', 5, 'Cape Peninsula University of Technology'),
    (5, 'Certificate in Teaching English to Speakers of Other Languages', 5, 'Wits Language School'),
    (6, 'Bachelor of Education in Foundation Phase', 7, 'University of Pretoria'),
    (7, 'Diploma in Teaching', 6, 'Durban University of Technology'),
    (8, 'National Professional Diploma in Education', 6, 'University of Limpopo'),
    (9, 'Advanced Certificate in Education', 6, 'University of the Western Cape'),
    (10, 'Certificate in Mathematics Teaching', 5, 'Mangosuthu University of Technology'),
    (11, 'National Diploma in Educare', 6, 'Central University of Technology'),
    (12, 'Bachelor of Arts in Education', 7, 'Rhodes University'),
    (13, 'Higher Certificate in Foundation Phase Teaching', 5, 'Nelson Mandela University'),
    (14, 'Certificate in Inclusive Education', 4, 'Tshwane University of Technology'),
    (15, 'Advanced Diploma in Educational Management and Leadership', 7, 'University of KwaZulu-Natal'),
	(16, 'Bachelor of Commerce in Accounting', 7, 'University of Cape Town'),
    (17, 'National Diploma in Office Management and Technology', 6, 'Durban University of Technology'),
    (18, 'Higher Certificate in Human Resource Management', 5, 'University of Pretoria'),
    (19, 'Certificate in Payroll and Income Tax Administration', 4, 'Cape Peninsula University of Technology'),
    (20, 'National Certificate in Security Operations', 4, 'Ekurhuleni East College'),
    (21, 'Certificate in Security Management', 5, 'University of Johannesburg')


--------------------------------------------------------------------------------------

---Sample Data
GO

Use LaerskoolTheresaPark
INSERT INTO Students ( FirstName, LastName, ClassID, IDNumber, PrimaryLanguage, DateOfEnrollment, Gender, Grade, DateOfBirth)
VALUES
( 'John', 'Doe',  1, '1005066382045', 'English', '2016-01-12', 'M', 7, '2010-05-06'),
( 'Jane', 'Doe', 1, '1006075036284', 'Afrikaans', '2016-01-12', 'F', 6, '2010-06-07'),
( 'Bob', 'Smith', 1, '120709956288', 'Afrikaans', '2019-01-16', 'M', 4, '2012-07-09'),
( 'Alice', 'Johnson',  1, '110808114830', 'English', '2018-01-08', 'F', 5, '2011-08-08'),
( 'Tom', 'Wilson', 1, '170910053211', 'Spanish', '2022-09-01', 'M', 1, '2017-09-10'),
( 'Emily', 'Brown', 1 , '100211852711', 'English', '2015-01-09', 'F', 7, '2010-02-11'),
( 'David', 'Lee',  1, '13031265382', 'Zulu', '2020-06-07', 'M', 3, '2013-03-12'),
( 'Sarah', 'Garcia', 1 , '12041397346', 'Afrikaans', '2020-09-01', 'F', 4, '2012-04-13'),
( 'James', 'Taylor',  1, '160514782936', 'English', '2018-01-08', 'M', 2, '2016-05-14'),
( 'Olivia', 'Davis',  2, '120615028622', 'Zulu', '2019-07-01', 'F', 5, '2012-06-15'),
( 'Michael', 'Johnson',  2, '110716325397', 'Afrikaans', '2020-06-01', 'M', 6, '2011-07-16'),
( 'Elizabeth', 'Taylor', 2, '1008175462811', 'English', '2016-09-01', 'F', 7, '2010-08-17'),
( 'William', 'Davis',  2, '1209180745227', 'French', '2017-07-01', 'M', 6, '2012-09-18'),
( 'Sophia', 'Miller', 2, '131019873263', 'English', '2021-09-01', 'F', 4, '2013-10-19'),
( 'Matthew', 'Gonzalez', 2, '181120742996', 'English', '2022-09-01', 'M', 1, '2018-11-20'),
( 'Ava', 'Rodriguez',  2 , '121221892561', 'English', '2022-01-16', 'F', 5, '2012-12-21'),
( 'Christopher', 'Martinez', 10, '1001228352755', 'French', '2022-09-01', 'M', 6, '2010-01-22'),
( 'Isabella', 'Hernandez',  10, '090223884358', 'Spanish', '2019-09-01', 'F', 7, '2009-02-23'),
( 'Ethan', 'Lopez',  10, '16032443678', 'English', '2019-01-01', 'M', 3, '2016-03-24'),
( 'Mia', 'Garcia',  10, '170425835170', 'Afrikaans', '2022-01-01', 'F', 1, '2017-04-25'),
( 'Daniel', 'Chen',  11, '110622341573', 'English', '2017-09-01', 'M', 6, '2011-06-22'),
( 'Grace', 'Wong', 11, '110723642219', 'Zulu', '2016-01-21', 'F', 7, '2011-07-23'),
( 'Ethan', 'Nguyen', 11, '120824873442', 'Afrikaans', '2018-09-01', 'M', 4, '2012-08-24'),
( 'Bella', 'Park',  3, '110925356457', 'English', '2017-03-20', 'F', 6, '2011-09-25'),
( 'Adam', 'Sato',  3, '101026583922', 'Setwana', '2016-01-16', 'M', 7, '2010-10-26'),
( 'Sophie', 'Kim', 4, '171127689542', 'Zulu', '2022-09-01', 'F', 2, '2017-11-27'),
( 'Mohammed', 'Ali',  3, '100228984577', 'Zulu', '2017-01-20', 'M', 7, '2010-02-28'),
( 'Aisha', 'Khan',  5, '1304015392004', 'Afrikaans', '2022-03-21', 'F', 3, '2013-04-01'),
( 'Aiden', 'Ng',  5, '1905024266799', 'English', '2022-09-01', 'M', 2, '2019-05-02'),
( 'Hannah', 'Liu',  6, '150603472833', 'Zulu', '2019-09-01', 'F', 4, '2015-06-03'),
( 'Michael', 'Nguyen',  6, '1310019836213', 'English', '2017-09-01', 'M', 5, '2013-10-01'),
( 'Isabella', 'Singh',  7, '180102346278', 'Setwana', '2022-09-01', 'F', 1, '2018-01-02'),
( 'Aaron', 'Garcia',  8, '181103123433', 'French', '2022-09-01', 'M', 1, '2018-11-03'),
( 'Rachel', 'Wang',  7, '160204722056', 'English', '2019-01-13', 'F', 3, '2016-02-04'),
( 'Jason', 'Lee',  8, '1413051382964', 'Afrikaans', '2017-01-12', 'M', 4, '2014-03-05'),
( 'Sophia', 'Wong', 9, '140406228945', 'English', '2022-09-01', 'F', 4, '2014-04-06'),
( 'Daniel', 'Kim', 9, '151507863455', 'Afrikaans', '2022-09-01', 'M', 3, '2015-05-07'),
('Ava', 'Patel',  10, '1206088734155', 'Setwana', '2022-09-01', 'F', 6, '2012-06-08')

GO

INSERT INTO Department(DepartmentName)
VALUES
( 'Administration Department'),
( 'Teaching Department'),
('Facilities and Maintenance Department'),
( 'School Management Department ' ),
(	'Technology Department')

GO

INSERT INTO JobPosition (PositionCode ,JobTitle ,[Description])
VALUES
('Prin','Principal', 'Oversees running of school acticites'),
('DPrinc','Deputy Principal', 'Oversees school '),
('HODL','HOD Languages', 'Provides education within the language  department includes language English , Setswana , Afrikaans '),
('HODM','HOD Math', 'Manages all Mathematics'),
('HODS','HOD Science', 'Manages all educational activites with the science subjects  such as  Natural Science, Social Sciences and EMS'),
('HODD','HOD Discipline' , 'Manages all student disciplianry actions'),
('TECH','Teacher',' Educates students'),
('Admin','Administration' , ' Handles all school administrative word' ),
('San ','Cleaning Staff', ' Clean School Facilities'),
('Terra',' Terrain' , 'Comprises of school yard maintenance and security')
GO
INSERT INTO StudentCurriculum
VALUES 
(37,15),(37,12),(37,16),(38,23),(38,15),(39,12),(40,32),(41,19),(42,18),(44,25),(42,29),(43,38),(41,41),(44,40),(44,30),(43,39),(45,38),(46,37),(47,36),(48,35),(49,34),(50,33),(50,32),(50,31),(51,30),(52,29),(52,28),(52,27),(52,26),(51,24),(52,23),(43,21),(44,17)

GO
INSERT INTO Accounts (AccountID ,Branch_code , AccountNo ,Bank_Name)
VALUES
(1, 8336, 0923798, 'Capitec'),
(2, 3877, 3882907, 'FNB'),
(3, 2889, 2983011, 'ABSA'),
(4, 1906, 8443779, 'Capitec'),
(5, 4568, 2660562, 'Capitec'),
(6, 9722, 3389992, 'FNB'),
(7, 8861, 0677212, 'Standard Bank'),
(8, 38291, 253790, 'Capitec'),
(9, 58372, 489322, 'Nedbank'),
(10, 29108, 587491, 'Nedbank'),
(11, 283782, 2837839, 'Capitec'),
(12, 78873, 27332, 'FNB'),
(13, 27833, 323211, 'ABSA'),
(14, 27524, 245368, 'Capitec'),
(15, 563892, 423579, 'Nedbank'),
(16, 53722, 3682972, 'FNB'),
(17, 245738, 36278, 'Nedbank'),
(18, 22635, 25271, 'Standard Bank'),
(19, 3877, 27389, 'Capitec'),
(20, 1906, 18633, 'ABSA'),
(21, 78873, 18369, 'Standard Bank'),
(22, 27833, 1733432, ' Capitec'),
(23, 38962, 273833, 'FNB'),
(24, 3927, 253881, 'FNB'),
(25, 3462, 17837, 'ABSA'),
(26, 3538, 17263, 'Nedbank'),
(27, 2536, 26142, 'Capitec'),
(28, 2683, 34717, 'Standard Bank'),
(29, 5372, 25339, 'ABSA'),
(30, 3672, 26271, 'FNB'),
(31,2638, 18373, 'Capitec'),
(32, 3722, 25373, 'Nedbank'),
(33, 36357, 35279, 'ABSA'),
(34, 36638, 25168, 'FNB'),
(35, 8219, 24637, 'Capitec'),
(36, 3527, 26278, 'ABSA'),
(37, 3628, 26372, 'Standard Bank'),
(38, 3279, 236711, 'Nedbank'),
(39, 5527, 23389, 'Capitec'),
(40,6372, 63784, 'Capitec');

GO

INSERT INTO Subjects(SubjectCode, SubjectName)
VALUES
('ENGHL', 'English Home Language'),
('AFRHT', 'Afrikaans Huis Taal'),
('ENGFL', 'English First Additional'),
('AFREA', 'Afrikaans Eerste Adisioneel'),
('MATH', 'Mathematics'),
('SS', 'Social Sciences'),
('NS - TECH', 'Natural Science and Technology'),
('AC', 'Creative Arts'),
('LO', 'Life Orientation');

GO

INSERT INTO DisciplinaryRecord (DiscliplinaryEntryNo ,StudentID,  Reason ,DateOfTransgression, TypeOfDiscipline, ParentsNotified)
VALUES 
  ( 1,22, 'Fighting', '2022-01-05',  'Detention', 'Yes'),
  ( 2,24, 'Bullying', '2021-11-30', 'Suspension', 'No'),
  ( 3,13, 'Cheating', '2022-03-15', 'Detention', 'Yes'),
  ( 4,31, 'Vandalism', '2021-10-12', 'Suspension', 'Yes'),
  ( 5,17, 'Skipping class', '2022-02-14', 'Detention', 'No'),
  ( 6,38, 'Disrespecting teacher', '2021-12-22', 'Detention', 'Yes'),
  ( 7,32, 'Truancy', '2022-03-20', 'Suspension', 'Yes'),
  ( 8,21, 'Harassment', '2021-10-08',  'Detention', 'No'),
  ( 9,32, 'Fighting', '2022-02-28',  'Suspension', 'Yes'),
  ( 10,14, 'Disrupting class', '2021-11-14',  'Detention', 'No'),
  ( 11,19, 'Bullying', '2022-01-22',  'Suspension', 'Yes'),
  ( 12,35, 'Cheating', '2021-12-06',  'Suspension', 'Yes'),
  ( 13,29, 'Vandalism', '2022-03-01',  'Detention', 'No'),
  (14,29, 'Skipping class', '2021-10-25', 'Suspension', 'Yes'),
  (15,11, 'Disrespecting teacher', '2022-02-10',  'Detention', 'No')
GO

INSERT INTO Classroom(ClassID, EmployeeID, Class_Name, Capacity)
VALUES
(1,156,'Classroom T' , 26),
(2,157, 'Classroom N', 25  ),
(3, 158,'Classroom A', 25),
(4, 159,'Classroom R', 30),
(5, 160,'Classroom E', 25),
(6,161,'Classroom S', 22),
(7,162,'Classroom P', 26),
(8,163,'Classroom k', 20),
(9, 164,'Classroom I', 25),
(10, 166,'Classroom M', 30),
(11, 167,'Classroom L', 28),
(12, 147,'Classroom O', 30),
(13, 144, 'Classroom Y', 26),
(14, 145, 'Classroom H', 28),
(15, 143,'Classroom G', 30)


GO
INSERT INTO GuardiansDetails ( [LastName],StudentID,[Name] ,  AccountID  , Phone, WorkTelephone, RelationshipToStudent, MaritialStatus, EmailAddress, Gender, Occupation)
VALUES( 41, 'John', 'Doe', 30, '1112223333', '4445556666', 'Father', 'Married', 'johndoe@gmail.com', 'M', 'Engineer'),
( 'Doe',42, 'Jane', 31, '2223334444', '5556667777', 'Mother', 'Married', 'janedoe@gmail.com', 'F', 'Teacher'),
('Smith', 43, 'Bob', 32, '3334445555', '6667778888', 'Father', 'Married', 'bobsmith@gmail.com', 'M', 'Doctor'),
( 'Brown',6, 'Emily', 35, '6667778888', '1112223333', 'Mother', 'Married', 'emilybrown@gmail.com', 'F', 'Nurse'),
(  'Lee',7, 'David', 36, '7778889999', '2223334444', 'Father', 'Married', 'davidlee@gmail.com', 'M', 'Architect'),
( 'Garcia',8, 'Sarah',  37, '8889990000', '3334445555', 'Mother', 'Married', 'sarahgarc@gmail.com', 'F', 'Designer'),
('Taylor', 9, 'James',  38, '9990001111', '4445556666', 'Father', 'Married', 'jamestay@gmail.com', 'M', 'Writer'),
('Davis', 10, 'Olivia',  40, '0001112222', '5556667777', 'Mother', 'Married', 'oliviadav@gmail.com', 'F', 'Artist'),
( 'Chang',11, 'Michael',  41, '1234567890', '4567890123', 'Father', 'Married', 'michaelc@example.com', 'M', 'Engineer'),
( 'Kim',12, 'Julia',  42, '2345678901', '5678901234', 'Mother', 'Married', 'juliakim@example.com', 'F', 'Doctor'),
('Lee', 13, 'William',  43, '3456789012', '6789012345', 'Father', 'Married', 'wilamle@example.com', 'M', 'Lawyer'),
('Park', 14, 'Grace',   44, '4567890123', '7890123456', 'Mother', 'Widowed', 'grapark@example.com', 'F', 'Nurse'),
('Garcia', 15, 'Henry', 45, '5678901234', '0123456789', 'Father', 'Married', 'henrygar@example.com', 'M', 'Teacher'),
('Nguyen', 16, 'Sophia',  46, '6789012345', '1234567890', 'Mother', 'Divorced', 'sophian@example.com', 'F', 'Accountant'),
('Tran', 17, 'Andrew' , 47, '7890123456', '2345678901', 'Father', 'Married', 'andrewt@example.com', 'M', 'Engineer'),
('Nguyen', 18, 'Ava',  48, '0123456789', '3456789012', 'Mother', 'Married', 'avanguy@example.com', 'F', 'Doctor'),
( 'Nolan',19, 'Christopher', 50,  '1234557890', '4567890123', 'Father', 'Widowed', 'christo@example.com', 'M', 'Lawyer'),
( 'Kim',20, 'Ella',  51, '2145678901', '5678901234', 'Mother', 'Divorced', 'ellakim@example.com', 'F', 'Nurse'),
(  'Nkunku',21, 'Christopher', 52, '0795345721', '012435712', 'Uncle', 'Single', 'nkunkuc@gmail.com', 'M', 'Machanic'),
( 'Meyer',22, 'Joyce',  53, '082472945', '0182537930', 'Mother', 'Single', 'jomey@yahoo.com', 'F', 'Entrpreneur'),
('Mathiba', 23,'Winnie',  54, '066793310', '0115522200', 'Aunt', 'Married', 'winiem@gmail.com', 'F', 'Dentist'),
('Mabaso', 24, 'Hector',  55, '072647289', '0882330000', 'Father', 'Widowed', 'hecto@yahoo.com', 'F', 'Salesman'),
( 'Rogers',25, 'Tony',  56, '072356190' , '0770333300', 'Father', 'Single', 'tonyrog@gmail.com', 'M','Lawyer' ),
('Flinter', 26, 'Bruce', 57, '081352780', '0112686433', 'Father', 'Single', 'brlinter@gmail.com', 'M', 'Teacher'),
('Mandoza', 27, 'Mandla',58, '067027318', '0736677711', 'Father', 'Married', 'mandoza@yahoo', 'M', 'Teacher'),
('Amese', 28, 'Margret',  59, '0713648002', '0184300034', 'Mother', 'Single', 'amemarg@gmail.com', 'M','Doctor'),
( 'Tommorow', 29, 'Mia', 60, '083018353', '0113459876', 'Mother', 'Single', 'tom@gmail.com', 'M', 'Engineer'),
( 'Wembly', 30, 'Richard', 61, '076129936', '0192002000', 'Father', 'Single', 'richdw@gmail.com', 'M', 'Teacher'),
(  'Banner',31, 'Phillip', 62, '081374552', '0117112999', 'Father', 'Married', 'phibaner@gmail.com', 'M','Lawyer'),
('Nagel', 32, 'Jason',  63, '072936742', '0160022020', 'Father', 'Married', 'jason@gmail.com', 'M', 'Salesman'),
( 'De Beer',33, 'Tristan',  64, '0836602845', '0183043004', 'Father', 'Married', 'tristdb@gmail.com', 'M','Doctor'),
( 'van Tonder',34, 'Herald',  65, '0734672937', '0726368888', 'Father', 'Married' ,'heraton@gmail.com', 'M', 'Engineer'),
( 'Samson',35, 'Wilfred',  66, '066193754', '012987000', 'Father', 'Single', 'samsol@gmail.com', 'M', 'Salesman'),
('Williams', 36, 'Sahra',  67, '0729466110', '0139001234', 'Mother', 'Single', 'sahrawil@gmail.com', 'M', 'Salesman'),
( 'Kruger',37, 'Marie',  68, '071363947', '0116704467', 'Mother', 'Married', 'krugerm@gmail.com', 'M','Doctor'),
('Mashaba',38, 'Sibusiso',  69, '0835162727', '0129020902', 'Father', 'Single', 'mashsi@yahoo', 'M','Lawyer'),
('Maluleka', 39, 'Thabo', 70, '0663535221', '0185002002', 'Father', 'Single', 'thabom@gmail.com', 'M', 'Teacher'),
('Napo', 40, 'Kelly', 71, '071935278', '0113773000', 'Mother', 'Married', 'kelly@gmail.com', 'M', 'Teacher');

GO
INSERT INTO StudentDiscipline(StudentID, DisciplinaryEntryNo)
VALUES 
  (22, 1),
  (24, 2),
  (13, 3),
  (31, 4),
  (17, 5),
  (38, 6),
  (32, 7),
  (21, 8),
  (32, 9),
  (14, 10),
  (19, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15);

GO
INSERT INTO TransactionHistory (PaymentDate, Amount, Type, AmountDue, Reference, AccountID)
VALUES 
    ('2023-04-01', 1000.00, 'School fees', 1000.00, 'Theresapark Primary School', 41),
    ('2023-04-02', 500.00, 'School fees', 500.00, 'Theresapark Primary School', 42),
    ('2023-04-03', 200.00, 'Donation', NULL, 'Theresapark Primary School', 43),
    ('2023-04-04', 1500.00, 'School fees', 1500.00, 'Theresapark Primary School', 44),
    ('2023-04-05', 300.00, 'Donation', NULL, 'Theresapark Primary School', 45),
    ('2023-04-06', 3000.00, 'School fees', 3000.00, 'Theresapark Primary School', 46),
    ('2023-04-07', 100.00, 'School fees', 100.00, 'Theresapark Primary School', 47),
    ('2023-04-08', 50.00, 'Donation', NULL, 'Theresapark Primary School', 48),
    ('2023-04-09', 1500.00, 'School fees', 1500.00, 'Theresapark Primary School', 49),
    ('2023-04-10', 200.00, 'Donation', NULL, 'Theresapark Primary School', 50),
    ('2023-04-11', 750.00, 'School fees', 500.00, 'Theresapark Primary School', 51),
    ('2023-04-12', 250.00, 'Donation', NULL, 'Theresapark Primary School', 52),
    ('2023-04-13', 1000.00, 'School fees', 1000.00, 'Theresapark Primary School', 53),
    ('2023-04-14', 75.00, 'School fees', 75.00, 'Theresapark Primary School', 54),
    ('2023-04-15', 100.00, 'Donation', NULL, 'Theresapark Primary School', 55),
    ('2023-04-16', 5000.00, 'School fees', 5000.00, 'Theresapark Primary School', 56),
    ('2023-04-17', 500.00, 'School fees', 250.00, 'Theresapark Primary School', 57),
    ('2023-04-18', 750.00, 'Donation', NULL, 'Theresapark Primary School', 58),
    ('2023-04-19', 1500.00, 'School fees', 1500.00, 'Theresapark Primary School', 59),
    ('2023-04-20', 100.00, 'Donation', NULL, 'Theresapark Primary School', 60),
    ('2023-04-21', 1250.00, 'School fees', 1250.00, 'Theresapark Primary School', 61)


GO
INSERT TeacherSubject(EmployeeID,SubjectCode)
VALUES
( 147,'AFREA'),
(156,'SS'),
(157,'MATH'),
(158,'SS'),
(159,'AC'),
(160, 'ENGHL'),
(161,'ENGFL'),
(162,'NS- TECH'),
(163,'ENGHL'),
(164,'ENGFL'),
(166,'AFREA'),
(167,'AC'),
(143,'AFRHT'),
(144, 'MATH'),
(145,'NS - Tech'),
(146, 'LO')

GO
INSERT INTO StudentMed(MedicalAidNo, StudentID, MedicalAidName, SpecialCondition)
VALUES
('123456789', 6, 'Dr. Wilson', 'None'),
('234567890', 7, 'Dr. Garcia', 'None'),
('345678901', 8, 'Dr. Brown', 'None'),
('456789012', 9, 'Dr. Davis', 'None'),
('567890123', 10, 'Dr. Taylor', 'None'),
('678901234', 11, 'Dr. Smith', 'None'),
('789012345', 12, 'Dr. Patel', 'Asthma'),
('890123456', 13, 'Dr. Lee', 'Allergies'),
('901234567', 14, 'Dr. Gonzalez', 'Diabetes'),
('012345678', 15, 'Dr. Johnson', 'None'),
('123450987', 16, 'Dr. Wang', 'Epilepsy'),
('234560987', 17, 'Dr. Rodriguez', 'None'),
('345670987', 18, 'Dr. Singh', 'ADHD'),
('456780987', 19, 'Dr. Kim', 'None'),
('567890876', 20, 'Dr. Garcia', 'Anxiety'),
('678901765', 21, 'Dr. Smith', 'Asthma'),
('789012654', 22, 'Dr. Johnson', 'Allergies'),
('890123543', 23, 'Dr. Lee', 'none'),
('901234432', 24, 'Dr. Martinez', 'Epilepsy'),
('012345321', 25, 'Dr. Rodriguez', 'none'),
('123450210', 26, 'Dr. Kim', 'ADHD'),
('234561098', 27, 'Dr. Patel', 'Diabetes'),
('345670987', 28, 'Dr. Nguyen', 'none'),
('456780876', 29, 'Dr. Garcia', 'Anxiety'),
('567890765', 30, 'Dr. Brown', 'Depression'),
('678901654', 31, 'Dr. Wilson', 'Asthma'),
('789012543', 32, 'Dr. Davis', 'Allergies'),
('890123432', 33, 'Dr. Anderson', 'none'),
('901234321', 34, 'Dr. Jackson', 'Epilepsy'),
('012345210', 35, 'Dr. White', 'none'),
('123450987', 36, 'Dr. Harris', 'ADHD'),
('234560876', 37, 'Dr. Clark', 'Diabetes'),
('345670765', 38, 'Dr. Lewis', 'none'),
('456780654', 39, 'Dr. Young', 'Anxiety'),
('567890543', 40, 'Dr. Green', 'Depression');

GO

INSERT INTO StudentDaysAbsent (StudentID , EntryID)
VALUES
(15,4),(23,1),(20,2),(26,3),(11,13),(41,5),(7,6),(9,7),(12,8),(13,9),(35,10),(36,11),(40,12),(18,14),(29,15)

GO
INSERT INTO  [dbo].[Qualifications] (ID, qualification, NQF_Level, INSTITUTION)
VALUES
    (1, 'Bachelor of Education', 7, 'University of Johannesburg'),
    (2, 'Postgraduate Certificate in Education', 6, 'University of Cape Town'),
    (3, 'National Certificate in Early Childhood Development', 4, 'Northlink College'),
    (4, 'Diploma in Grade R Teaching', 5, 'Cape Peninsula University of Technology'),
    (5, 'Certificate in Teaching English to Speakers of Other Languages', 5, 'Wits Language School'),
    (6, 'Bachelor of Education in Foundation Phase', 7, 'University of Pretoria'),
    (7, 'Diploma in Teaching', 6, 'Durban University of Technology'),
    (8, 'National Professional Diploma in Education', 6, 'University of Limpopo'),
    (9, 'Advanced Certificate in Education', 6, 'University of the Western Cape'),
    (10, 'Certificate in Mathematics Teaching', 5, 'Mangosuthu University of Technology'),
    (11, 'National Diploma in Educare', 6, 'Central University of Technology'),
    (12, 'Bachelor of Arts in Education', 7, 'Rhodes University'),
    (13, 'Higher Certificate in Foundation Phase Teaching', 5, 'Nelson Mandela University'),
    (14, 'Certificate in Inclusive Education', 4, 'Tshwane University of Technology'),
    (15, 'Advanced Diploma in Educational Management and Leadership', 7, 'University of KwaZulu-Natal'),
	(16, 'Bachelor of Commerce in Accounting', 7, 'University of Cape Town'),
    (17, 'National Diploma in Office Management and Technology', 6, 'Durban University of Technology'),
    (18, 'Higher Certificate in Human Resource Management', 5, 'University of Pretoria'),
    (19, 'Certificate in Payroll and Income Tax Administration', 4, 'Cape Peninsula University of Technology'),
    (20, 'National Certificate in Security Operations', 4, 'Ekurhuleni East College'),
    (21, 'Certificate in Security Management', 5, 'University of Johannesburg')



GO

INSERT INTO StudentGuardians(StudentID, GuardianID, StreetNo, StreetName, PostalCode, City)
VALUES 
    (6, 11, 10, 'Church Street', '0083', 'Pretoria'),
    (7, 14, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (8, 16, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (9, 17, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (10, 55, 30, 'Andries Street', '0081', 'Pretoria'),
    (11, 56, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (12, 57, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (13, 58, 5, 'Bosman Street', '0001', 'Pretoria'),
    (14, 59, 15, 'Visagie Street', '0083', 'Pretoria'),
    (15, 60, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (16, 70, 10, 'Church Street', '0083', 'Pretoria'),
    (17, 71, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (18, 72, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (19, 75, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (20, 78, 30, 'Andries Street', '0081', 'Pretoria'),
    (21, 126, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (22, 127, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (23, 128, 5, 'Bosman Street', '0001', 'Pretoria'),
    (24, 140, 15, 'Visagie Street', '0083', 'Pretoria'),
    (25, 147, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (26, 151, 10, 'Church Street', '0083', 'Pretoria'),
    (27, 60, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (28, 17, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (29, 55, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (30, 72, 30, 'Andries Street', '0081', 'Pretoria'),
    (31, 14, 20, 'Pretorius Street', '0081', 'Pretoria'),
	 (33, 126, 5, 'Bosman Street', '0001', 'Pretoria'),
    (34, 60, 15, 'Visagie Street', '0083', 'Pretoria'),
    (35, 147, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (36, 11, 10, 'Church Street', '0083', 'Pretoria'),
    (37, 14, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (38, 16, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (39, 17, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (40, 55, 30, 'Andries Street', '0081', 'Pretoria'),
    (41, 56, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (42, 57, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (43, 58, 5, 'Bosman Street', '0001', 'Pretoria');

GO

INSERT INTO StudentSubject (StudentID, SubjectCode, TextBookCode)
VALUES
   (6, 'AC', '1001'),
   (6, 'AFREA', '1002'),
    (6, 'AFRHT', '1003'),
   (6, 'ENGFL', '1004'),
    (6, 'ENGHL', '1005'),
    (6, 'LO', '1006'),
   (6, 'MATH', '1007'),
    
   (7, 'AC', '1009'),
    (7, 'AFREA', '1010'),
    (7, 'AFRHT', '1011'),
    (7, 'ENGFL', '1012'),
    (7, 'ENGHL', '1013'),
    (7, 'LO', '1014'),
    (7, 'MATH', '1015'),
    
    (8, 'AC', '1017'),
    (8, 'AFREA', '1018'),
    (8, 'AFRHT', '1019'),
    (8, 'ENGFL', '1020'),
    (8, 'ENGHL', '1021'),
    (8, 'LO', '1022'),
    (8, 'MATH', '1023'),
   
    (9, 'AC', '1025'),
    (9, 'AFREA', '1026'),
    (9, 'AFRHT', '1027'),
    (9, 'ENGFL', '1028'),
    (9, 'ENGHL', '1029'),
    (9, 'LO', '1030'),
    (9, 'MATH', '1031'),
    
    (10, 'AC', '1033'),
    (10, 'AFREA', '1034'),
    (10, 'AFRHT', '1035'),
    (10, 'ENGFL', '1036'),
    (10, 'ENGHL', '1037'),
    (10, 'LO', '1038'),
    (10, 'MATH', '1039'),
    
    (11, 'AC', '1041'),
    (11, 'AFREA', '1042'),
    (11, 'AFRHT', '1043'),
    (11, 'ENGFL', '1044'),
    (11, 'ENGHL', '1045'),
    (11, 'LO', '1046'),
    (11, 'MATH', '1047'),
   
    (12, 'AC', '1049'),
    (12, 'AFREA', '1050'),
    (12, 'AFRHT', '1051'),
    (12, 'ENGFL', '1052'),
    (12, 'ENGHL', '1053'),
    (12, 'LO', '1054'),
    (12, 'MATH', '1055'),
    
    (13, 'AC', '1057'),
    (13, 'AFREA', '1058'),
    (13, 'AFRHT', '1059'),
	 (14, 'AC', '1060'),
    (14, 'AFREA', '1061'),
    (14, 'AFRHT', '1062'),
    (14, 'ENGFL', '1063'),
    (14, 'ENGHL', '1064'),
    (14, 'LO', '1065'),
    (14, 'MATH', '1066'),
    
    (15, 'AC', '1068'),
    (15, 'AFREA', '1069'),
    (15, 'AFRHT', '1070'),
    (15, 'ENGFL', '1071'),
    (15, 'ENGHL', '1072'),
    (15, 'LO', '1073'),
    (15, 'MATH', '1074'),
    
    (16, 'AC', '1076'),
    (16, 'AFREA', '1077'),
    (16, 'AFRHT', '1078'),
    (16, 'ENGFL', '1079'),
    (16, 'ENGHL', '1080'),
    (16, 'LO', '1081'),
    (16, 'MATH', '1082'),
    
    (17, 'AC', '1084'),
    (17, 'AFREA', '1085'),
    (17, 'AFRHT', '1086'),
    (17, 'ENGFL', '1087'),
    (17, 'ENGHL', '1088'),
    (17, 'LO', '1089'),
    (17, 'MATH', '1090'),
   
    (18, 'AC', '1092'),
    (18, 'AFREA', '1093'),
    (18, 'AFRHT', '1094'),
    (18, 'ENGFL', '1095'),
    (18, 'ENGHL', '1096'),
    (18, 'LO', '1097'),
    (18, 'MATH', '1098'),
  
    (19, 'AC', '1100'),
    (19, 'AFREA', '1101'),
    (19, 'AFRHT', '1102'),
    (19, 'ENGFL', '1103'),
    (19, 'ENGHL', '1104'),
    (19, 'LO', '1105'),
    (19, 'MATH', '1106'),
    
    (20, 'AC', '1108'),
    (20, 'AFREA', '1109'),
    (20, 'AFRHT', '1110'),
    (20, 'ENGFL', '1111'),
    (20, 'ENGHL', '1112'),
    (20, 'LO', '1113'),
    (20, 'MATH', '1114'),
    
	(21, 'AC', '1116'),
    (21, 'AFREA', '1117'),
    (21, 'AFRHT', '1118'),
    (21, 'ENGFL', '1119'),
    (21, 'ENGHL', '1120'),
    (21, 'LO', '1121'),
    (21, 'MATH', '1122'),
    
    (22, 'AC', '1124'),
    (22, 'AFREA', '1125'),
    (22, 'AFRHT', '1126'),
    (22, 'ENGFL', '1127'),
    (22, 'ENGHL', '1128'),
    (22, 'LO', '1129'),
    (22, 'MATH', '1130'),
   
    (23, 'AC', '1132'),
    (23, 'AFREA', '1133'),
    (23, 'AFRHT', '1134'),
    (23, 'ENGFL', '1135'),
    (23, 'ENGHL', '1136'),
    (23, 'LO', '1137'),
    (23, 'MATH', '1138'),
    
    (24, 'AC', '1140'),
    (24, 'AFREA', '1141'),
    (24, 'AFRHT', '1142'),
    (24, 'ENGFL', '1143'),
    (24, 'ENGHL', '1144'),
    (24, 'LO', '1145'),
    (24, 'MATH', '1146'),
    
    (25, 'AC', '1148'),
    (25, 'AFREA', '1149'),
    (25, 'AFRHT', '1150'),
    (25, 'ENGFL', '1151'),
    (25, 'ENGHL', '1152'),
    (25, 'LO', '1153'),
    (25, 'MATH', '1154'),
    
    (26, 'AC', '1156'),
    (26, 'AFREA', '1157'),
    (26, 'AFRHT', '1158'),
    (26, 'ENGFL', '1159'),
    (26, 'ENGHL', '1160'),
    (26, 'LO', '1161'),
    (26, 'MATH', '1162'),
    
	(27, 'AC', '1164'),
    (27, 'AFREA', '1165'),
    (27, 'AFRHT', '1166'),
    (27, 'ENGFL', '1167'),
    (27, 'ENGHL', '1168'),
    (27, 'LO', '1169'),
    (27, 'MATH', '1170'),
  
    (28, 'AC', '1172'),
    (28, 'AFREA', '1173'),
    (28, 'AFRHT', '1174'),
    (28, 'ENGFL', '1175'),
    (28, 'ENGHL', '1176'),
    (28, 'LO', '1177'),
    (28, 'MATH', '1178'),
    
    (29, 'AC', '1180'),
    (29, 'AFREA', '1181'),
    (29, 'AFRHT', '1182'),
    (29, 'ENGFL', '1183'),
    (29, 'ENGHL', '1184'),
    (29, 'LO', '1185'),
    (29, 'MATH', '1186'),
    
    (30, 'AC', '1188'),
    (30, 'AFREA', '1189'),
    (30, 'AFRHT', '1190'),
    (30, 'ENGFL', '1191'),
    (30, 'ENGHL', '1192'),
    (30, 'LO', '1193'),
    (30, 'MATH', '1194'),
    
    (31, 'AC', '1196'),
    (31, 'AFREA', '1197'),
    (31, 'AFRHT', '1198'),
    (31, 'ENGFL', '1199'),
    (31, 'ENGHL', '1200'),
    (31, 'LO', '1201'),
    (31, 'MATH', '1202'),
   
    (32, 'AC', '1204'),
    (32, 'AFREA', '1205'),
    (32, 'AFRHT', '1206'),
    (32, 'ENGFL', '1207'),
    (32, 'ENGHL', '1208'),
    (32, 'LO', '1209'),
    (32, 'MATH', '1210'),
    
    (33, 'AC', '1212'),
    (33, 'AFREA', '1213'),
    (33, 'AFRHT', '1214'),
    (33, 'ENGFL', '1215'),
    (33, 'ENGHL', '1216'),
    (33, 'LO', '1217'),
    (33, 'MATH', '1218'),
    
    (34, 'AC', '1220'),
    (34, 'AFREA', '1221'),
    (34, 'AFRHT', '1222'),
    (34, 'ENGFL', '1223'),
	 (41, 'LO', '12360'),
	(42, 'AC', '12361'),
  (42, 'AFREA', '12362'),
  (42, 'AFRHT', '12363'),
  
  (43, 'ENGFL', '12365'),
  (35, 'ENGHL', '12366'),
  (35, 'AFREA', '12367'),
  (35, 'AFRHT', '12368'),
  (36, 'MATH', '12369'),
  (36, 'LO', '12370'),
  (36, 'ENGFL', '12371'),
  (37, 'AC', '12372'),
  (37, 'AFREA', '12373'),
  (37, 'AFRHT', '12374'),
  (38, 'LO', '12375'),
  (38, 'AFRHT', '12376'),
  (38, 'ENGFL', '12377'),
  (39, 'ENGHL', '12378'),
  (39, 'MATH', '12379'),
  (39, 'AC', '12380'),
  (40, 'LO', '12381'),
  (40, 'AFREA', '12382'),
  (40, 'AFRHT', '12383'),
  (41, 'MATH', '12384'),
  (41, 'ENGHL', '12385'),
  (42, 'MATH', '12386'),
  (42, 'ENGHL', '12387'),
  (43, 'AC', '12388');

GO
INSERT INTO ExtraCurricular( [Name], HeadOfActivity, [Type])
VALUES
    ( 'Football Club',  'Coach Smith', 'Sport'),
    ( 'Netball',  'Mrs. Johnson', 'Sport'),
    ( 'Chess Club',  'Mr. Rodriguez', 'Academic'),
    ( 'Karate',  'Coach Thompson', 'Sport'),
    ('Art Club',  'Mrs. Lee', 'Artistic'),
    ( 'Music Club',  'Mr. Davis', 'Artistic'),
    ('Rugby',  'Mr. Patel', 'STEM'),
    ('Swimming Club', 'Coach Ramirez', 'Sport'),
    ('Drama Club',  'Mrs. Wilson', 'Artistic'),
    ( 'Coding Club', 'Mr. Kim', 'STEM'),
    ( 'Volleyball Club',  'Coach Nguyen', 'Sport'),
    ('Gardening Club', 'Mrs. Green', 'Hobby'),
    ( 'Dance Club', 'Mrs. Hernandez', 'Artistic'),
    ( 'Hockey', 'Coach Thompson', 'Sport'),
    ( 'Math Club',  'Mr. Brown', 'Academic'),
    ( 'Athlectics Club',  'Coach Garcia', 'Sport')


GO
INSERT INTO StudentGuardians(StudentID, GuardianID, StreetNo, StreetName, PostalCode, City)
VALUES 
    (6, 11, 10, 'Church Street', '0083', 'Pretoria'),
    (7, 14, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (8, 16, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (9, 17, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (10, 55, 30, 'Andries Street', '0081', 'Pretoria'),
    (11, 56, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (12, 57, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (13, 58, 5, 'Bosman Street', '0001', 'Pretoria'),
    (14, 59, 15, 'Visagie Street', '0083', 'Pretoria'),
    (15, 60, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (16, 70, 10, 'Church Street', '0083', 'Pretoria'),
    (17, 71, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (18, 72, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (19, 75, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (20, 78, 30, 'Andries Street', '0081', 'Pretoria'),
    (21, 126, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (22, 127, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (23, 128, 5, 'Bosman Street', '0001', 'Pretoria'),
    (24, 140, 15, 'Visagie Street', '0083', 'Pretoria'),
    (25, 147, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (26, 151, 10, 'Church Street', '0083', 'Pretoria'),
    (27, 60, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (28, 17, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (29, 55, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (30, 72, 30, 'Andries Street', '0081', 'Pretoria'),
    (31, 14, 20, 'Pretorius Street', '0081', 'Pretoria'),
     (33, 126, 5, 'Bosman Street', '0001', 'Pretoria'),
    (34, 60, 15, 'Visagie Street', '0083', 'Pretoria'),
    (35, 147, 20, 'Sophie De Bruyn Street', '0002', 'Pretoria'),
    (36, 11, 10, 'Church Street', '0083', 'Pretoria'),
    (37, 14, 25, 'Nelson Mandela Drive', '0001', 'Pretoria'),
    (38, 16, 5, 'Francis Baard Street', '0002', 'Pretoria'),
    (39, 17, 15, 'Thabo Sehume Street', '0001', 'Pretoria'),
    (40, 55, 30, 'Andries Street', '0081', 'Pretoria'),
    (41, 56, 20, 'Pretorius Street', '0081', 'Pretoria'),
    (42, 57, 10, 'Sisulu Street', '0082', 'Pretoria'),
    (43, 58, 5, 'Bosman Street', '0001', 'Pretoria');

GO


INSERT INTO [dbo].[EmployeeQualifications](EmployeeID,QualificationID,Date_Completed)
VALUES 
(23,6,2012-01-01),
(31,12,2010-03-15),
(143,15,2015-02-28),
(144,10,2016-08-10),
(145,2,2014-05-01),
(146,7,2013-11-13),
(147,8,2005-08-13),
(148,19,2007-07-20),
(149,21,2011-09-15),
(150,20,2010-10-20),
(151,21,2008-05-26),
(152,11,2007-06-30),
(153,11,2001-07-11),
(154,19,2001-08-12),
(155,18,2011-11-20),
(156,12,2010-11-20),
(157,12,2002-11-11),
(158,10,2006-12-20),
(159,9,2000-01-16),
(160,1,2000-04-15),
(161,2,2010-05-20),
(162,3,2010-06-20),
(163,5,2011-12-20),
(164,6,2010-11-20),
(165,20,2013-11-20),
(166,4,2010-11-20),
(167,7,2005-11-20),
(168,17,2002-01-20);

GO
INSERT INTO EmployeeMed(MedicalAid_No, EmployeeID, MedicalAid_Name, Special_Condition)
VALUES
(485656780, 146, 'Bonitas', 'None'),
(084556781, 147, 'GEMS', 'None'),
(275856782, 31, 'Discovery', 'None'),
(852756783, 23, 'MediHelp', 'None'),
(947236784, 148, 'GEMS', 'Lactose intolerant'),
(126681085, 149, 'GEMS', 'None'),
(127356786, 150, 'Momentum','None'),
(397427187, 151, 'GEMS', 'Lactose intolerant'),
(413456788, 152, 'Bonitas', 'None'),
(809956789, 153, 'MediHelp', 'Asthma'),
(200316790, 154, 'GEMS', 'None'),
(034567891, 155, 'Discovery', 'None'),
(999456792, 156, 'Bonitas', 'None'),
(122905693, 157, 'Discovery', 'None'),
(100056794, 158, 'GEMS', 'Asthma'),
(742566785, 159, 'Momentum', 'None'),
(016341326, 160, 'Momentum', 'None'),
(123456787, 161, 'GEMS', 'Asthma'),
(510367898,163, 'MediHelp', 'None')

GO

INSERT INTO DaysAbsent (EntryID, DayAbsent, Reason)
VALUES
    (1,'2022-01-10', 'Flu'),
    (2,'2022-01-12', 'Family emergency'),
    (3,'2022-02-05', 'Stomach ache'),
    (4,'2022-02-15', 'Fever'),
    (5,'2022-03-01', 'Dental appointment'),
    (6,'2022-03-10', 'Sick'),
    (7,'2022-03-20', 'Family vacation'),
    (8,'2022-04-02', 'Flu'),
    (9,'2022-04-05', 'Allergy'),
    (10,'2022-05-01', 'Public holiday'),
    (11,'2022-05-10', 'Stomach flu'),
    (12,'2022-05-15', 'Family emergency'),
    (13,'2022-06-03', 'Fever'),
    (14,'2022-06-10', 'Sick'),
    (15,'2022-06-20', 'Dental appointment');

GO
INSERT INTO Grades (StudentID, SubjectCode, Term1, Term2, Term3)
VALUES

(6, 'AFREA', 87, 91, 89),
(6, 'ENGFL', 75, 78, 80),
(6, 'ENGHL', 80, 85, 82),
(6, 'LO', 65, 70, 68),
(6, 'MATH', 85, 89, 87)
(6, 'SS', 78, 82, 80),
(7, 'AFREA', 90, 92, 91),
(7, 'ENGFL', 80, 83, 82),
(7, 'ENGHL', 85, 87, 86),
(7, 'LO', 70, 72, 71),
(7, 'MATH', 90, 92, 91),
(7, 'SS', 82, 85, 84),
(8, 'AFREA', 80, 82, 81),
(8, 'ENGFL', 70, 72, 71),
(8, 'ENGHL', 75, 77, 76),
(8, 'LO', 60, 62, 61),
(8, 'MATH', 80, 82, 81),

(8, 'SS', 72, 74, 73),
(9, 'AFREA', 85, 88, 86),
(9, 'ENGFL', 73, 75, 74),
(9, 'ENGHL', 78, 80, 79),
(9, 'LO', 68, 70, 69),
(9, 'MATH', 83, 85, 84),

(9, 'SS', 80, 82, 81),
(10, 'AFREA', 92, 94, 93),
(10, 'ENGFL', 78, 80, 79),
(10, 'ENGHL', 83, 85, 84),
(10, 'LO', 72, 74, 73),
(10, 'MATH', 90, 92, 91),

(10, 'SS', 85, 87, 86),
(11, 'AFREA', 80, 82, 81),
(11, 'ENGFL', 70, 72, 71),
(11, 'ENGHL', 75, 77, 76),
(11, 'LO', 60, 62, 61),
(11, 'MATH', 80, 82, 81),

(11, 'SS', 72, 74, 73),
(12, 'AFREA', 85, 88, 86),
(12, 'ENGFL', 73, 75, 74),
(12, 'ENGHL', 78, 80, 79),
(12, 'MATH', 87, 92, 91),
(12, 'ENGHL', 74, 80, 83),
(12, 'ENGFL', 81, 75, 77),
(12, 'LO', 88, 90, 91),
(12, 'AFREA', 90, 93, 91),
(12, 'SS', 85, 86, 87),
(13, 'MATH', 93, 91, 94),
(13, 'ENGHL', 80, 82, 84),
(13, 'ENGFL', 76, 75, 79),
(13, 'LO', 85, 87, 86),
(13, 'AFREA', 92, 94, 91),

(13, 'SS', 88, 89, 87),
(14, 'MATH', 95, 93, 94),
(14, 'ENGHL', 82, 85, 88),
(14, 'ENGFL', 77, 79, 80),
(14, 'LO', 91, 92, 93),
(14, 'AFREA', 94, 92, 93),

(14, 'SS', 89, 87, 88),
(15, 'MATH', 91, 92, 94),
(15, 'ENGHL', 78, 81, 82),
(15, 'ENGFL', 76, 75, 77),
(15, 'LO', 87, 88, 89),
(15, 'AFREA', 92, 90, 94),

(15, 'SS', 86, 87, 88),
(16, 'MATH', 85, 88, 90),
(16, 'ENGHL', 73, 75, 77),
(16, 'ENGFL', 70, 72, 75),
(16, 'LO', 80, 82, 83),
(16, 'AFREA', 85, 88, 89),

(16, 'SS', 82, 83, 85),
(17, 'MATH', 92, 94, 95),
(17, 'ENGHL', 82, 85, 87),
(17, 'ENGFL', 80, 81, 82),
(17, 'LO', 89, 90, 91),
(17, 'AFREA', 92, 94, 93),
(17, 'SS', 88, 89, 87),
( 35, 'ENGFL', 62, 78, 85),
( 35, 'ENGHL', 80, 86, 90),
( 35, 'LO', 73, 76, 80),
( 35, 'MATH', 65, 72, 75),
( 35, 'AFREA', 85, 89, 93),

( 35, 'SS', 68, 75, 80),
( 36, 'ENGFL', 78, 85, 90),
( 36, 'ENGHL', 75, 80, 85),
( 36, 'LO', 70, 76, 80),
( 36, 'MATH', 72, 75, 78),
( 36, 'AFREA', 80, 85, 90),

( 36, 'SS', 75, 80, 85),
( 37, 'ENGFL', 65, 72, 75),
( 37, 'ENGHL', 72, 75, 78),
( 37, 'LO', 68, 75, 80),
( 37, 'MATH', 78, 82, 85),
( 37, 'AFREA', 75, 80, 85),

( 37, 'SS', 70, 76, 80);

---------------------------------------------------------------------------------------------------------------------

---Queries
USE LaerskoolTheresaPark
UPDATE Students
SET Grade = 1
WHERE ClassID = 1
GO
-- Query To Count the amount of students that are in a each class room 
SELECT Distinct ClassID , Count(StudentID) AS 'Number of students'
FROM Students
GROup by ClassID

GO 
--- This query displays students StudentName , SubjectName and Teacher that teach the subject and what class they are in 
SELECT s.FirstName ,s.LastName ,S.Grade, ss.SubjectName ,e.FirstName AS 'Teacher Name' , c.Class_Name 
FROM Students s 
INNER JOIN 
Classroom c
ON 
c.ClassID = s.ClassID
INNER JOIN Employee e
ON
e.EmployeeID = c.EmployeeID
INNER JOIN  TeacherSubject ts
ON
e.EmployeeID = ts.EmployeeID
INNER JOIN Subjects ss
ON
ss.SubjectCode = ts.SubjectCode

 GO
--Query that checks which Employees are inactive 

BEGIN TRANSACTION
SELECT *
FROM Employee 
Where status = 'Leave'



--Query retrieves the names of all teachers in the school, along with their average grade for all subjects they are teaching using inner joins
USE LaerskoolTheresaPark
SELECT  Distinct Employee.FirstName, TeacherSubject.employeeid, Students.studentID, Subjects.subjectname, AVG(CAST(GRADES.Term2 AS DECIMAL(10,2))) AS avg_grade
FROM TeacherSubject
INNER JOIN StudentSubject
ON TeacherSubject.subjectcode = StudentSubject.subjectcode
INNER JOIN Students
ON StudentSubject.studentID = Students.studentID
INNER JOIN Grades
ON StudentSubject.studentID = Grades.studentID AND TeacherSubject.subjectcode = Grades.subjectcode
INNER JOIN Employee
ON TeacherSubject.employeeid = Employee.employeeid
INNER JOIN Subjects
ON TeacherSubject.subjectcode = Subjects.subjectcode
GROUP BY Employee.FirstName, TeacherSubject.employeeid, Students.studentID, Subjects.subjectname;



-----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---ALTER Queries
GO
ALTER TABLE DisciplinaryRecord
ADD Reason VARCHAR(255) Not Null

GO
ALTER TABLE Students
ADD Constraint CK_Foreign
FOREIGN KEY (ClassID) REFERENCES ClassRoom(ClassID)
GO
ALTER TABLE LaerskoolTheresaPark.dbo.JobPosition
ALTER COLUMN Description VARCHAR(max)

GO
ALTER TABLE Employee
ALTER COLUMN Phone VARCHAR(255)
GO
ALTER TABLE TransactionHistory
ADD AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID)

GO
Alter table GRADES
ADD Term1 INT 
GO 
USE LaerskoolTheresaPark
Alter table GRADES
ADD Term2 INT 
GO
USE LaerskoolTheresaPark
Alter table GRADES
ADD Term3 INT


-------------------------------------------------------------------------------------------------------------------------
--TRIGGERS

USE LaerskoolTheresaPark
GO
CREATE TRIGGER update_teacher_salary
ON Employee
AFTER UPDATE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM inserted WHERE positioncode = 'TECH')
    BEGIN

        UPDATE e
        SET e.salary = i.salary * 1.05 
        FROM Employee e
        INNER JOIN inserted i ON e.employeeid = i.employeeid
        WHERE i.positioncode = 'TECH'
    END
END;
GO

USE [LaerskoolTheresaPark]
GO
CREATE TRIGGER InsertStudents
ON Students
AFTER INSERT,UPDATE
AS 
    BEGIN 
            DECLARE @StudID        INT,
                    @FirstName    VARCHAR(50),
                    @LastnName    VARCHAR(50),
                    @ClassID    VARCHAR(50),
                    @PrimaryL    VARCHAR(50),
                    @DateOfE    DATE,
                    @Gender        VARCHAR(10),
                    @DOB        DATE,
                    @IDN        INT


 

            SELECT @StudID = StudentID, @FirstName =  INSERTED.FirstName, @LastnName = INSERTED.LastName, @ClassID = INSERTED.ClassID,
                   @PrimaryL= INSERTED.PrimaryLanguage, @DateOfE = INSERTED.DateOfEnrollment, @Gender = INSERTED.Gender,
                   @DOB = inserted.DateOfBirth, @IDN = inserted.IDNumber
            FROM inserted

 

            

 

            INSERT INTO Students
            VALUES(@StudID, @FirstName, @LastnName, @ClassID,@PrimaryL, @DateOfE, @Gender,@DOB,@IDN)
    END







---------------------------------------------------------------------------------------------------------------------
--VIEWS

-- A view that shows the names of all the students that partake in extracurricualr activities  in the senior phase  

GO
CREATE VIEW vw_StudentExtraCurricular
AS
SELECT FirstName , LastName, Grade , ex.[Name]
FROM Students s
INNER JOIN StudentCurriculum sc
ON
s.StudentID = sc.StudentID
INNER JOIN ExtraCurricular ex
ON
ex.ExtraCurricularID = sc.ExtraCurricularID

WHERE Grade >=5

--This View gives a summary of Students subjects  grade and 
GO

CREATE VIEW vwStudentDetails
AS
SELECT s.FirstName ,s.LastName ,S.Grade, ss.SubjectName ,e.FirstName AS 'Teacher Name' , c.Class_Name 
FROM Students s 
INNER JOIN 
Classroom c
ON 
c.ClassID = s.ClassID
INNER JOIN Employee e
ON
e.EmployeeID = c.EmployeeID
INNER JOIN  TeacherSubject ts
ON
e.EmployeeID = ts.EmployeeID
INNER JOIN Subjects ss
ON
ss.SubjectCode = ts.SubjectCode




-- This view is used to see which employees are teachers and what subjects they teach 
GO 
CREATE VIEW vw_TeacherSubject
AS 
SELECT FirstName ,LastName, PositionCode , SubjectName
FROM Employee e
INNER JOIN TeacherSubject ts
ON
e.EmployeeID = ts.EmployeeID
INNER JOIN Subjects s
ON
s.SubjectCode = ts.SubjectCode

-----------------------------------------------------------------------------------------------------------------------------
--Functions

USe LaerskoolTheresaPark
GO
--This function allows user to find the Current average For a student
Alter Function  getStudent_Average (
@StudentID INT , @SubjectCode VARCHAR(30)
) 
RETURNS INT
BEGIN 
	DECLARE  @T1 INT ,@T2 INT,@T3 INT 
	SELECT   @T1 = Term1 , @T2 = Term2 ,@T3 = Term3
	FROM Students s
	INNER JOIN GRADES g
	ON
	s.StudentID = g.StudentID
	WHERE   s.StudentID=@StudentID  AND g.SubjectCode = @SubjectCode
	Declare @Studentaverage DECIMAL 
	SET @Studentaverage = ( @T1 + @T2 + @T3 )/3
	RETURN @Studentaverage 
END
--ALter Table GRADES
--ALTER Column Term4 INT NULL DEFAULT 0
GO 
USE LaerskoolTheresaPark
Select FirstName ,DBO.getStudent_Average(12,'Math') AS  StudentAverage  FROM Students WHERE StudentID =12


GO 
---Function calculates the age of a specific Student
CREATE Function getStudentAge(@StudentID INT)
Returns INT
BEGIN
	DECLARE @age INT
	SELECT @age = DateDiff(Year , DateOfBirth, GetDate())
	FROM Students
	WHERE StudentID = @StudentID
	RETURN @age

END


GO

----------------------------------------------------------------------------------------------------------------
----------Stored Procedures

--This procedure allows faster access to students emergency details in case of emergencies 
CREATE PROC sp_SearchStudentEmergencyDetails
(@StudentName VARCHAR(50))
AS
SELECT FirstName , s.LastName , Grade , gd.[Name] AS 'GuardianName' , Phone  AS 'GuardianNumber' , MedicalAidNo ,MedicalAidName, SpecialCondition
FROM Students s
INNER JOIN  StudentGuardians sg
ON
s.StudentID = sg.StudentID
INNER Join GuardiansDetails gd
ON
gd.GuardianID = sg.GuardianID
INNER JOIN StudentMed sm
ON
s.StudentID = sm.StudentID
WHERE FirstName = @StudentName
GO 
-- This procedurer use the getStudent_Average function to display the current averages for all the students according to each subject that they take s
ALTER PROC sp_StudentCurrentAverage
AS
BEGIN 
DECLARE  @ID INT ,@Subject VARCHAR(50) , @Name Varchar(30) , @Surname varchar(30) ,  @grade INT ,@average INT
DECLARE sp_SCA_Cursor Cursor for 
SELECT s.StudentID ,SubjectCode ,FirstName ,LastName , Grade 
From Students s INNER JOIN StudentSubject ss ON  s.StudentID = SS.StudentID
OPEN sp_SCA_Cursor
FETCH NEXT FROM sp_SCA_Cursor INTO  @ID, @Subject, @Name,@Surname , @grade  
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		SET @average =  dbo.getStudent_Average(@ID ,@Subject)
		PRINT 'Student:  ' + @Name +' ' + @Surname
		PRINT '------------------------------------'
		PRINT 'Subject: ' + @Subject
		PRINT' Grade ' +  CONVERT(VARCHAR(10),@grade)
		PRINT' CurrentAverage: ' + CONVERT(VARCHAR(10),@average)
		PRINT ' ------------------------------------'
		FETCH NEXT FROM sp_SCA_Cursor INTO @ID, @Subject,  @Name,@Surname , @grade 
	END
CLOSE sp_SCA_Cursor
DEALLOCATE sp_SCA_Cursor
END


GO

CREATE PROCEDURE TOP3_SUBJECTS
AS
    BEGIN
            SELECT TOP 3 SubjectCode, AVG((Term1 + Term2 + Term3)/3) AS AverageForSubjects
            FROM GRADES
            GROUP BY SubjectCode
            ORDER BY AverageForSubjects DESC;
    END


GO


CREATE PROCEDURE RepsForStuds

AS

BEGIN

    DECLARE @StID INT,

            @FrstName VARCHAR(50),

            @LstName VARCHAR(50),

            @SubC VARCHAR(50),

            @T1 INT,

            @T2 INT,

            @T3 INT,

            @T4 INT

 

    DECLARE RepsForStud_Cursor CURSOR FOR

    SELECT Students.StudentID, FirstName, LastName, SubjectCode, Term1, Term2, Term3

    FROM Students 

    INNER JOIN [dbo].[GRADES]

    ON Students.StudentID = GRADES.StudentID

 

    OPEN RepsForStud_Cursor

    FETCH NEXT FROM RepsForStud_Cursor INTO @StID, @FrstName, @LstName, @SubC, @T1, @T2, @T3

 

    WHILE @@FETCH_STATUS = 0

    BEGIN

        PRINT 'STUDENT NAME: ' + @FrstName + ' ' + @LstName

        PRINT '---------------------------------------------'

        PRINT 'SUBJECT CODE: ' + @SubC

        PRINT 'TERM 1: ' + CONVERT(VARCHAR(10), @T1)

        PRINT 'TERM 2: ' + CONVERT(VARCHAR(10), @T2)

        PRINT 'TERM 3: ' + CONVERT(VARCHAR(10), @T3)

        PRINT '---------------------------------------------'

        FETCH NEXT FROM RepsForStud_Cursor INTO @StID, @FrstName, @LstName, @SubC, @T1, @T2, @T3

    END

 

    CLOSE RepsForStud_Cursor

    DEALLOCATE RepsForStud_Cursor

END
 GO
CREATE PROC [dbo].[p_TopStudentsPerSubject]

@Subject VARCHAR(30)

AS

    (SELECT distinct top 5 FirstName, LastName, subjectCode, (Term1 + Term2 + Term3)/3 AS 'Year Average'

    FROM Students

    INNER JOIN GRADES ON Students.StudentID=GRADES.StudentID

    WHERE SubjectCode = @subject)

    ORDER BY [Year Average] DESC



----------------------------------------------------------------------------------------------------------------------------------

/*Declare @laerskoolTheresapark VARCHAR(50)
SET @laerskoolTheresapark  = 'FULL BACKUP Northwind Database' + Convert(VARCHAR (12), GETDATE())
BACKUP DATABASE LaerskoolTheresaPark
TO DISK =' C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\ LaerskoolTheresaPark.bak'
WITH FORMAT,
NAME = @laerskoolTheresapark*/


