USE [PSWebMonitor]
GO

INSERT INTO [Group] ([Name], [NotificationList])
VALUES('Product1','person1@company.com,person2@company.com'),
('Product2','distgroup@company.com')
GO

SELECT * FROM [Group]