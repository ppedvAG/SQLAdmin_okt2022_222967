/*

MAXDOP 

Abfragen k�nnen eine oder mehr CPUs verwenden

Wird eine Abfrage schneller fertig sein, wenn mehr CPUs sie verarbeiten?
Normalerweise schon .. macht Sinn!



*/
--Spieltabelle
SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, 
Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderDate, Orders.EmployeeID, Orders.
Freight, Orders.ShipName,Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].
ProductID, [Order Details].UnitPrice, [Order Details].Quantity, 
Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName 
INTO KU 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID 
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID 
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 


insert into KU
select * from ku --6 Sek... im Gegensatz zu 20000 mit Go  20 Sek
--wiederholne bis ca 1,1 Mio DS

--SQL Server liebt Massenoperation

alter table ku add id int identity --dauert

set statistics io, time on


select country, city, SUM(freight) from ku  --62000 Seiten
group by country, city 

-- CPU-Zeit = 374 ms, verstrichene Zeit = 52 ms.
--nur ein Grund daf�r.. mehr CPUs haben was getan.. 
--scheint Sinn gemacht zu haben


select country, city, SUM(freight) from ku  --62000 Seiten
group by country, city  option (maxdop 8)

--Fakt: Am Ende z�hlt der MAXDOP, der n�her an der Abfrage dran ist
-- Server(4)-->DB(6)--Abfrage(8)-- es z�hlt 8


--Was sollte man einstellen: 
-- der Kostenschwellwert sollte bei 25 sein.. und dann experimentieren
--bei Datawarehouse kann die Zahl abweichen

--SQL 2012: 5 und 0 (alle CPUs)

--im Plan Doppelpfeil

--Dass SQL Server paralelisiert m�ssen 2 Bedingungen erf�llt sein
-- Bed 1: wenn der Kostenschwellwert �berschritten wurde: default bei 5
--       dann werden rigoros alle CPUs verwendet

-- Seit SQL 2019 (Setup) wird folgendes vorgeschlagen: alle Prozessoren ,
---aber nicht mehr als 8 

--W�ren nicht weniger besser gewesen?

--Tats�chlich ist es eher pro Abfrage zu entscheiden, was besser ist.
--Fakt: meist kommt man mit weniger CPUs gleich schnell weg und spart 
--zeitgleich CPU Leistung
--Taskmanager sollte eine Reduzierung der Prozesssorzeit zeigen

--Siet SQL 2016 l��t dich der MAXDOP auch pro DB einstellen

USE [master]
GO

GO
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;
GO
