USE [PSWebMonitor]
GO

INSERT INTO [URL] ([URL], [Description], [Group_ID], [StartDate], [LastHealthyCheck])
VALUES ('https://www.website1.com', 'Website 1', '[Product1 Group ID]', getdate(), getdate()),
('https://website2.company.com', 'Website 2', '[Product2 Group ID]', getdate(), getdate()),
('https://www.website1.com/Product2', 'Website 3', '[Product1 Group ID]', getdate(), getdate())

SELECT * FROM [URL]