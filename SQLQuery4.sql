/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [dep_id]
      ,[name]
      ,[location]
  FROM [databasemid1].[dbo].[department]
