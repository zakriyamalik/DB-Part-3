create database ticketing_system1;
use ticketing_system1
CREATE TABLE dbo.[User] (
    User_id INT PRIMARY KEY,
    Email VARCHAR(255),
    UserName VARCHAR(255),
    Password VARCHAR(255),
    Created_at DATETIME
);
create table passwordchangelog (
    log_id int primary key,
    user_id int,
    changed_at datetime
);
--drop table passwordchangelog;

CREATE TABLE User_Role (
    Role_id INT PRIMARY KEY,
    User_role_id INT,
    Role_name VARCHAR(255),
    FOREIGN KEY (User_role_id) REFERENCES dbo.[User](User_id)
);

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_name VARCHAR(255)
);


CREATE TABLE Ticketing (
    Ticket_id INT PRIMARY KEY,
    User_id INT,
    Status VARCHAR(50),
    Level INT,
    Created_at DATETIME,
    Updated_at DATETIME,
    FOREIGN KEY (User_id) REFERENCES dbo.[User](User_id)
);


CREATE TABLE Ticketing_Attachment (
    Attachment_id INT PRIMARY KEY,
    Ticket_id INT,
    File_name VARCHAR(255),
    File_path VARCHAR(255),
    Mime_type VARCHAR(50),
    Uploaded_by_user_id INT,
    FOREIGN KEY (Ticket_id) REFERENCES Ticketing(Ticket_id)
);

CREATE TABLE Notification (
    Notification_id INT PRIMARY KEY,
    User_id INT,
    Ticket_id INT,
    Notification_type VARCHAR(50),
    Created_at DATETIME,
    FOREIGN KEY (User_id) REFERENCES dbo.[User](User_id),
    FOREIGN KEY (Ticket_id) REFERENCES Ticketing(Ticket_id)
);


CREATE TABLE Report (
    Report_id INT PRIMARY KEY,
    Title VARCHAR(255),
    Description TEXT,
    Created_by_Name INT, 
    Ticket_id INT,
    FOREIGN KEY (Created_by_Name) REFERENCES dbo.[User](User_id),
    FOREIGN KEY (Ticket_id) REFERENCES Ticketing(Ticket_id)
);



insert into dbo.[user]
(user_id, email, username, password, created_at)
values (1, 'user1@example.com', 'User1', 'password1', getdate()),
       (2, 'user2@example.com', 'User2', 'password2', getdate()),
       (3, 'user3@example.com', 'User3', 'password3', getdate());

insert into
user_role (role_id, user_role_id, role_name)
values (1, 1, 'Admin'),
       (2, 2, 'User'),
       (3, 3, 'Support');

insert into
category
(category_id, category_name)
values (1, 'Software'),
       (2, 'Hardware'),
       (3, 'Networking');

insert into ticketing(ticket_id, user_id, status, level, created_at, updated_at)values (1, 1, 'Open', 1, getdate(), getdate()),
       (2, 2, 'Closed', 2, getdate(), getdate()),
       (3, 3, 'Pending', 3, getdate(), getdate());

insert into ticketing_attachment(attachment_id, ticket_id, file_name, file_path, mime_type, uploaded_by_user_id) values (1, 1, 'file1', 'path1', 'pdf', 1),
       (2, 2, 'file2', 'path2', 'jpg', 2),
       (3, 3, 'file3', 'path3', 'doc', 3);

insert into notification(notification_id, user_id, ticket_id, notification_type, created_at) values (1, 1, 1, 'New Ticket', getdate()),
       (2, 2, 2, 'Ticket Closed', getdate()),
       (3, 3, 3, 'Ticket Assigned', getdate());

insert into report (report_id, title, description, created_by_name, ticket_id)values (1, 'Report 1', 'Description 1', 1, 1),
       (2, 'Report 2', 'Description 2', 2, 2),
       (3, 'Report 3', 'Description 3', 3, 3);


------------------------------------------------------1.1-----------------------------------------------------------------------------
-- create user stored procedures
create procedure sp_createuser
(
    @email varchar(255),
    @username varchar(255),
    @password varchar(255),
    @created_at datetime
)
as
begin
    insert into dbo.[user] (email, username, password, created_at)
    values (@email, @username, @password, @created_at);
end;

create procedure sp_loginuser
(
    @email varchar(255),
    @password varchar(255)
)
as
begin
    if exists (select 1 from dbo.[user] where email = @email and password = @password)
    begin
        select 'login successful.' as message;
    end
    else
    begin
        select 'invalid credentials. please try again.' as message;
    end
end;

