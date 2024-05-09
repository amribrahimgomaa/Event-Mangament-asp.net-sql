
CREATE TABLE users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    RoleId INT DEFAULT 2, -- Default role for regular users (assuming "User" role has RoleId 2)
    FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
);
INSERT INTO Users (UserName, Email, Password, RoleId)
VALUES ('admin', 'admin@example.com', '6666', 1); -- Assigns the role of "Admin"

insert into [dbo].[role] values 
(1,'Admin'), (2,'User');

select * from [dbo].[role];
select * from [dbo].[users];

INSERT INTO Users (UserName, Email, Password) VALUES ('Alaa Nader', 'alaan65@gmail.com', '12345');
INSERT INTO Users (UserName, Email, Password) VALUES ('Salma Refaat', 'salmarfaat19@gmail.com', '2990');
INSERT INTO Users (UserName, Email, Password) VALUES ('Shahd Osama', 'shahdhadad757@gmail.com', '21124');
INSERT INTO Users (UserName, Email, Password) VALUES ('Ahmed Mohammed', 'a.mohamed@gmail.com', '3456');
INSERT INTO Users (UserName, Email, Password) VALUES ('Mariam Ali', 'mar.65@gmail.com', '0994');


UPDATE users
SET Email = 'Roaaelghandour28@gmail.com'
WHERE UserName = 'Roaa Khaled';


ALTER TABLE users
ADD UserType VARCHAR(50);
UPDATE Users
SET UserType = CASE 
                    WHEN RoleId = 1 THEN 'Admin'
                    WHEN RoleId = 2 THEN 'User'
                    ELSE 'Unknown'
                END;


select UserName,Email from [dbo].[users] ;
--------------------------------------------------
CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY,
    UserID INT, -- Foreign key referencing Users table
    Name NVARCHAR(255),
    Address NVARCHAR(255),
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(255),
    EventDate DATE,
    Details NVARCHAR(MAX),
    EstimatedBudget DECIMAL(18, 2),
    EstimatedGuestCount INT,
    EventType NVARCHAR(50),
    IsCustomized BIT,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);
select*from events;

ALTER TABLE [dbo].[Events]
DROP COLUMN [IsCustomized];

CREATE TABLE Packages (
    PackageId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    FullName NVARCHAR(100),
    Address NVARCHAR(255),
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(255),
    EventDate DATE,
    EventType NVARCHAR(50),
	SelectedEventType NVARCHAR(50), -- Fixed typo in column definition
    FOREIGN KEY (UserId) REFERENCES Users(ID) -- Corrected the foreign key reference
);
select * from Packages; 
---------------------------------
CREATE TABLE AccountInfo (
    AcoountID INT PRIMARY KEY Identity(1,1),
	UserID int,
    Username NVARCHAR(50),
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    Country NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
   FOREIGN KEY (UserId) REFERENCES Users(ID) -- Corrected the foreign key reference

);
Select * from AccountInfo ;
INSERT INTO AccountInfo (UserID, ProfilePhotoPath, Username, Name, Email, Country, PhoneNumber)
VALUES (1, 'sara.jpg', 'sara ahmed', 'sara', 'sara@gmail.com', 'egypt', '0109 1976689');

SELECT TOP 1 * FROM AccountInfo WHERE UserID = 12 ORDER BY  AcoountID DESC;
SELECT password FROM Users WHERE password='12345';
SELECT COUNT(*) FROM Users WHERE Id = 13 AND Password = '56784';

SELECT Id, UserName, Email, UserType FROM users;
SELECT UserId,Name, Address, PhoneNumber, EventDate, EstimatedBudget, EstimatedGuestCount, EventType FROM Events;
SELECT UserId,PackageId,FullName, Address, PhoneNumber, EventDate, EventType FROM Packages;

CREATE TABLE Payment (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    PackageId INT,
    PaymentAmount DECIMAL(10, 2), -- Adjust the data type as needed
    PaymentDate DATETIME,
    PaymentType  NVARCHAR(50), -- Assuming PaymentType is a string, adjust the length as needed
    CardHolderName VARCHAR(255),
    CardNumber VARCHAR(16), -- Assuming CardNumber is a 16-digit string, adjust the length as needed
    ExpiryDate DATE, -- Assuming ExpiryDate is a date
    CVV VARCHAR(4) -- Assuming CVV is a 4-digit string, adjust the length as needed
    CONSTRAINT FK_Payment_Packages FOREIGN KEY (PackageId) REFERENCES Packages(PackageId) -- Modify this line
);
INSERT INTO Payment (PackageId, PaymentAmount, PaymentDate, PaymentType, CardHolderName, CardNumber, ExpiryDate, CVV) 
VALUES (12, 40000, '2024-12-12', 'credit', 'alaa', '123456789101112', '2025-12-12', '2222');
select * from Payment;
drop table payment;

CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [int] NULL,
	[PaymentAmount] [decimal](10, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentType] [varchar](50) NULL,
	[CardHolderName] [varchar](100) NULL,
	[CardNumber] [varchar](16) NULL,
	[ExpiryDate] [date] NULL,
	[CVV] [varchar](4) NULL)

	select * from Payment;
