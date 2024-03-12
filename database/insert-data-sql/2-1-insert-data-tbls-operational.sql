USE FileTracker;
GO

/****** 
Tables: 3
- Boxes
- Files
- Users
******/

/****** Object:  Table [dbo].[Boxes]  ******/
INSERT INTO Boxes (BoxNumber, Year, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (1, 2016, GETDATE(), GETDATE(), GETDATE(), GETDATE(), 4, 4);

/****** Object:  Table [dbo].[Files]  ******/
INSERT INTO Files (ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)
VALUES ('Monkey D', 'Luffy', '1234', GETDATE(), 'First Test Box', 0, GETDATE(), 1, 1, 1, 1);

/****** Object:  Table [dbo].[Users]  ******/
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Admin', '', 'admin@gmail.com', '123', '1', '1'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Project', 'Specialist', 'projectSpecialist@gmail.com', '123', '1', '2'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Housing', 'Specialist', 'housingSpecialist@gmail.com', '123', '1', '3'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('File Room', 'Clerk', 'fileRoomClerk@gmail.com', '123', '1', '4'); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID) VALUES ('Viewer', '', 'viewer@gmail.com', '123', '1', '5'); 

