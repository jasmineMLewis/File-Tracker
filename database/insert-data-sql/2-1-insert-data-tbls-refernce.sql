USE FileTracker;
GO

/****** 
Tables: 5
- Location
- Priority
- PurgeType
- Purpose
- Role
******/

/****** Object:  Table [dbo].[Location]  ******/
INSERT INTO Location (Location) VALUES ('On Site');
INSERT INTO Location (Location) VALUES ('Warehouse');
INSERT INTO Location (Location) VALUES ('Unknown');

/****** Object:  Table [dbo].[Priority]  ******/
INSERT INTO Priority (Priority) VALUES ('High');
INSERT INTO Priority (Priority) VALUES ('Moderate');
INSERT INTO Priority (Priority) VALUES ('Low');

/****** Object:  Table [dbo].[PurgeType]  ******/
INSERT INTO PurgeType (PurgeType) VALUES ('End Of Participation');
INSERT INTO PurgeType (PurgeType) VALUES ('Denial/Withdrawal');
INSERT INTO PurgeType (PurgeType) VALUES ('Port Out');

/****** Object:  Table [dbo].[Purpose]  ******/
INSERT INTO Purpose (Purpose) VALUES ('Finance');
INSERT INTO Purpose (Purpose) VALUES ('Housing Choice Voucher Program');
INSERT INTO Purpose (Purpose) VALUES ('Legal');

/****** Object:  Table [dbo].[Role]  ******/
INSERT INTO Role (Role, Description, Access)
VALUES ('Admin', '', '1) All Project Specialists & Housing Specialists 2) File Requests 2) Create & Edit Users'); 
INSERT INTO Role (Role, Description, Access)
VALUES ('Project Specialist', 'Document & Store Files & Boxes and Distribute and recieve files,  ', '1) Create Files to Purge 2) Create Boxes of Files to Purge 3) Create a File Request 4) Check Out, Request Pick Up and Check In for File Requests'); 
INSERT INTO Role (Role, Description, Access)
VALUES ('Housing Specialist', 'Manage Tenants and Request Files', '1) Create a File Request 2) Check Out, Request Pick Up and Check In for File Requests');
INSERT INTO Role (Role, Description, Access)
VALUES ('File Room Clerk', 'Distribute and recieve files', '1) View File Requests from all Users 2) Export File Requests to Excel');