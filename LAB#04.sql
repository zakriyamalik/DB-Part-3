create database dblab4;
use dblab4;
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)


INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]

--(1)
select count(*) as Users, cardTypeID as Type from card
group by cardTypeID;

--(2)

Select name,Card.cardNum From [User] join usercard 
on [User].userId=usercard.userId join
card on userCard.cardNum=Card.cardNum
where Card.balance between 20000 and 40000;

--(3)

--(a)

select name from [User] where userId IN (Select userId from [User]
except
select userID from UserCard
);

--(b)

select name from [User] left join
UserCard on [User].userId=UserCard.userID
where UserCard.userID is null ;

--(5)

select cardTypeID , count(card.cardNum) , sum(balance)
from Card join
[Transaction] on card.cardNum=[Transaction].cardNum
where transDate between '2015-01-01' and '2017-12-1'
group by cardTypeID
having sum(balance)>35000 

--(6)

select [user].userid,[user].name,[user].phonenum,[user].city,CardType.name,CardType.cardTypeID from [user] join
UserCard on [user].userid=[usercard].userid join
card on [usercard].cardNum=[card].cardNum join
CardType on card.cardTypeID=cardtype.cardTypeID
where expireDate between GETDATE() AND DATEADD(month, 3, GETDATE());

--(7)
Show the user id and name of those users whose total balance
is equal to or greater than 5000.It is possible that a user has
more than 1 card. In such a case, you will have to take sum of
balance of each card of the user.


select distinct balance, [user].userid, [user].name from [user] join
UserCard on [user].userid=[usercard].userid join
card on [usercard].cardNum=[card].cardNum 
group by [user].userid,[user].name,balance
having sum(balance) >= 5000

--(8)

--Show those card pairs which are expiring in the same year.
select c1.cardnum from card as c1 join
card as c2 on year(c1.expireDate)=year(c2.expireDate)
where c1.cardNum < c2.cardNum

--(9)

select u1.name from [user] as u1 join
[user] as u2 on SUBSTRING(u1.name, 1, 1)=SUBSTRING(u2.name, 1, 1)
WHERE u1.userId < u2.userId

--(10)

(select [User].userId, [User].name
from  [User] join UserCard on [User].userId = UserCard.userId join
[Card] on UserCard.cardNum = [Card].cardNum
where [Card].cardTypeId = 1)
INTERSECT
(select [User].userId, [User].name
from  [User] join UserCard on [User].userId = UserCard.userId join
[Card] on UserCard.cardNum = [Card].cardNum
where [Card].cardTypeId = 2)

--(11)

(select [User].city, count(*) as NumOfUsers,sum([Card].balance) as totalBalance
from [User] join [UserCard] on [User].userId = [UserCard].userID join
[Card] on [UserCard].cardNum = [Card].cardNum
group by [User].city)