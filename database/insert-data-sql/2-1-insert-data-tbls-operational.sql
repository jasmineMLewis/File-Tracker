USE FileTracker;
GO

/****** 
Tables: 3
- Boxes
- Files
- Users
******/

/****** Object:  Table [dbo].[Boxes]  ******/
INSERT INTO Boxes (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2016, 1, NULL, NULL, NULL, GETDATE(), 1, 1);
INSERT INTO Boxes (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2017, 1, NULL, NULL, NULL, GETDATE(), 2, 1);
INSERT INTO Boxes (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2017, 2, NULL, NULL, NULL, GETDATE(), 3, 1);

/****** Object:  Table [dbo].[Files]  ******/
INSERT INTO Files (ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)
VALUES ('Monkey D', 'Luffy', '1234', GETDATE(), 'captain', 0, GETDATE(), 1, 1, 1, 1);
INSERT INTO Files (ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)
VALUES ('Roronoa', 'Zoro', '5419', GETDATE(), 'swordsmen', 0, GETDATE(), 1, 1, 2, 1);
INSERT INTO Files (ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID,  LocationID, SubmittedByUserID)
VALUES ('Cat Burglar', 'Nami', '3615', GETDATE(), 'navigator', 0, GETDATE(), 3, 1, 3, 1);

/****** Object:  Table [dbo].[Users]  ******/
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Admin', '', 'admin@gmail.com', '123', 1, 1); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Project', 'Specialist', 'projectSpecialist@gmail.com', '123', 1, 2); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Housing', 'Specialist', 'housingSpecialist@gmail.com', '123', 1, 3); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('File Room', 'Clerk', 'fileRoomClerk@gmail.com', '123', 1, 4); 
INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Viewer', '', 'viewer@gmail.com', '123', 1, 5); 
