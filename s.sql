/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [dep_id]
      ,[name]
      ,[location]
  FROM [dat
  abasemid1].[dbo].[department]
  SELECT DISTINCT name, location
FROM department;
SELECT COUNT(DISTINCT name,location) FROM department;