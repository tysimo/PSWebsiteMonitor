CREATE DATABASE [PSWebsiteMonitor]
GO

USE [PSWebsiteMonitor]
GO

-----------------------------------------

CREATE TABLE [dbo].[URL](
	[ID] [uniqueidentifier] NOT NULL,
	[URL] [varchar](200) NOT NULL,
	[Description] [varchar](200) NULL,
	[Status] [varchar](max) NULL,
	[FailCount] [int] NULL,
	[LastCheck] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[Timeout] [int] NULL,
	[Group_ID] [uniqueidentifier] NULL,
	[StartDate] [datetime] NULL,
	[LogResponseTimes] [bit] NOT NULL,
	[LastHealthyCheck] [datetime] NULL,
 CONSTRAINT [PK_URL] PRIMARY KEY CLUSTERED 
(
	[UrlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_ID]  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_FailCount]  DEFAULT ((0)) FOR [FailCount]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_Timeout]  DEFAULT ((20)) FOR [Timeout]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO

ALTER TABLE [dbo].[URL] ADD  CONSTRAINT [DF_URL_LogResponseTimes]  DEFAULT ((0)) FOR [LogResponseTimes]
GO

---------------------------------------------

CREATE TABLE [dbo].[Group](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](100) NULL,
	[NotificationList] [varchar](max) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Group] ADD  CONSTRAINT [DF_Group_ID]  DEFAULT (newid()) FOR [ID]
GO

---------------------------------------

CREATE TABLE [dbo].[Log](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[ID] [uniqueidentifier] NOT NULL,
	[URL_ID] [uniqueidentifier] NOT NULL,
	[Response] [varchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[FailCount] [int] NULL,
	[ScheduledMaintenanceFlag] [bit] NULL,
	[Notes] [varchar](max) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[LogId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_ID]  DEFAULT (newid()) FOR [ID]
GO
