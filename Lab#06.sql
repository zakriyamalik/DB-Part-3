create database lab#06red
use lab#06red
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
	[Total_Items_Ordered] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date), 30)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date), 5)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date), 20)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date), 15)
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO

--Create a view that gives order number and total price of that
--order where total price is
--equal to item price multiplied by item quantity of that order.
--Q1
create View [Q1]
AS
Select [dbo].OrderDetails.OrderNo,Sum([dbo].[Items].[Price] * [dbo].[Items].[Quantity in Store]) as total_price from OrderDetails join dbo.Items
on dbo.Items.ItemNo=dbo.OrderDetails.ItemNo 
group by  [dbo].OrderDetails.OrderNo

select * from Q1

--Create a view that gives all the items that are doing 
--well in sales. The criteria to judge which item is doing good sale 
--is that the item is has sold more than 20 pieces.

--q3
create view [q2]
as
select dbo.OrderDetails.ItemNo from dbo.OrderDetails where dbo.OrderDetails.Quantity> 20;

select * from q2;

--Create a view that returns star customers. Star customers are the customers 
--that have made a purchase of more than 2000.

--q3

create view [q311]
as
select dbo.[Order].CustomerNo from [Order] join dbo.OrderDetails on
dbo.[Order].OrderNo=dbo.OrderDetails.OrderNo join
dbo.[Items] on dbo.[Items].ItemNo=dbo.[OrderDetails].ItemNo
where dbo.[Order].Total_Items_Ordered * dbo.[Items].Price>2000

select * from q311

--Create a view that returns all the customers that have phone number not 
--null WITHOUT CHECK option.

--q4

CREATE VIEW [q4]
as 
select dbo.[Customers].[CustomerNo],dbo.[Customers].[Name] from dbo.Customers
where dbo.Customers.Phone is not null

select * from q4

--q5

--Create a view WITH CHECK option that returns the all the customers that 
--have not ordered Item C . Also, inserts a new Order that Orders Item 
--B and C (fill out the customer details as per your wish) then he deletes his 
--order of Item C and instead order Item D.Now again run the above mentioned 
--view to observe any changes.
create view [q5]
as
select dbo.[Order].CustomerNo,dbo.[OrderDetails].ItemNo from dbo.[Order] join dbo.[OrderDetails] on 
dbo.[Order].OrderNo=dbo.OrderDetails.OrderNo join
dbo.[Items] on dbo.[Items].ItemNo=dbo.[OrderDetails].ItemNo
group by dbo.[Order].OrderNo,dbo.[Order].CustomerNo,dbo.[OrderDetails].ItemNo
having dbo.[OrderDetails].ItemNo<>300
with check option

select * from q5

INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (4, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 300, 30)

DELETE FROM [dbo].[OrderDetails] WHERE [dbo].[OrderDetails].OrderNo=300;
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (4, 400, 20)

--q6

--Create a stored procedure that takes order number, item number and quantity as input.
--If quantity of that item present in store is less than ordered quantity. Print a message
--‘Only <quantity in store> is present, which is less than your required quantity.’
--If enough quantity is present in store insert the order detail in order details table and
--subtract the ordered quantity from quantity in store, for that ordered item. Write it’s
--execute statement as well.

create procedure q6
@orderNo int ,@itemNo int ,@quantity int
as
begin
if quantity < dbo.[order].total_item_order