create procedure sp_updatepassword
(
    @email varchar(255),
    @password varchar(255)
)
as
begin
    update dbo.[user]
    set password = @password
    where email = @email;
end;

create procedure sp_deleteuser
(
    @email varchar(255)
)
as
begin
    delete from dbo.[User]
    where email = @email;
end;

----------------------------------1.2-----------------------------------------------------------------------------------
-- Create PasswordChangeLog table

--1

CREATE TRIGGER UpdatePasswordTrigger
ON dbo.[User]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Password)
    BEGIN
        DECLARE @UserID INT;
        SELECT @UserID = User_id FROM INSERTED;

        -- Log the password change event
        INSERT INTO dbo.passwordchangelog (User_id, Changed_at)
        VALUES (@UserID, GETDATE());
    END;
END;


--2

CREATE TRIGGER DeleteUserTrigger
ON dbo.[User]
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedUserID INT;
    SELECT @DeletedUserID = User_id FROM DELETED;

    -- Remove the user's role assignment
    DELETE FROM User_Role WHERE User_role_id = @DeletedUserID;
END;

---------------------------------------------2.1-----------------------------------------------------------------------------
--1
CREATE PROCEDURE sp_CreateTicket
    @User_id INT,
    @Status VARCHAR(50),
    @Level INT,
    @Created_at DATETIME,
    @Updated_at DATETIME
AS
BEGIN
    INSERT INTO Ticketing (User_id, Status, Level, Created_at, Updated_at)
    VALUES (@User_id, @Status, @Level, @Created_at, @Updated_at);
END;

--2

CREATE PROCEDURE sp_UpdateTicketStatus
    @Ticket_id INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    UPDATE Ticketing
    SET Status = @NewStatus
    WHERE Ticket_id = @Ticket_id;
END;



------------------------------------------------------2.2-----------------------------------------------------------------------
--1

CREATE TRIGGER tr_ticket_before_insert
ON Ticketing AFTER INSERT 
AS BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Status NOT IN ('Open', 'Closed', 'Pending'))
    BEGIN
        RAISERROR ('Status must be either Open, Closed, or Pending', 16, 1);
    END
END;

--2

CREATE TRIGGER tr_notification_before_insert
ON Notification AFTER INSERT 
AS BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Notification_type NOT IN ('Email', 'SMS', 'Push'))
    BEGIN
        RAISERROR ('Notification_type must be either Email, SMS, or Push', 16, 1);
    END
END;

------------------------------------------------------------------3.1--------------------------------------------------------------------------------------------------------------

-- 1
create procedure sp_getticketsbystatus
  @status varchar(50)
as
begin
  select * from ticketing where status = @status;
end;

-- 2
create procedure sp_getticketsbypriority
  @priority int
as
begin
  select * from ticketing where level = @priority;
end;

-- 3
create procedure sp_getticketsbycriteria
  @status varchar(50),
  @priority int
as
begin
  select * from ticketing where status = @status and level = @priority;
end;

---------------------------------------------------------------------------------3.2-------------------------------------------------------------------------------------------










-------------------------------------------------------------------------------4.1--------------------------------------------------------------------------------------------------
--1

CREATE PROCEDURE GetTicketDetails
    @TicketID INT
AS
BEGIN
    SELECT *
    FROM Ticketing
    WHERE Ticket_id = @TicketID;
END;

-----------------------------------------------------------------------------------4.2---------------------------------------------------------------------------------------------------
--2

create trigger tr_logticketview
on ticketing
after update
as
begin
    if update(status) or update(level) or update(updated_at)
    begin
        declare @ticketid int;
        select @ticketid = ticket_id from inserted;

        insert into notification (user_id, ticket_id, notification_type, created_at)
        values ((select user_id from ticketing where ticket_id = @ticketid), @ticketid, 'ticket viewed', getdate());
    end
end;



----------------------------------------------------------------------5.1---------------------------------------------------------------------------------------------------------

--1

CREATE PROCEDURE UpdateTicketDetails
    @TicketID INT,
    @Status VARCHAR(50),
    @Level INT,
    @Description TEXT
AS
BEGIN
    UPDATE Ticketing
    SET Status = COALESCE(@Status, Status),
        Level = COALESCE(@Level, Level),
        Updated_at = GETDATE()
    WHERE Ticket_id = @TicketID;
END;

-----------------------------------------------------------------------------5.2-------------------------------------------------------------------------------------

