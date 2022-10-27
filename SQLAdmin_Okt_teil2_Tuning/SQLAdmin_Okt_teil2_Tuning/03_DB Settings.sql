/*
mdf ldf  Trenne die Daten von Log pro DB pyhsikalisch

Initialgr��e der DB
			Daten     Log   Wachstumsrate
SQL 2014      5        2     Daten: 1 MB  Log: 10%    
SQL 2016      8        8     Daten: 64 MB  Log: 64 MB

--fast alle Werte sind  unsinnig
--korrekter w�re: mach die DB so gro� , wie sie in 3 Jahren sein wird
--evtl messen mit Perfmon SQL Server:Datenbanken Gr��e der Dateien 1*t�glich

--BACKUP? ist nicht von der Gr��e betroffen, sondern vom Inhalt



*/


create database KursDB

use KursDB


create table t1 (id int identity, spx char(4100));

insert into t1
select 'XY'
GO 20000 --dauert..30 Sekunden

--Wie gro� ist die Tabelle: 4kb * 20000 = 80 MB

--Statt erwart 80 nun 160 MB Daten???

--Bericht Datentr�gerverwendung
--es sollten keine h�ufigen vergr��erungen stattfinden
--schon gar nicht im Sekundebereich...

create table t2 (id int identity, spx char(4100));

insert into t2
select 'XY'
GO 20000


--CRM

--Felder sehr breite Tabelle: Hobby1, Hobby2, Fax1 , Fax2, Fax3, Frau1, Frau2, Frau3, Frau4, Religion







