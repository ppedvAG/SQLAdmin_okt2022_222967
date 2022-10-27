--Dateigruppe

create table test(id int) on HOT--kursdb2.ndf


--Dateigruppen sind ein Alias f�r den Ort, wo SQL Server
--weiter Datendateien abgelegt 

--wie k�nnen wir Tabellen verschieben von einer DGruppe (PIRMARY)
--auf eine andere DGruppe

--�ber Entwurfsansicht kann man das machen, aber Vorsicht--> Beziehungen..
--alle Tabellen werden gesperrt

--per default ist die PRIMARY Dateigruppe (=mdf) standard


--Vorsicht: beim Verschieben einer Tabellen von DGr zu Dgr
--wird im SSMS die Tabelle interim gel�scht

--Trick. W�rde man einen CLUSTERED IX anlegen und diesen auf
--eine andere Dateigruppe legen, w�re dies nicht mit einem L�schen verbunden
--Den CL IX k�nnte man anschliessend auch wieder l�schen..

--einfachste Form um auf HDD Performance zu bringen


