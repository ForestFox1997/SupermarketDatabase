/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2019 (15.0.4261)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server v160
    Target Database Engine Edition : Unknown
    Target Database Engine Type : Standalone SQL Server
*/

/****** Object:  Database [Supermarket]    Script Date: 25.01.2024 3:32:01 ******/
CREATE DATABASE [Supermarket]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Supermarket', FILENAME = N'/var/opt/mssql/data/Supermarket.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Supermarket_log', FILENAME = N'/var/opt/mssql/data/Supermarket_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Supermarket].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Supermarket] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Supermarket] SET ARITHABORT OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Supermarket] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Supermarket] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Supermarket] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Supermarket] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Supermarket] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Supermarket] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Supermarket] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Supermarket] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Supermarket] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Supermarket] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Supermarket] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Supermarket] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Supermarket] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Supermarket] SET RECOVERY FULL 
GO
ALTER DATABASE [Supermarket] SET  MULTI_USER 
GO
ALTER DATABASE [Supermarket] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Supermarket] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Supermarket] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Supermarket] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Supermarket] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Supermarket] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Supermarket] SET QUERY_STORE = OFF
GO
GRANT VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO [public] AS [dbo]
GO
GRANT VIEW ANY COLUMN MASTER KEY DEFINITION TO [public] AS [dbo]
GO
ALTER DATABASE [Supermarket] SET  READ_WRITE 
GO
USE [Supermarket]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 25.01.2024 3:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsFood] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 25.01.2024 3:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductsByCategories]    Script Date: 25.01.2024 3:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsByCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product] [int] NOT NULL,
	[Category] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllProductsWithCategories]    Script Date: 25.01.2024 3:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Выбрать имена продуктов и имена соответствующих им категорий
-- Выводить имя продукта, даже если у него нет категории

CREATE VIEW AllProductsWithCategories AS
    SELECT Products.Name AS ProductName, Categories.Name AS CategoryName
    FROM Products
    LEFT JOIN ProductsByCategories ON ProductsByCategories.Product = Products.Id
    LEFT JOIN Categories ON ProductsByCategories.Category = Categories.Id
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (1, N'Батончики', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (2, N'Шоколад', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (3, N'Печенье', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (4, N'Чай', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (5, N'Выпечка', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (6, N'Хлеб', 1)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (7, N'Кухонные принадлежности', 0)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (8, N'Посуда', 0)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (9, N'Товары для дома и дачи', 0)
INSERT [dbo].[Categories] ([Id], [Name], [IsFood]) VALUES (10, N'Одежда', 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (1, N'Батончик Snikers', 50.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (2, N'Печенье Oreo', 150.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (3, N'Шоколад Бабаевский', 80.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (4, N'Зефир Воздушный поцелуй', 180.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (5, N'Пирожное Orion Choco-Pie', 150.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (6, N'Шоколад Ritter Sport', 120.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (7, N'Хлеб Деревенский', 30.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (8, N'Чай в пакетиках черный Greenfield Golden Ceylon', 150.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (9, N'Чай в пакетиках черный Ahmad Tea Classic Black Tea', 120.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (10, N'Ножницы кухонные', 200.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (11, N'Ножницы канцелярские', 200.0000)
INSERT [dbo].[Products] ([Id], [Name], [Price]) VALUES (12, N'Книга "Как получить жирный offer"', 1500.0000)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductsByCategories] ON 

INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (2, 1, 1)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (3, 2, 3)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (4, 3, 2)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (5, 4, 5)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (6, 5, 5)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (7, 6, 1)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (8, 6, 2)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (9, 7, 5)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (10, 7, 6)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (11, 8, 4)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (12, 9, 4)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (13, 10, 7)
INSERT [dbo].[ProductsByCategories] ([Id], [Product], [Category]) VALUES (14, 10, 9)
SET IDENTITY_INSERT [dbo].[ProductsByCategories] OFF
GO
ALTER TABLE [dbo].[ProductsByCategories]  WITH CHECK ADD  CONSTRAINT [CategoriesTableForeignKey] FOREIGN KEY([Category])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[ProductsByCategories] CHECK CONSTRAINT [CategoriesTableForeignKey]
GO
ALTER TABLE [dbo].[ProductsByCategories]  WITH CHECK ADD  CONSTRAINT [ProductsTableForeignKey] FOREIGN KEY([Product])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductsByCategories] CHECK CONSTRAINT [ProductsTableForeignKey]
GO
