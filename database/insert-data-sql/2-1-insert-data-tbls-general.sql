USE FileTracker;
GO

/****** 
Tables: 1
- Users
******/

/****** Object:  Table [dbo].[Users]  ******/
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Admin', 'One', 'adminOne@gmail.com', 'Admin', '1', '1'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('ProjectSpecialist', 'One', 'projectSpecialistOne@gmail.com', 'ProjectSpecialist', '1', '2'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('HousingSpecialist', 'One', 'housingSpecialist@gmail.com', 'HousingSpecialist', '1', '3'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('FileRoomClerk', 'One', 'fileRoomClerk@gmail.com', 'FileRoomClerk', '1', '4'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Viewer', 'One', 'viewer@gmail.com', 'Viewer', '1', '5'); 

