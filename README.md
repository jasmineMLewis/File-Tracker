# File Tracker
File Tracker allows staff to maintain accurate record and traction of destroyed or stored boxes and files, and permit users to requests files.

# Table of Contentes
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
https://github.com/jasmineMonquieLewis/File-Tracker


# Introduction
File Tracker is a .NET project for Housing Authority of New Orleans.

### Version
<p>Major.Minor.Patch</p>
<p>Old project from mid 2010s</p>

### Date Last Updated via GitHub
March 11, 2024

### Technologies
| Technology | Version  |
|--|--|
| ADO.NET |  |
| Visual Basic | 6 |
| Bootstrap | |
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
Create: a Request for a File
Check Out: Indication that the user has received the File
Request Pick Up: Indication to File Clerk for Pick Up
Check In: Indication the user has given the File to Clerk

## RoleDashboard
> Dashboard displays genral content per user type.

## User
> Manage users who have access to the system.

#### File Room Clerk
1. View Requests from all Users
2. Export Requests to Excel

#### Housing Specialist
1. Create a Request
2. Check Out, Request Pick Up and Check In for Requests

#### Project Specialist
1. Create Files to be Purge
2. Create Boxes for Files that will be Purged
3. Create a Request
4. Check Out, Request Pick Up and Check In for Requests

#### Administrator
1. All Aforementioned Features
2. Create & Edit User

# Database Composition
## Operational Tables
IN PROGRESS

## Functional 
IN PROGRESS

## Secondary 
IN PROGRESS