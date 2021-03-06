
/*----------------------------------------------------------------------
-- 版权：2009,深圳市网狐科技有限公司
-- 时间：2009-04-10
-- 作者：guoshulang@foxmail.com
--
-- 用途：卡表结构
-- 返回值:
----------------------------------------------------------------------*/

use QPTreasureDB
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GameCardNoInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[GameCardNoInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GameCardTmpInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[GameCardTmpInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GameCardTypeInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[GameCardTypeInfo]
GO

CREATE TABLE [dbo].[GameCardNoInfo] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[CardNo] [varchar] (31) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardPass] [varchar] (32) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardTypeID] [int] NOT NULL ,
	[BatchNo] [int] NOT NULL ,
	[Nullity] [bit] NOT NULL ,
	[CreateDate] [datetime] NOT NULL ,
	[UseDate] [datetime] NULL ,
	[UserID] [int] NOT NULL ,
	[Accounts] [varchar] (31) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[GameCardTmpInfo] (
	[CardNo] [varchar] (31) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardPassword] [varchar] (31) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CardTypeID] [int] NOT NULL ,
	[Memo] [varchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[GameCardTypeInfo] (
	[CardID] [int] IDENTITY (1, 1) NOT NULL ,
	[CardTitle] [varchar] (64) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Score] [int] NOT NULL ,
	[Memo] [varchar] (128) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[OverDate] [int] NOT NULL ,
	[IsPresent] [bit] NOT NULL ,
	[MemberOrder] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[GameCardNoInfo] WITH NOCHECK ADD 
	CONSTRAINT [PK_GameCardNoInfo_CardNo] PRIMARY KEY  CLUSTERED 
	(
		[ID],
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[GameCardTmpInfo] WITH NOCHECK ADD 
	CONSTRAINT [PK_GameCardTmpInfo] PRIMARY KEY  CLUSTERED 
	(
		[CardNo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[GameCardTypeInfo] WITH NOCHECK ADD 
	CONSTRAINT [PK_GameCardInfo_CardID] PRIMARY KEY  CLUSTERED 
	(
		[CardID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[GameCardNoInfo] ADD 
	CONSTRAINT [DF_GameCardNoInfo_BatchNo] DEFAULT (0) FOR [BatchNo],
	CONSTRAINT [DF_GameCardInfo_Nullity] DEFAULT (0) FOR [Nullity],
	CONSTRAINT [DF_GameCardInfo_CreateDate] DEFAULT (getdate()) FOR [CreateDate],
	CONSTRAINT [DF_GameCardNoInfo_UserID] DEFAULT (0) FOR [UserID],
	CONSTRAINT [DF_GameCardNoInfo_Accounts] DEFAULT ('') FOR [Accounts]
GO

 CREATE  INDEX [IX_GameCardNoInfo_CardNo] ON [dbo].[GameCardNoInfo]([CardNo]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_GameCardNoInfo_CardPassword] ON [dbo].[GameCardNoInfo]([CardPass]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_GameCardNoInfo_ID] ON [dbo].[GameCardNoInfo]([ID]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[GameCardTmpInfo] ADD 
	CONSTRAINT [DF_GameCardTmpInfo_CardID] DEFAULT (0) FOR [CardTypeID],
	CONSTRAINT [DF_GameCardTmpInfo_Memo] DEFAULT ('') FOR [Memo]
GO

 CREATE  INDEX [IX_GameCardTmpInfo_CardNo] ON [dbo].[GameCardTmpInfo]([CardNo]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[GameCardTypeInfo] ADD 
	CONSTRAINT [DF_GameCardInfo_Score] DEFAULT (0) FOR [Score],
	CONSTRAINT [DF_GameCardInfo_Memo] DEFAULT ('') FOR [Memo],
	CONSTRAINT [DF_GameCardTypeInfo_OverDate] DEFAULT (0) FOR [OverDate],
	CONSTRAINT [DF_GameCardTypeInfo_IsPresent] DEFAULT (0) FOR [IsPresent],
	CONSTRAINT [DF_GameCardTypeInfo_MemberOrder] DEFAULT (0) FOR [MemberOrder]
GO

 CREATE  INDEX [IX_GameCardInfo_CardID] ON [dbo].[GameCardTypeInfo]([CardID]) ON [PRIMARY]
GO


exec sp_addextendedproperty N'MS_Description', N'充入用户帐号', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'Accounts'
GO
exec sp_addextendedproperty N'MS_Description', N'生成批次', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'BatchNo'
GO
exec sp_addextendedproperty N'MS_Description', N'卡号', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'CardNo'
GO
exec sp_addextendedproperty N'MS_Description', N'卡密', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'CardPass'
GO
exec sp_addextendedproperty N'MS_Description', N'卡种类', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'CardTypeID'
GO
exec sp_addextendedproperty N'MS_Description', N'生成日期', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'CreateDate'
GO
exec sp_addextendedproperty N'MS_Description', N'编号 ID', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'ID'
GO
exec sp_addextendedproperty N'MS_Description', N'有效标识', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'Nullity'
GO
exec sp_addextendedproperty N'MS_Description', N'充值日期', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'UseDate'
GO
exec sp_addextendedproperty N'MS_Description', N'充入用户标识', N'user', N'dbo', N'table', N'GameCardNoInfo', N'column', N'UserID'


GO


exec sp_addextendedproperty N'MS_Description', N'卡类型', N'user', N'dbo', N'table', N'GameCardTmpInfo', N'column', N'CardTypeID'
GO
exec sp_addextendedproperty N'MS_Description', N'详细说明', N'user', N'dbo', N'table', N'GameCardTmpInfo', N'column', N'Memo'


GO


exec sp_addextendedproperty N'MS_Description', N'赠卡标识', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'CardID'
GO
exec sp_addextendedproperty N'MS_Description', N'赠卡名称', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'CardTitle'
GO
exec sp_addextendedproperty N'MS_Description', N'赠送会员', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'IsPresent'
GO
exec sp_addextendedproperty N'MS_Description', N'会员级别', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'MemberOrder'
GO
exec sp_addextendedproperty N'MS_Description', N'备注说明', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'Memo'
GO
exec sp_addextendedproperty N'MS_Description', N'会员天数', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'OverDate'
GO
exec sp_addextendedproperty N'MS_Description', N'赠送金币量', N'user', N'dbo', N'table', N'GameCardTypeInfo', N'column', N'Score'


GO

