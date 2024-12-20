CREATE DATABASE ExemploWebApiDB;

--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogsXmlRecebido](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[XML] [varchar](max) NULL,
	[DtHrRecebido] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[LogsXmlRecebido] ADD  CONSTRAINT [PK_LogsXmlRecebido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LogsXmlRecebido] ADD  CONSTRAINT [DEFAULT_LogsXmlRecebido_DtHrRecebido]  DEFAULT (getdate()) FOR [DtHrRecebido]
GO

-- #########################################################

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSalvarXML]
    @XmlConteudo NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Exemplo de inserção em uma tabela
    INSERT INTO LogsXmlRecebido (XML)
    VALUES (@XmlConteudo);
END
GO

-- #########################################################

select * from LogsXmlRecebido

--exec spSalvarXML 'teste'
