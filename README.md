# File Tracker
File Tracker allows staff to maintain accurate record and traction of destroyed or stored boxes and files, and permit users to requests files.

# Table of Contents
1. [General Information](#general-information)
2. [Introduction](#introduction)
3. [Application Composition](#application-composition)
4. [Database Composition](#database-composition)
 
# General Information
### Industry
Housing

### Project Type
Storage & File Requests

### Project Link
N/A

### Project GitHub
https://github.com/jasmineMLewis/File-Tracker


# Introduction
File Tracker is a .NET project for Housing Authority of New Orleans.

### Version
<p>Major.Minor.Patch</p>
<p>Old project from late 2010s (2018 - 2019)</p>

### Date Last Updated via GitHub
June 5, 2024

### Technologies
| Technology | Version  |
|--|--|
| ADO.NET |  |
| Visual Basic | 6 |
| Bootstrap | 5.2.3 |
| Font Awesome |  |
| JQuery | 3.7.0 |


# Application Composition
File Tracker's modules are Box, File, Request, RoleDashboard and User.
1. [Box](#box)
2. [File](#file)
3. [Request](#request)
4. [RoleDashboard](#roleDashboard)
5. [User](#user)
 
## Box
> Maintain count and traction for location of files in boxes.
Create: Boxes for Purging

## File
> Maintain accurate record of destroyed files.
Create: Files for Purging

## Request
> Solicit files needed for clients and inspection.
1. Create: A Request for a File
2. Check Out: Indication that the user has received the File
3. Request Pick Up: Indication to File Clerk for Pick Up
4. Check In: Indication the user has given the File to Clerk

## RoleDashboard
> Dashboard displays genral content per user type.

## User
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
## Operational Tables
1. Boxes
2. Files
3. Requests
4. Users

## Functional 
IN PROGRESS

## Secondary 
1. Location
2. PurgeType
3. Roles