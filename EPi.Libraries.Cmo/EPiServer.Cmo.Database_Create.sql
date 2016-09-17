
GO

GO
PRINT N'Creating [dbo].[CMO_Setting]...';


GO
CREATE TABLE [dbo].[CMO_Setting] (
    [Name]  NVARCHAR (50)  NOT NULL,
    [Value] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_CMO_Setting] PRIMARY KEY CLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_ReferrerUrl]...';


GO
CREATE TABLE [dbo].[CMO_ReferrerUrl] (
    [ID]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [Url] NVARCHAR (450) NOT NULL,
    CONSTRAINT [PK_CMO_ReferrerUrl] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_ReferrerUrl].[IX_CMO_ReferrerUrl]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMO_ReferrerUrl]
    ON [dbo].[CMO_ReferrerUrl]([Url] ASC);


GO
PRINT N'Creating [dbo].[CMO_LpoTestPageData]...';


GO
CREATE TABLE [dbo].[CMO_LpoTestPageData] (
    [TestPageID] INT   NOT NULL,
    [Preview]    IMAGE NULL,
    CONSTRAINT [PK_CMO_LpoTestPageData] PRIMARY KEY CLUSTERED ([TestPageID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_LpoTestPage]...';


GO
CREATE TABLE [dbo].[CMO_LpoTestPage] (
    [ID]           INT            IDENTITY (1, 1) NOT NULL,
    [TestID]       INT            NOT NULL,
    [Reference]    NVARCHAR (255) NOT NULL,
    [IsEnabled]    BIT            NOT NULL,
    [Name]         NVARCHAR (255) NOT NULL,
    [Role]         CHAR (3)       NOT NULL,
    [ModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_CMO_LpoTestPage] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_LpoTest]...';


GO
CREATE TABLE [dbo].[CMO_LpoTest] (
    [ID]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [State]             CHAR (3)       NOT NULL,
    [VisitorPercentage] DECIMAL (3)    NOT NULL,
    [LanguageID]        NVARCHAR (17)  NULL,
    [StartDate]         DATETIME       NULL,
    [EndDate]           DATETIME       NULL,
    [LastModifiedDate]  DATETIME       NOT NULL,
    [LastModifiedBy]    NVARCHAR (50)  NULL,
    [WinnerPageID]      INT            NULL,
    [Owner]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_CMO_LpoTest] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_LpoPageView]...';


GO
CREATE TABLE [dbo].[CMO_LpoPageView] (
    [TestPageID] INT NOT NULL,
    [ViewCount]  INT NOT NULL,
    CONSTRAINT [PK_CMO_LpoPageView] PRIMARY KEY CLUSTERED ([TestPageID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_LpoConversionPageView]...';


GO
CREATE TABLE [dbo].[CMO_LpoConversionPageView] (
    [TestPageID] INT NOT NULL,
    [ViewCount]  INT NOT NULL,
    CONSTRAINT [PK_CMO_LpoConversionPageView] PRIMARY KEY CLUSTERED ([TestPageID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserStatisticEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMUserStatisticEntry] (
    [EntryID]     BIGINT NOT NULL,
    [UserID]      BIGINT NOT NULL,
    [IsNew]       BIT    NULL,
    [IsReturning] BIT    NULL,
    CONSTRAINT [PK_CMO_CMUserStatisticEntry_1] PRIMARY KEY CLUSTERED ([EntryID] ASC, [UserID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserStatisticCampaignEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMUserStatisticCampaignEntry] (
    [EntryID]     BIGINT NOT NULL,
    [UserID]      BIGINT NOT NULL,
    [IsNew]       BIT    NULL,
    [IsReturning] BIT    NULL,
    CONSTRAINT [PK_CMO_CMUserStatisticCampaignEntry] PRIMARY KEY CLUSTERED ([EntryID] ASC, [UserID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUsers]...';


GO
CREATE TABLE [dbo].[CMO_CMUsers] (
    [ID]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [UserID]    UNIQUEIDENTIFIER NOT NULL,
    [BrowserID] INT              NULL,
    [CityID]    INT              NULL,
    CONSTRAINT [PK_CMO_CMUsers] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserPageFirstViewDate]...';


GO
CREATE TABLE [dbo].[CMO_CMUserPageFirstViewDate] (
    [UserID]        BIGINT   NOT NULL,
    [PageID]        INT      NOT NULL,
    [FirstViewDate] DATETIME NULL,
    CONSTRAINT [PK_CMO_CMUserPageFirstViewDate] PRIMARY KEY CLUSTERED ([UserID] ASC, [PageID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserConversionPathStatisticEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMUserConversionPathStatisticEntry] (
    [EntryID]     BIGINT NOT NULL,
    [UserID]      BIGINT NOT NULL,
    [IsNew]       BIT    NULL,
    [IsReturning] BIT    NULL,
    CONSTRAINT [PK_CMO_CMUserConversionPathStatisticEntry] PRIMARY KEY CLUSTERED ([EntryID] ASC, [UserID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserConversionPathFirstViewDate]...';


GO
CREATE TABLE [dbo].[CMO_CMUserConversionPathFirstViewDate] (
    [UserID]           BIGINT   NOT NULL,
    [ConversionPathID] INT      NOT NULL,
    [FirstVisitDate]   DATETIME NULL,
    CONSTRAINT [PK_CMO_CMUserConversionPathFirstViewDate] PRIMARY KEY CLUSTERED ([UserID] ASC, [ConversionPathID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMUserCampaignFirstLastViewDate]...';


GO
CREATE TABLE [dbo].[CMO_CMUserCampaignFirstLastViewDate] (
    [UserID]         BIGINT   NOT NULL,
    [CampaignID]     INT      NOT NULL,
    [FirstVisitDate] DATETIME NULL,
    CONSTRAINT [PK_CMO_CMUserFirstLastViewDate] PRIMARY KEY CLUSTERED ([UserID] ASC, [CampaignID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMRegion]...';


GO
CREATE TABLE [dbo].[CMO_CMRegion] (
    [ID]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (50) NOT NULL,
    [CountryID] INT           NOT NULL,
    CONSTRAINT [PK_CMO_CMRegion] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMPageKpiCountEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMPageKpiCountEntry] (
    [ID]    INT      IDENTITY (1, 1) NOT NULL,
    [KpiID] INT      NOT NULL,
    [Date]  DATETIME NOT NULL,
    [Count] INT      NOT NULL,
    CONSTRAINT [PK_CMO_CMPageKpiValueEntry] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMPageKpi]...';


GO
CREATE TABLE [dbo].[CMO_CMPageKpi] (
    [ID]            INT             IDENTITY (1, 1) NOT NULL,
    [PageID]        INT             NULL,
    [CampaignID]    INT             NULL,
    [KpiType]       CHAR (3)        NOT NULL,
    [Name]          NVARCHAR (255)  NOT NULL,
    [Value]         DECIMAL (18, 2) NOT NULL,
    [ExpectedValue] DECIMAL (18, 2) NOT NULL,
    [KpiParameter]  NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_CMO_CMPageKpi] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMPageData]...';


GO
CREATE TABLE [dbo].[CMO_CMPageData] (
    [CMPageID] INT   NOT NULL,
    [Preview]  IMAGE NULL,
    CONSTRAINT [PK_CMO_CMPageData] PRIMARY KEY CLUSTERED ([CMPageID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMPage]...';


GO
CREATE TABLE [dbo].[CMO_CMPage] (
    [ID]           INT              IDENTITY (1, 1) NOT NULL,
    [CampaignID]   INT              NOT NULL,
    [Reference]    NVARCHAR (255)   NOT NULL,
    [PageGuid]     UNIQUEIDENTIFIER NOT NULL,
    [Name]         NVARCHAR (255)   NOT NULL,
    [DeletedDate]  DATETIME         NULL,
    [ModifiedDate] DATETIME         NULL,
    CONSTRAINT [PK_CMO_CMPage] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMLogEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMLogEntry] (
    [ID]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [PageID]         INT              NOT NULL,
    [Date]           DATETIME         NOT NULL,
    [RequestIP]      NCHAR (50)       NULL,
    [RefererUrl]     NVARCHAR (MAX)   NULL,
    [UserAgent]      NVARCHAR (MAX)   NULL,
    [UserID]         UNIQUEIDENTIFIER NULL,
    [EventType]      CHAR (3)         NULL,
    [BrowserName]    NVARCHAR (MAX)   NULL,
    [BrowserVersion] NVARCHAR (50)    NULL,
    [CurrentUrl]     NVARCHAR (MAX)   NULL,
    CONSTRAINT [PK_CMO_CMLog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMGeneralStatisticEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMGeneralStatisticEntry] (
    [ID]                 BIGINT   IDENTITY (1, 1) NOT NULL,
    [AggregationCounter] BIGINT   NULL,
    [PageID]             INT      NOT NULL,
    [Date]               DATETIME NOT NULL,
    [NewVisitors]        INT      NULL,
    [ViewsCount]         INT      NULL,
    [ViewsCountDuration] INT      NULL,
    [ViewsDuration]      INT      NULL,
    [IsTemp]             BIT      NOT NULL,
    CONSTRAINT [PK_CMO_CMGeneralStatisticEntry] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMGeneralStatisticEntry].[CMO_CMGeneralStatisticEntry_Date_PageID]...';


GO
CREATE NONCLUSTERED INDEX [CMO_CMGeneralStatisticEntry_Date_PageID]
    ON [dbo].[CMO_CMGeneralStatisticEntry]([PageID] ASC, [Date] ASC)
    INCLUDE([ViewsCount]);


GO
PRINT N'Creating [dbo].[CMO_CMGeneralStatisticCampaignEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMGeneralStatisticCampaignEntry] (
    [ID]                         BIGINT   IDENTITY (1, 1) NOT NULL,
    [AggregationCounter]         BIGINT   NULL,
    [CampaignID]                 INT      NOT NULL,
    [Date]                       DATETIME NOT NULL,
    [VisitCount]                 INT      NULL,
    [NewVisitors]                INT      NULL,
    [VisitDuration]              INT      NULL,
    [VisitDurationCountedNumber] INT      NULL,
    [IsTemp]                     BIT      NOT NULL,
    CONSTRAINT [PK_CMO_CMGeneralStatisticCampaignEntry] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMGeneralStatisticCampaignEntry].[CMO_CMGeneralStatisticCampaignEntry_Date_CampaignID]...';


GO
CREATE NONCLUSTERED INDEX [CMO_CMGeneralStatisticCampaignEntry_Date_CampaignID]
    ON [dbo].[CMO_CMGeneralStatisticCampaignEntry]([CampaignID] ASC, [Date] ASC)
    INCLUDE([VisitCount]);


GO
PRINT N'Creating [dbo].[CMO_CMCountry]...';


GO
CREATE TABLE [dbo].[CMO_CMCountry] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CMO_CMCountry] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMConversionPathStatisticEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMConversionPathStatisticEntry] (
    [ID]                         BIGINT   IDENTITY (1, 1) NOT NULL,
    [AggregationCounter]         BIGINT   NULL,
    [ConversionPathID]           INT      NOT NULL,
    [Date]                       DATETIME NOT NULL,
    [VisitCount]                 INT      NULL,
    [VisitDuration]              INT      NULL,
    [VisitDurationCountedNumber] INT      NULL,
    [IsTemp]                     BIT      NOT NULL,
    CONSTRAINT [PK_CMO_CMConversionPathStatisticEntry_1] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMConversionPathPageStatisticEntry]...';


GO
CREATE TABLE [dbo].[CMO_CMConversionPathPageStatisticEntry] (
    [ID]                  BIGINT   IDENTITY (1, 1) NOT NULL,
    [AggregationCounter]  BIGINT   NULL,
    [PathPageID]          INT      NOT NULL,
    [Date]                DATETIME NOT NULL,
    [ViewsCount]          INT      NOT NULL,
    [DirectCount]         INT      NOT NULL,
    [ExternalExitsCount]  INT      NOT NULL,
    [ExternalEntersCount] INT      NOT NULL,
    [IsTemp]              BIT      NOT NULL,
    CONSTRAINT [PK_CMO_CMConversionPathStatisticEntry] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMConversionPathPageReferrer]...';


GO
CREATE TABLE [dbo].[CMO_CMConversionPathPageReferrer] (
    [EntryID]    BIGINT NOT NULL,
    [ReferrerID] BIGINT NOT NULL,
    [EnterCount] INT    NULL,
    [ExitCount]  INT    NULL,
    CONSTRAINT [PK_CMO_CMConversionPathPageReferrer] PRIMARY KEY CLUSTERED ([EntryID] ASC, [ReferrerID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMConversionPathPage]...';


GO
CREATE TABLE [dbo].[CMO_CMConversionPathPage] (
    [ID]               INT IDENTITY (1, 1) NOT NULL,
    [PageID]           INT NOT NULL,
    [ConversionPathID] INT NOT NULL,
    [PagePosition]     INT NOT NULL,
    CONSTRAINT [PK_CMO_CMConversionPathPage] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UK_CMO_CMConversionPathPage] UNIQUE NONCLUSTERED ([ConversionPathID] ASC, [PagePosition] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMConversionPath]...';


GO
CREATE TABLE [dbo].[CMO_CMConversionPath] (
    [ID]         INT            IDENTITY (1, 1) NOT NULL,
    [CampaignID] INT            NOT NULL,
    [Name]       NVARCHAR (255) NOT NULL,
    CONSTRAINT [PK_CMO_CMConversionPath] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMCampaign]...';


GO
CREATE TABLE [dbo].[CMO_CMCampaign] (
    [ID]               INT            IDENTITY (1, 1) NOT NULL,
    [Name]             NVARCHAR (255) NOT NULL,
    [State]            CHAR (3)       NOT NULL,
    [LanguageID]       NVARCHAR (17)  NULL,
    [StartDate]        DATETIME       NULL,
    [EndDate]          DATETIME       NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [Owner]            NVARCHAR (255) NULL,
    [LastModifiedDate] DATETIME       NOT NULL,
    [LastModifiedBy]   NVARCHAR (50)  NULL,
    [KpiEntityType]    VARCHAR (3)    NULL,
    [DeletedDate]      DATETIME       NULL,
    CONSTRAINT [PK_CMO_CMCampaign] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMCity]...';


GO
CREATE TABLE [dbo].[CMO_CMCity] (
    [ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (50) NOT NULL,
    [RegionID] INT           NOT NULL,
    CONSTRAINT [PK_CMO_CMCity] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[CMO_CMBrowser]...';


GO
CREATE TABLE [dbo].[CMO_CMBrowser] (
    [ID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (255) NOT NULL,
    [Version] NVARCHAR (50)  NULL,
    CONSTRAINT [PK_CMO_CMBrowser] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating DF_CMO_LpoPageView_Count...';


GO
ALTER TABLE [dbo].[CMO_LpoPageView]
    ADD CONSTRAINT [DF_CMO_LpoPageView_Count] DEFAULT ((0)) FOR [ViewCount];


GO
PRINT N'Creating DF_CMO_LpoConversionPageView_Count...';


GO
ALTER TABLE [dbo].[CMO_LpoConversionPageView]
    ADD CONSTRAINT [DF_CMO_LpoConversionPageView_Count] DEFAULT ((0)) FOR [ViewCount];


GO
PRINT N'Creating DF_CMO_CMUserStatisticEntry_IsReturning...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticEntry]
    ADD CONSTRAINT [DF_CMO_CMUserStatisticEntry_IsReturning] DEFAULT ((0)) FOR [IsReturning];


GO
PRINT N'Creating DF_CMO_CMUserStatisticEntry_IsNew...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticEntry]
    ADD CONSTRAINT [DF_CMO_CMUserStatisticEntry_IsNew] DEFAULT ((0)) FOR [IsNew];


GO
PRINT N'Creating DF_CMO_CMUserStatisticCampaignEntry_IsReturning...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticCampaignEntry]
    ADD CONSTRAINT [DF_CMO_CMUserStatisticCampaignEntry_IsReturning] DEFAULT ((0)) FOR [IsReturning];


GO
PRINT N'Creating DF_CMO_CMUserStatisticCampaignEntry_IsNew...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticCampaignEntry]
    ADD CONSTRAINT [DF_CMO_CMUserStatisticCampaignEntry_IsNew] DEFAULT ((0)) FOR [IsNew];


GO
PRINT N'Creating DF_CMO_CMUserConversionPathStatisticEntry_IsReturning...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathStatisticEntry]
    ADD CONSTRAINT [DF_CMO_CMUserConversionPathStatisticEntry_IsReturning] DEFAULT ((0)) FOR [IsReturning];


GO
PRINT N'Creating DF_CMO_CMUserConversionPathStatisticEntry_IsNew...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathStatisticEntry]
    ADD CONSTRAINT [DF_CMO_CMUserConversionPathStatisticEntry_IsNew] DEFAULT ((0)) FOR [IsNew];


GO
PRINT N'Creating FK_CMO_LpoTestPageData_CMO_LpoTestPage...';


GO
ALTER TABLE [dbo].[CMO_LpoTestPageData] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_LpoTestPageData_CMO_LpoTestPage] FOREIGN KEY ([TestPageID]) REFERENCES [dbo].[CMO_LpoTestPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_LpoTestPage_CMO_LpoTest...';


GO
ALTER TABLE [dbo].[CMO_LpoTestPage] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_LpoTestPage_CMO_LpoTest] FOREIGN KEY ([TestID]) REFERENCES [dbo].[CMO_LpoTest] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_LpoTest_CMO_LpoTestPage...';


GO
ALTER TABLE [dbo].[CMO_LpoTest] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_LpoTest_CMO_LpoTestPage] FOREIGN KEY ([WinnerPageID]) REFERENCES [dbo].[CMO_LpoTestPage] ([ID]);


GO
PRINT N'Creating FK_CMO_LpoPageView_CMO_LpoTestPage...';


GO
ALTER TABLE [dbo].[CMO_LpoPageView] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_LpoPageView_CMO_LpoTestPage] FOREIGN KEY ([TestPageID]) REFERENCES [dbo].[CMO_LpoTestPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_LpoConversionPageView_CMO_LpoTestPage...';


GO
ALTER TABLE [dbo].[CMO_LpoConversionPageView] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_LpoConversionPageView_CMO_LpoTestPage] FOREIGN KEY ([TestPageID]) REFERENCES [dbo].[CMO_LpoTestPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserStatisticEntry_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserStatisticEntry_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserStatisticEntry_CMO_CMGeneralStatisticEntry...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserStatisticEntry_CMO_CMGeneralStatisticEntry] FOREIGN KEY ([EntryID]) REFERENCES [dbo].[CMO_CMGeneralStatisticEntry] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserStatisticCampaignEntry_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticCampaignEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserStatisticCampaignEntry_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserStatisticCampaignEntry_CMO_CMGeneralStatisticCampaignEntry...';


GO
ALTER TABLE [dbo].[CMO_CMUserStatisticCampaignEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserStatisticCampaignEntry_CMO_CMGeneralStatisticCampaignEntry] FOREIGN KEY ([EntryID]) REFERENCES [dbo].[CMO_CMGeneralStatisticCampaignEntry] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUsers_CMO_CMCity...';


GO
ALTER TABLE [dbo].[CMO_CMUsers] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUsers_CMO_CMCity] FOREIGN KEY ([CityID]) REFERENCES [dbo].[CMO_CMCity] ([ID]);


GO
PRINT N'Creating FK_CMO_CMUsers_CMO_CMBrowser...';


GO
ALTER TABLE [dbo].[CMO_CMUsers] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUsers_CMO_CMBrowser] FOREIGN KEY ([BrowserID]) REFERENCES [dbo].[CMO_CMBrowser] ([ID]);


GO
PRINT N'Creating FK_CMO_CMUserPageFirstViewDate_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserPageFirstViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserPageFirstViewDate_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserPageFirstViewDate_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMUserPageFirstViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserPageFirstViewDate_CMO_CMPage] FOREIGN KEY ([PageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserConversionPathStatisticEntry_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserConversionPathStatisticEntry_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserConversionPathStatisticEntry_CMO_CMConversionPathStatisticEntry...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserConversionPathStatisticEntry_CMO_CMConversionPathStatisticEntry] FOREIGN KEY ([EntryID]) REFERENCES [dbo].[CMO_CMConversionPathStatisticEntry] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserConversionPathFirstViewDate_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathFirstViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserConversionPathFirstViewDate_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserConversionPathFirstViewDate_CMO_CMConversionPath...';


GO
ALTER TABLE [dbo].[CMO_CMUserConversionPathFirstViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserConversionPathFirstViewDate_CMO_CMConversionPath] FOREIGN KEY ([ConversionPathID]) REFERENCES [dbo].[CMO_CMConversionPath] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserFirstLastViewDate_CMO_CMUsers...';


GO
ALTER TABLE [dbo].[CMO_CMUserCampaignFirstLastViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserFirstLastViewDate_CMO_CMUsers] FOREIGN KEY ([UserID]) REFERENCES [dbo].[CMO_CMUsers] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMUserFirstLastViewDate_CMO_CMCampaign...';


GO
ALTER TABLE [dbo].[CMO_CMUserCampaignFirstLastViewDate] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMUserFirstLastViewDate_CMO_CMCampaign] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[CMO_CMCampaign] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMRegion_CMO_CMCountry...';


GO
ALTER TABLE [dbo].[CMO_CMRegion] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMRegion_CMO_CMCountry] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[CMO_CMCountry] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMPageKpiValueEntry_CMO_CMPageKpi...';


GO
ALTER TABLE [dbo].[CMO_CMPageKpiCountEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMPageKpiValueEntry_CMO_CMPageKpi] FOREIGN KEY ([KpiID]) REFERENCES [dbo].[CMO_CMPageKpi] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMPageKpi_CMO_CMCampaign...';


GO
ALTER TABLE [dbo].[CMO_CMPageKpi] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMPageKpi_CMO_CMCampaign] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[CMO_CMCampaign] ([ID]);


GO
PRINT N'Creating FK_CMO_CMPageKpi_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMPageKpi] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMPageKpi_CMO_CMPage] FOREIGN KEY ([PageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMPageData_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMPageData] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMPageData_CMO_CMPage] FOREIGN KEY ([CMPageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMPage_CMO_CMCampaign...';


GO
ALTER TABLE [dbo].[CMO_CMPage] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMPage_CMO_CMCampaign] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[CMO_CMCampaign] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMLog_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMLogEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMLog_CMO_CMPage] FOREIGN KEY ([PageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMGeneralStatisticEntry_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMGeneralStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMGeneralStatisticEntry_CMO_CMPage] FOREIGN KEY ([PageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMGeneralStatisticCampaignEntry_CMO_CMCampaign...';


GO
ALTER TABLE [dbo].[CMO_CMGeneralStatisticCampaignEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMGeneralStatisticCampaignEntry_CMO_CMCampaign] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[CMO_CMCampaign] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPathStatisticEntry_CMO_CMConversionPath...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathStatisticEntry_CMO_CMConversionPath] FOREIGN KEY ([ConversionPathID]) REFERENCES [dbo].[CMO_CMConversionPath] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPathStatisticEntry_CMO_CMConversionPathPage...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPageStatisticEntry] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathStatisticEntry_CMO_CMConversionPathPage] FOREIGN KEY ([PathPageID]) REFERENCES [dbo].[CMO_CMConversionPathPage] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPathPageReferrer_CMO_ReferrerUrl...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPageReferrer] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathPageReferrer_CMO_ReferrerUrl] FOREIGN KEY ([ReferrerID]) REFERENCES [dbo].[CMO_ReferrerUrl] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPathPageReferrer_CMO_CMConversionPathPageStatisticEntry...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPageReferrer] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathPageReferrer_CMO_CMConversionPathPageStatisticEntry] FOREIGN KEY ([EntryID]) REFERENCES [dbo].[CMO_CMConversionPathPageStatisticEntry] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPathPage_CMO_CMPage...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPage] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathPage_CMO_CMPage] FOREIGN KEY ([PageID]) REFERENCES [dbo].[CMO_CMPage] ([ID]);


GO
PRINT N'Creating FK_CMO_CMConversionPathPage_CMO_CMConversionPath...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPage] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPathPage_CMO_CMConversionPath] FOREIGN KEY ([ConversionPathID]) REFERENCES [dbo].[CMO_CMConversionPath] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMConversionPath_CMO_CMCampaign...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPath] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMConversionPath_CMO_CMCampaign] FOREIGN KEY ([CampaignID]) REFERENCES [dbo].[CMO_CMCampaign] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating FK_CMO_CMCity_CMO_CMRegion...';


GO
ALTER TABLE [dbo].[CMO_CMCity] WITH NOCHECK
    ADD CONSTRAINT [FK_CMO_CMCity_CMO_CMRegion] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[CMO_CMRegion] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creating CK_CMO_LpoTestPage_Role...';


GO
ALTER TABLE [dbo].[CMO_LpoTestPage] WITH NOCHECK
    ADD CONSTRAINT [CK_CMO_LpoTestPage_Role] CHECK ([Role]='ORG' OR [Role]='VAR' OR [Role]='CNV');


GO
PRINT N'Creating CK_CMO_LpoTest_State...';


GO
ALTER TABLE [dbo].[CMO_LpoTest] WITH NOCHECK
    ADD CONSTRAINT [CK_CMO_LpoTest_State] CHECK ([State]='NA' OR [State]='RUN' OR [State]='P' OR [State]='FIN');


GO
PRINT N'Creating CK_CMO_CMPageKpi_KpiType...';


GO
ALTER TABLE [dbo].[CMO_CMPageKpi] WITH NOCHECK
    ADD CONSTRAINT [CK_CMO_CMPageKpi_KpiType] CHECK ([KpiType]='PG' OR [KpiType]='FRM' OR [KpiType]='DWN' OR [KpiType]='REF' OR [KpiType]='GEN' OR [KpiType]='CON');


GO
PRINT N'Creating CK_CMO_CMConversionPathPage...';


GO
ALTER TABLE [dbo].[CMO_CMConversionPathPage] WITH NOCHECK
    ADD CONSTRAINT [CK_CMO_CMConversionPathPage] CHECK ([PagePosition]>=(1) AND [PagePosition]<=(4));


GO
PRINT N'Creating [dbo].[CMO_LpoActivePage]...';


GO
CREATE VIEW [dbo].[CMO_LpoActivePage]
AS
SELECT     dbo.CMO_LpoTest.ID AS TestID, dbo.CMO_LpoTestPage.ID AS TestPageID, dbo.CMO_LpoTestPage.Name AS PageName, 
                      dbo.CMO_LpoTestPage.Role, dbo.CMO_LpoTest.VisitorPercentage, dbo.CMO_LpoTest.Name AS TestName,
                      dbo.CMO_LpoTestPage.Reference
FROM         dbo.CMO_LpoTest INNER JOIN
                      dbo.CMO_LpoTestPage ON dbo.CMO_LpoTest.ID = dbo.CMO_LpoTestPage.TestID
WHERE     (dbo.CMO_LpoTest.State = 'RUN') AND (dbo.CMO_LpoTestPage.IsEnabled = 1)
GO
PRINT N'Creating [dbo].[CMO_IncreaseKpiCounter]...';


GO

CREATE PROCEDURE [dbo].[CMO_IncreaseKpiCounter]	
@KpiList varchar(max),
@Date Datetime,
@Value INT
AS
BEGIN
	SET NOCOUNT ON;
	--Create temp table for Kpi list		
	DECLARE @TempList table
	(
		KpiID int		
	)	
		
	DECLARE @KpiID varchar(10), @Pos int
	SET @KpiList = LTRIM(RTRIM(@KpiList))+ ','
	SET @Pos = CHARINDEX(',', @KpiList, 1)

	IF REPLACE(@KpiList, ',', '') <> ''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @KpiID = LTRIM(RTRIM(LEFT(@KpiList, @Pos - 1)))
			IF @KpiID <> ''
			BEGIN
				INSERT INTO @TempList (KpiID) VALUES (CAST(@KpiID AS int)) 
			END
			SET @KpiList = RIGHT(@KpiList, LEN(@KpiList) - @Pos)
			SET @Pos = CHARINDEX(',', @KpiList, 1)
		END
	END		 
	--Update existing Kpi counter entries
	UPDATE TOP (1) CMO_CMPageKpiCountEntry 	
	SET CMO_CMPageKpiCountEntry.Count= (CMO_CMPageKpiCountEntry.Count + @Value)	
	WHERE [KpiID] IN (SELECT KpiID FROM @TempList)	
		AND  [Date] = @Date 		
		
	--Add new Kpi count entries
	INSERT INTO CMO_CMPageKpiCountEntry(KpiID, Date, Count)	
	(SELECT t.KpiID, @Date, @Value FROM @TempList as t
	  INNER JOIN CMO_CMPageKpi as kpi ON  
	  kpi.ID = t.KpiID
	 WHERE 0 = (SELECT count(ID) 
				FROM CMO_CMPageKpiCountEntry as ent 
				WHERE t.KpiID = ent.KpiID AND @Date = ent.Date))
					
END
GO
PRINT N'Creating [dbo].[CMO_IncreasePageView]...';


GO
CREATE PROCEDURE [dbo].[CMO_IncreasePageView]
@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	Update CMO_LpoPageView Set [ViewCount]=[ViewCount]+1 
	Where [TestPageID]= (SELECT TestPageID From CMO_LpoActivePage Where TestPageID=@ID)
END
GO
PRINT N'Creating [dbo].[CMO_IncreaseConversionPageView]...';


GO
CREATE PROCEDURE [dbo].[CMO_IncreaseConversionPageView]
@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	Update CMO_LpoConversionPageView Set [ViewCount]=[ViewCount]+1 
	Where [TestPageID]= (SELECT TestPageID From CMO_LpoActivePage Where TestPageID=@ID)
END
GO
PRINT N'Creating [dbo].[CMO_DeleteUsersOfNotExistedCampaigns]...';


GO
CREATE PROCEDURE [dbo].[CMO_DeleteUsersOfNotExistedCampaigns]
AS
BEGIN
	DELETE FROM CMO_CMUsers WHERE CMO_CMUsers.ID IN
	(
		SELECT CMO_CMUsers.ID FROM CMO_CMUsers
			LEFT JOIN CMO_CMUserCampaignFirstLastViewDate on CMO_CMUsers.ID = CMO_CMUserCampaignFirstLastViewDate.UserID
			LEFT JOIN CMO_CMUserPageFirstViewDate on CMO_CMUsers.ID = CMO_CMUserPageFirstViewDate.UserID
			LEFT JOIN CMO_CMUserStatisticCampaignEntry on CMO_CMUsers.ID = CMO_CMUserStatisticCampaignEntry.UserID
			LEFT JOIN CMO_CMUserStatisticEntry on CMO_CMUsers.ID = CMO_CMUserStatisticEntry.UserID
		WHERE 
			CMO_CMUserCampaignFirstLastViewDate.UserID IS NULL
			AND CMO_CMUserPageFirstViewDate.UserID IS NULL
			AND CMO_CMUserStatisticCampaignEntry.UserID IS NULL
			AND CMO_CMUserStatisticEntry.UserID IS NULL
	)
END
GO
PRINT N'Creating [dbo].[CMO_DeleteTempAggregationResults]...';


GO
CREATE PROCEDURE [dbo].[CMO_DeleteTempAggregationResults]
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM CMO_CMConversionPathStatisticEntry WHERE IsTemp=1
	DELETE FROM CMO_CMConversionPathPageStatisticEntry WHERE IsTemp=1
	
	DELETE FROM CMO_CMGeneralStatisticCampaignEntry WHERE IsTemp=1
	DELETE FROM CMO_CMGeneralStatisticEntry WHERE IsTemp=1

END
GO
PRINT N'Creating [dbo].[CMO_DeleteProcessedLogEntries]...';


GO
CREATE PROCEDURE [dbo].[CMO_DeleteProcessedLogEntries]
@MaxLogDate DATETIME,
@UserGuid UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM CMO_CMLogentry where Date <= @MaxLogDate AND UserID=@UserGuid

END
GO
PRINT N'Creating [dbo].[CMO_DeleteMarkedObjects]...';


GO
CREATE PROCEDURE [dbo].[CMO_DeleteMarkedObjects]

AS
BEGIN
	DELETE FROM CMO_CMCampaign WHERE DeletedDate IS NOT NULL
	DELETE FROM CMO_CMPage WHERE DeletedDate IS NOT NULL
	EXEC CMO_DeleteUsersOfNotExistedCampaigns
END
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a2b92737-633b-441a-adbe-999f9a3c01d7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a2b92737-633b-441a-adbe-999f9a3c01d7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3671b3f0-92e6-43a1-848f-921f95b38470')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3671b3f0-92e6-43a1-848f-921f95b38470')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b7eb3a4b-66c5-4710-a80c-3f3af59b3b15')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b7eb3a4b-66c5-4710-a80c-3f3af59b3b15')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b5e94015-7402-4155-a857-24b6c0574463')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b5e94015-7402-4155-a857-24b6c0574463')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2443d3c1-7d53-4048-8d41-c848b57dbaf0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2443d3c1-7d53-4048-8d41-c848b57dbaf0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '69e3c814-d481-472b-b880-a09eae372367')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('69e3c814-d481-472b-b880-a09eae372367')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '086fee7a-86a7-43fb-b89b-66d837bc9c4b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('086fee7a-86a7-43fb-b89b-66d837bc9c4b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fc4360ac-416f-44ec-92e8-c592f7c07d0e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fc4360ac-416f-44ec-92e8-c592f7c07d0e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6fa05133-73ef-441d-84f7-d3503aff2a84')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6fa05133-73ef-441d-84f7-d3503aff2a84')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1716fd41-1396-4e50-b42a-02c4ce95fdd2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1716fd41-1396-4e50-b42a-02c4ce95fdd2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a22d5f52-c77a-497d-98d9-65835e5441db')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a22d5f52-c77a-497d-98d9-65835e5441db')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b5c1fd2f-d84e-4f75-acf4-ee3998ae274f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b5c1fd2f-d84e-4f75-acf4-ee3998ae274f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a2f58639-bf97-4bc5-bb30-8db99beda07a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a2f58639-bf97-4bc5-bb30-8db99beda07a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f99de02f-a6d5-4267-9177-b8f094484158')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f99de02f-a6d5-4267-9177-b8f094484158')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a25d3a17-bec3-498e-a077-628823c1abad')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a25d3a17-bec3-498e-a077-628823c1abad')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f44dfc11-8af4-4ce9-a774-fa55e370e59e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f44dfc11-8af4-4ce9-a774-fa55e370e59e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '227b27e8-d075-45de-9fe9-9f0c21e55d7c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('227b27e8-d075-45de-9fe9-9f0c21e55d7c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2127ce12-b72c-45e2-9914-5302c9cdc0ac')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2127ce12-b72c-45e2-9914-5302c9cdc0ac')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '588069db-88d8-4b19-852c-1fe92fc62182')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('588069db-88d8-4b19-852c-1fe92fc62182')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6a42f82d-dc25-47bc-a4a7-4e5d25123d00')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6a42f82d-dc25-47bc-a4a7-4e5d25123d00')

GO

GO
DELETE FROM [dbo].[CMO_Setting];
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('aggregationInterval', '10');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('cacheTimeout', '10');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('editorRoles', 'WebAdmins,Administrators');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('minimalConversionsDifference', '5');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('pageViewCountThreshold', '100');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('recentlyPeriod', '10');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('runAggregationOnStart', 'true');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('thumbnailServiceUrl', 'http://');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('defaultThumbnailPath', 'Styles/Resources/snapshot.png');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('thumbnailServiceCmsLogin', '');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('thumbnailServiceCmsCredential', '');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('statisticsHandlerUrl', 'http://');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('epiTraceInjectScriptLevel', '2');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('userNumberToProcessAtOnce', '1000');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('viewerRoles', 'WebEditors');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('waitTimeOnStop', '30');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('visitIdleTime', '30');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('pageVisitIdleTime', '300');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('cookieExpiration', '7');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('CmoDatabaseVersion', '7.5');
GO

INSERT INTO [dbo].[CMO_Setting] VALUES ('CmoDataVersion', '7.5');
GO