CREATE TRIGGER TR_LogTicketUpdate
ON Ticketing
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status) OR UPDATE(Level) OR UPDATE(Updated_at)
    BEGIN
        DECLARE @TicketID INT;
        SELECT @TicketID = Ticket_id FROM INSERTED;

        INSERT INTO Notification (User_id, Ticket_id, Notification_type, Created_at)
        VALUES ((SELECT User_id FROM Ticketing WHERE Ticket_id = @TicketID), @TicketID, 'Ticket Updated', GETDATE());
    END
END;

-------------------------------------------------------------------------------6.1-------------------------------------------------------------------------------------------
--1

CREATE PROCEDURE AssignTicket (
    @TicketID INT,
    @UserID INT
)
AS
BEGIN
    UPDATE Ticketing
    SET User_id = @UserID
    WHERE Ticket_id = @TicketID;
END;

-------------------------------------------------------------------------------6.2------------------------------------------------------------------------------------------------

--1

CREATE TRIGGER TR_LogTicketAssignment
ON Ticketing
AFTER UPDATE
AS
BEGIN
    IF UPDATE(User_id)
    BEGIN
        DECLARE @TicketID INT;
        SELECT @TicketID = Ticket_id FROM INSERTED;

        INSERT INTO Notification (User_id, Ticket_id, Notification_type, Created_at)
        VALUES ((SELECT User_id FROM Ticketing WHERE Ticket_id = @TicketID), @TicketID, 'Ticket Assigned', GETDATE());
    END
END;

--------------------------------------------------------------7.1----------------------------------------------------------------------------------------------

CREATE PROCEDURE SearchTickets (
    @Keyword VARCHAR(255),
    @Status VARCHAR(50) = NULL,
    @Level INT = NULL
)
AS
BEGIN
    SELECT *
    FROM Ticketing
    WHERE 
        (Status LIKE '%' + @Keyword + '%' OR Level LIKE '%' + @Keyword + '%' OR CONVERT(VARCHAR(255), Ticket_id) LIKE '%' + @Keyword + '%')
        AND (@Status IS NULL OR Status = @Status) AND (@Level IS NULL OR Level = @Level);
END;

------------------------------------------------------------------7.2--------------------------------------------------------------------------------------------

--No trigger

----------------------------------------------------------------8.1-----------------------------------------------------------------------------------------------

-- 1

CREATE PROCEDURE GetNotificationsForUser (
    @UserID INT
)
AS
BEGIN
    SELECT * FROM Notification WHERE User_id = @UserID;
END;

--2
CREATE PROCEDURE DeleteNotificationsForTicket (
    @TicketID INT
)
AS
BEGIN
    DELETE FROM Notification WHERE Ticket_id = @TicketID;
END;
--------------------------------------------------------------------------------------8.2-------------------------------------------------------------------------------

-- 1
CREATE PROCEDURE AddNotification (
    @UserID INT,
    @TicketID INT,
    @NotificationType VARCHAR(50),
    @Created_at DATETIME
)
AS
BEGIN
    INSERT INTO Notification (User_id, Ticket_id, Notification_type, Created_at)
    VALUES (@UserID, @TicketID, @NotificationType, @Created_at);
END;


-- 2
CREATE TRIGGER TR_DeleteNotificationsOnDelete
ON Ticketing
AFTER DELETE
AS
BEGIN
    DECLARE @TicketID INT;
    SELECT @TicketID = Ticket_id FROM DELETED;

    EXEC DeleteNotificationsForTicket @TicketID;
END;

---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored procedures
exec sp_createuser 'user4@example.com', 'User4', 'password4', '2024-04-16T12:00:00';
exec sp_loginuser 'user1@example.com', 'password1';
exec sp_updatepassword 'user2@example.com', 'newpassword';
exec sp_deleteuser 'user3@example.com';
exec sp_createticket 1, 'Open', 1, '2024-04-16T12:00:00', '2024-04-16T12:00:00';
exec sp_updateticketstatus 1, 'Closed';
exec sp_getticketsbystatus 'Open';
exec sp_getticketsbypriority 2;
exec sp_getticketsbycriteria 'Open', 1;
exec  GetTicketDetails 1;
exec updateticketdetails 1, 'Closed', 2, 'Ticket updated description';
exec assignticket 1, 2;
exec searchtickets 'ticket', 'Open', 1;
exec getnotificationsforuser 1;
exec deletenotificationsforticket 1;
exec addnotification 1, 1, 'Email', '2024-04-16T12:00:00';
update dbo.[User] set password = 'newpassword' where user_id = 1;
delete from dbo.[User] where user_id = 2;
insert into ticketing (ticket_id, user_id, status, level, created_at, updated_at) values (4, 3, 'Open', 1, getdate(), getdate());
update ticketing set status = 'Invalid Status' where ticket_id = 4;
