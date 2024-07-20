USE FileTracker;
GO

/****** 
Tables: 3
- User
- Box
- File
******/

/****** Object:  Table [dbo].[User]  ******/
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Admin', '', 'admin@gmail.com', 'Qwerty1', 1, 1); 
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Project', 'Specialist', 'projectSpecialist@gmail.com', 'Qwerty1', 1, 2); 
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('Housing', 'Specialist', 'housingSpecialist@gmail.com', 'Qwerty1', 1, 3); 
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEnabled, RoleID)
VALUES ('File Room', 'Clerk', 'fileRoomClerk@gmail.com', 'Qwerty1', 1, 4); 

/****** Object:  Table [dbo].[Box]  ******/
INSERT INTO Box (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2016, 1, GETDATE(), NULL, NULL, GETDATE(), 1, 1);
INSERT INTO Box (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2017, 1, GETDATE(), NULL, NULL, GETDATE(), 2, 1);
INSERT INTO Box (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)
VALUES (2017, 2, GETDATE(), NULL, NULL, GETDATE(), 3, 1);

/****** Object:  Table [dbo].[File]  ******/
INSERT INTO [File] (ClientFirstName, ClientLastName, ClientLastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)
VALUES ('Monkey', 'Luffy', '1234', GETDATE(), 'captain', 0, GETDATE(), 1, 1, 1, 1);
INSERT INTO [File] (ClientFirstName, ClientLastName, ClientLastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)
VALUES ('Roronoa', 'Zoro', '5419', GETDATE(), 'swordsmen', 0, GETDATE(), 2, 2, 2, 1);
INSERT INTO [File] (ClientFirstName, ClientLastName, ClientLastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID,  LocationID, SubmittedByUserID)
VALUES ('Burglar', 'Nami', '3615', GETDATE(), 'navigator', 0, GETDATE(), 3, 3, 3, 1);

/****** Object:  Table [dbo].[Request]  ******/
INSERT INTO Request (ClientFirstName, ClientLastName, ClientLastFourSSN, Comment, CommentLastUpdatedDate, IsCancelled, CancelledDate, RequestDate, CheckOutDate, IsPickUpRequested, PickUpRequestDate, CheckedInDate, RequestedByUserID, CheckedOutByUserID, CheckedInByUserID, PriorityID, PurposeID)
VALUES ('Yugi',  'Muto', '4353', '', NULL, 0, NULL, GETDATE(), NULL, 0, NULL, NULL, 1,	0,	0,	1,	2);
INSERT INTO Request (ClientFirstName, ClientLastName, ClientLastFourSSN, Comment, CommentLastUpdatedDate, IsCancelled, CancelledDate, RequestDate, CheckOutDate, IsPickUpRequested, PickUpRequestDate, CheckedInDate, RequestedByUserID, CheckedOutByUserID, CheckedInByUserID, PriorityID, PurposeID)
VALUES ('Seto',  'Kabia', '2345', '', NULL, 0, NULL, GETDATE(), NULL, 0, NULL, NULL, 2,	0,	0,	1,	2);