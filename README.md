# File Tracker
----

# Table of Contents

1. [General Information](#general-information)
2. [Introduction](#introduction)
3. [Installation](#installation)
4. [Application Details](#application-details)
5. [Database Composition](#database-composition)
 
# General Information
---

## Company 
Housing Authority of New Orleans

### Industry
Housing

### Project Type
Storage Tracking & File Requests

## Project Description
File Tracker allows staff to maintain accurate record and traction of destroyed or stored boxes and files, 
and permit users to requests files.

### Project Link
N/A

### Project GitHub
https://github.com/jasmineMLewis/File-Tracker


# Introduction
----
File Tracker is a .NET project for Housing Authority of New Orleans.

### Version
<p>Major.Minor.Patch</p>
<p>Old project from late 2010s (2018 - 2019)</p>

### Date Last Updated via GitHub
June 21, 2024

### Technologies
| Technology | Version  |
|--|--|
| ASP.NET Web Application (.NET Framework) | 4.7.2 |
| Visual Basic |  |
| Bootstrap | 5.2.3 |
| Font Awesome | 6.3.0 |
| JQuery | 5.2.3 |


# Installation
----

## Install Applications
1. Download MicroSoft (MS) SQL Server Managment Studio
2. Download MicroSoft (MS) Visual Studio 2022

## Install Database
Within the File-Tracker folder, navigate to database folder, and open the following folders:
1. create-tbls-sql
2. insert-data-sql

### Create Tables
Execute database files in SQL Server Managment Studio within 'create-tbls-sql' folder:
1. ./database/create-tbls-sql/1-1-file-traker-create-tbls-permanent.sql
2. ./database/create-tbls-sql/1-2-file-traker-create-tbls-refernce.sql

### Insert Data
Execute database files in SQL Server Managment Studio within 'insert-data-sql' folder:
1. ./database/insert-data-sql/2-1-insert-data-tbls-permanent.sql
1. ./database/insert-data-sql/2-2-insert-data-tbls-refernce.sql

## Run Application
1. Open FileTracker project folder (contains FileTracker.sln) in MS Visual Studio 2022
2. After the application is open in Visual Studio, press IIS Express on the top tool bar


# Application Details
----
File Tracker's folders are Box, File, Request, RoleDashboard and User.
1. [Box](#box)
2. [File](#file)
3. [Request](#request)
4. [RoleDashboard](#roleDashboard)
5. [User](#user)
 
## Box
> Maintain count and traction for location of files in boxes.
#### Create
1. Boxes for Purging

## File
> Maintain accurate record of destroyed files.
#### Create
1. Files for Purging

## Request
> Solicit files needed for clients and inspection.
#### Create
1. Request for a File

#### Check Out
1. Indication that the user has received the File

#### Request Pick Up
1. Indication to File Clerk for Pick Up

#### Check In
1. Indication the user has given the File to Clerk

## RoleDashboard
> Dashboard displays genral content per user type.

## Users
> Manage users who have access to the system.

#### File Room Clerk
1. View File Requests from all Users
2. Export File Requests to Excel

#### Housing Specialist
1. Create a File Request
2. Check Out, Request Pick Up and Check In for File Requests

#### Project Specialist
1. Create Files to Purge
2. Create Boxes of Files to Purge
3. Create a File Request
4. Check Out, Request Pick Up and Check In for File Requests

#### Administrator
1. All Aforementioned Features
2. Create & Edit User

# Database Composition
----
## Permanent Tables
> Permanent Tables, always stored in the database, have their own table structure, columns, data types, constraints and indexes.
1. Boxes
2. Files
3. Requests
4. Users

## Refernce Tables
> Refernce Tables share identical fields/column data in another table.
1. Location
2. PurgeType
3. Roles