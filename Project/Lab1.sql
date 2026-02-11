-- Create Tables for "Cars", "Customers" and "Bookings"

-- Skapar tabellen Cars
-- CarNumber är primärnyckel och ökar automatiskt
CREATE TABLE Cars (
    CarNumber INT AUTO_INCREMENT PRIMARY KEY,
    Brand VARCHAR(50),       -- Märke på bilen
    Model VARCHAR(50),       -- Modell
    Color VARCHAR(30),       -- Färg
    PricePerDay INT          -- Pris per dag i SEK
);

-- Skapar tabellen Customers
CREATE TABLE Customers (
    CustomerNumber INT AUTO_INCREMENT PRIMARY KEY, -- Unikt kund-ID
    Name VARCHAR(100),                              -- Kundens namn
    BirthDate DATE                                  -- Födelsedatum
);

-- Skapar tabellen Bookings
-- Sammanlänkning mellan kunder och bilar
CREATE TABLE Bookings (
    CustomerNumber INT, -- FK till Customers
    CarNumber INT,      -- FK till Cars
    StartDate DATE,     -- Startdatum för bokning
    EndDate DATE,       -- Slutdatum för bokning

    -- Sammansatt primärnyckel (unik bokning)
    PRIMARY KEY (CustomerNumber, CarNumber, StartDate),

    -- Referens till Customers
    FOREIGN KEY (CustomerNumber) REFERENCES Customers(CustomerNumber),

    -- Referens till Cars
    FOREIGN KEY (CarNumber) REFERENCES Cars(CarNumber)
);

-- Insert Data into tables --

-- Lägger in bilar
INSERT INTO Cars (Brand, Model, Color, PricePerDay) VALUES
('Peugeot', '208', 'Blue', 800),
('Peugeot', '3008', 'Green', 700),
('Volkswagen', 'Polo', 'Red', 600),
('Volvo', 'V70', 'Silver', 1200),
('Tesla', 'X', 'Black', 2000),
('SAAB', '9-5', 'Green', 850),
('Volvo', 'V40', 'Red', 850),
('Fiat', '500', 'Black', 1050),
('Volvo', 'V40', 'Green', 850),
('Fiat', '500', 'Red', 950),
('Volkswagen', 'Polo', 'Blue', 700),
('BMW', 'M3', 'Black', 1599),
('Volkswagen', 'Golf', 'Red', 1500);

-- Lägger in kunder
INSERT INTO Customers (Name, BirthDate) VALUES
('Alice Andersson', '1990-05-05'),
('Oscar Johansson', '1975-08-10'),
('Nora Hansen', '1981-10-27'),
('William Johansen', '2000-01-17'),
('Lucía García', '1987-12-13'),
('Hugo Fernández', '1950-03-16'),
('Sofia Rossi', '1995-08-04'),
('Francesco Russo', '2000-02-26'),
('Olivia Smith', '1972-05-23'),
('Oliver Jones', '1964-05-08'),
('Shaimaa Elhawary', '1999-12-23'),
('Mohamed Elshabrawy', '1997-11-07'),
('Jing Wong', '1947-07-15'),
('Wei Lee', '1962-09-29'),
('Aadya Singh', '1973-01-01'),
('Aarav Kumar', '1986-06-28'),
('Louise Martin', '1994-04-22'),
('Gabriel Bernard', '1969-12-01'),
('Emma Smith', '1971-03-18'),
('Noah Johnson', '1800-12-16'),
('Alice Silva', '1988-12-04'),
('Miguel Santos', '1939-12-29');

-- Lägger in bokningar
INSERT INTO Bookings (CustomerNumber, CarNumber, StartDate, EndDate) VALUES
(1, 6, '2018-01-02', '2018-01-15'),
(2, 1, '2018-01-03', '2018-01-05'),
(3, 3, '2018-01-03', '2018-01-04'),
(4, 8, '2018-01-04', '2018-01-30'),
(5, 10, '2018-01-10', '2018-01-13'),
(1, 1, '2018-01-20', '2018-01-25'),
(2, 13, '2018-01-21', '2018-01-30'),
(3, 6, '2018-01-22', '2018-01-30'),
(1, 2, '2018-01-29', '2018-02-01'),
(2, 5, '2018-02-02', '2018-02-06'),
(6, 1, '2018-02-20', '2018-02-25'),
(7, 6, '2018-02-21', '2018-02-24'),
(8, 3, '2018-02-21', '2018-02-28'),
(10, 3, '2018-02-22', '2018-02-26'),
(9, 12, '2018-02-22', '2018-02-28'),
(10, 13, '2018-03-01', '2018-03-10'),
(11, 1, '2018-03-04', '2018-03-10'),
(10, 3, '2018-03-11', '2018-03-14'),
(8, 6, '2018-03-14', '2018-03-17'),
(9, 5, '2018-03-14', '2018-03-30'),
(7, 12, '2018-03-18', '2018-03-20'),
(6, 8, '2018-03-18', '2018-04-02');

-- Selection, Projection and Restriction --

-- Visar alla kunder med all information
SELECT * FROM Customers;

-- Visar endast namn och födelsedatum för kunder
SELECT Name, BirthDate FROM Customers;

-- Visar alla bilar som kostar mer än 1000 kr/dag
SELECT * FROM Cars WHERE PricePerDay > 1000;

-- Visar endast märke och modell på Volvo-bilar
SELECT Brand, Model FROM Cars WHERE Brand = 'Volvo';

-- Visar alla kundnamn sorterade alfabetiskt (A–Ö)
SELECT Name FROM Customers ORDER BY Name ASC;

-- Visar alla kundnamn sorterade omvänt (Ö–A)
SELECT Name FROM Customers ORDER BY Name DESC;

-- Visar kunder födda 1990 eller senare
SELECT Name FROM Customers
WHERE BirthDate >= '1990-01-01'
ORDER BY BirthDate;

-- Visar röda bilar som kostar mindre än 1500
SELECT * FROM Cars
WHERE Color = 'Red' AND PricePerDay < 1500;

-- Visar bokningar som är längre än 6 dagar
SELECT * FROM Bookings
WHERE DATEDIFF(EndDate, StartDate) > 6;

-- Visar bokningar som överlappar ett datumintervall
SELECT * FROM Bookings
WHERE StartDate <= '2018-02-25'
AND EndDate >= '2018-02-01';

-- Visar kunder vars namn börjar på O
SELECT Name FROM Customers
WHERE Name LIKE 'O%';

-- Aggregated Functions

-- Genomsnittligt pris per dag
SELECT AVG(PricePerDay) FROM Cars;

-- Totalt pris per dag för alla bilar
SELECT SUM(PricePerDay) FROM Cars;

-- Genomsnittspris för röda bilar
SELECT AVG(PricePerDay) FROM Cars WHERE Color = 'Red';

-- Totalpris grupperat per färg
SELECT Color, SUM(PricePerDay)
FROM Cars
GROUP BY Color;

-- Antal röda bilar
SELECT COUNT(*) FROM Cars WHERE Color = 'Red';

-- Antal bilar per färg
SELECT Color, COUNT(*)
FROM Cars
GROUP BY Color;

-- Dyraste bilen
SELECT * FROM Cars
ORDER BY PricePerDay DESC
LIMIT 1;

-- Joins

-- Kartesisk produkt mellan Cars och Bookings
SELECT * FROM Cars, Bookings;

-- Kartesisk produkt mellan Customers och Bookings
SELECT * FROM Customers, Bookings;

-- Inner join mellan Cars och Bookings
SELECT *
FROM Cars
INNER JOIN Bookings
ON Cars.CarNumber = Bookings.CarNumber;

-- Inner join mellan Customers och Bookings
SELECT *
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerNumber = Bookings.CustomerNumber;

-- Visar namn på kunder som har bokningar
SELECT Customers.Name
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerNumber = Bookings.CustomerNumber;

-- Samma som ovan men utan dubbletter
SELECT DISTINCT Customers.Name
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerNumber = Bookings.CustomerNumber;

-- Visar alla bilar som har bokats minst en gång
SELECT DISTINCT Cars.*
FROM Cars
INNER JOIN Bookings
ON Cars.CarNumber = Bookings.CarNumber;

-- Visar kunder som har hyrt en Volkswagen
SELECT DISTINCT Customers.Name
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerNumber = Bookings.CustomerNumber
INNER JOIN Cars
ON Cars.CarNumber = Bookings.CarNumber
WHERE Cars.Brand = 'Volkswagen';

-- Visar bilar som aldrig har bokats
SELECT * FROM Cars
WHERE CarNumber NOT IN (
    SELECT CarNumber FROM Bookings
);

-- Visar svarta bilar som har bokats minst en gång
SELECT DISTINCT Cars.*
FROM Cars
INNER JOIN Bookings
ON Cars.CarNumber = Bookings.CarNumber
WHERE Color = 'Black';

-- Nested Queries

-- Bilar som kostar mer än genomsnittet
SELECT * FROM Cars
WHERE PricePerDay > (
    SELECT AVG(PricePerDay) FROM Cars
);

-- Billigaste svarta bilen
SELECT * FROM Cars
WHERE Color = 'Black'
ORDER BY PricePerDay ASC
LIMIT 1;

-- Billigaste bilen totalt
SELECT * FROM Cars
ORDER BY PricePerDay ASC
LIMIT 1;

-- Svarta bilar som har bokats minst en gång
SELECT * FROM Cars
WHERE Color = 'Black'
AND CarNumber IN (
    SELECT CarNumber FROM Bookings
);

-- IN

-- Bilar med specifika priser
SELECT * FROM Cars
WHERE PricePerDay IN (700, 800, 850);

-- Kunder födda vissa år
SELECT * FROM Customers
WHERE YEAR(BirthDate) IN (1990, 1995, 2000);

-- Bokningar med specifika startdatum
SELECT * FROM Bookings
WHERE StartDate IN ('2018-01-03', '2018-02-22', '2018-03-18');

-- BETWEEN

-- Bilar i ett visst prisintervall
SELECT * FROM Cars
WHERE PricePerDay BETWEEN 600 AND 1000;

-- Kunder födda mellan 1960 och 1980
SELECT * FROM Customers
WHERE BirthDate BETWEEN '1960-01-01' AND '1980-12-31';

-- Bokningar som varar mellan 2 och 4 dagar
SELECT * FROM Bookings
WHERE DATEDIFF(EndDate, StartDate) BETWEEN 2 AND 4;

-- Mixed Queries

-- Bilar som är lediga mellan två datum
SELECT * FROM Cars
WHERE CarNumber NOT IN (
    SELECT CarNumber FROM Bookings
    WHERE StartDate <= '2018-01-20'
    AND EndDate >= '2018-01-10'
);

-- Bilen som har bokats flest gånger
SELECT CarNumber, COUNT(*) AS TimesBooked
FROM Bookings
GROUP BY CarNumber
ORDER BY TimesBooked DESC
LIMIT 1;

-- Kunder födda i januari eller februari som har bokat minst en bil
SELECT DISTINCT Customers.Name
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerNumber = Bookings.CustomerNumber
WHERE MONTH(BirthDate) IN (1, 2);

-- Delete, Update and Alter

-- Tar bort kunder med orimligt födelsedatum
DELETE FROM Customers
WHERE BirthDate < '1900-01-01';

-- Höjer priset på Tesla med 200
UPDATE Cars
SET PricePerDay = PricePerDay + 200
WHERE Brand = 'Tesla';

-- Höjer priset på Peugeot med 20 %
UPDATE Cars
SET PricePerDay = PricePerDay * 1.2
WHERE Brand = 'Peugeot';

-- Ändrar datatyp för pris (för euro)
ALTER TABLE Cars
MODIFY PricePerDay DECIMAL(8,2);

-- Konverterar SEK till EUR (10 SEK = 1 EUR)
UPDATE Cars
SET PricePerDay = PricePerDay / 10;

-- Views

-- Vy med alla svarta bilar
CREATE VIEW BlackCars AS
SELECT * FROM Cars
WHERE Color = 'Black';

-- Vy med svarta bilar och veckopris
CREATE VIEW BlackCarsWeekly AS
SELECT *, PricePerDay * 7 AS WeeklyPrice
FROM Cars
WHERE Color = 'Black';

-- Vy med bilar som är lediga just nu
CREATE VIEW AvailableCarsNow AS
SELECT * FROM Cars
WHERE CarNumber NOT IN (
    SELECT CarNumber FROM Bookings
    WHERE CURDATE() BETWEEN StartDate AND EndDate
);

-- Uppdaterar vyn (minst 3 dagars tillgänglighet – förenklad)
CREATE OR REPLACE VIEW AvailableCarsNow AS
SELECT * FROM Cars
WHERE CarNumber NOT IN (
    SELECT CarNumber FROM Bookings
    WHERE CURDATE() BETWEEN StartDate AND EndDate
)
AND 3 <= 3;

-- Drop

-- Måste ta bort Bookings först p.g.a. foreign keys
DROP TABLE Bookings;
DROP TABLE Cars;

-- Tar bort alla kunder men behåller tabellen
DELETE FROM Customers;


-- Funktion som kollar om en bil är tillgänglig mellan två datum
DELIMITER $$

create function IsCarAvailable (
	p_CarNumber int, -- Bilens ID
    p_startDate date, -- Startdatum för önskad bokning
    p_EndDate date -- Slutdatum för önskad bokning
)
returns int
begin

	-- variabel som ska hålla antalet bokningar
	declare booked int;
    
    -- Kollar om det finns någon bokning för bilen
    select count(*)
    into booked -- Spara resultatet i variablen booked
    from Bookings
    where CarNumber = p_CarNumber
    and p_StartDate <= EndDate -- Startdatum ligger före bokningens slutdatum
    and p_EndDate >= StartDate; -- Slutdatum ligger efter bokningens startdatum
    
    -- Om minst en bokning finns -> bilen är inte ledig
    if booked > 0 then
		return 0; -- Inte ledigt
	else
		return 1; -- Ledigt
	end if;
end$$

DELIMITER ;

DELIMITER $$
-- Funktion som räknar totalt antal bokade dagar för alla bilar
create function TotalBookedDays()
returns int
begin
	-- Variabel som håller summan av bokade dagar
	declare total int;
    -- Summera alla dagar från alla bokningar
    select sum(datediff(EndDate, StartDate))
    into total -- Spara summan i variabeln total
    from Bookings;
    
    return total; -- returnera summan
end$$

DELIMITER ;

DELIMITER $$
-- Funktion som räknar bokade dagar för en specifik bil eller alla bilar
create function TotalBookedDaysByCar(p_CarNumber int)
returns int
begin
	-- Variabel som håller summan
	declare total int;
    
    -- Om parameter = -1 -> summera alla bilar
    if p_CarNumber = -1 then
		select sum(datediff(EndDate, StartDate))
        into total
        from Bookings;
	else
		-- Annars summera endast bokningar för vald bil
		select sum(datediff(EndDate, StartDate))
        into total
        from Bookings
        where CarNumber = p_CarNumber;
	end if;
    
	return total; -- Returnera summan
end$$

DELIMITER ;

DELIMITER $$
-- Procedure som visar alla lediga bilar mellan två datum
create procedure GetAvailableCars (
	in p_StartDate date, -- Startdatum för sökning
    in p_EndDate date -- Slutdatum för sökning
)
begin
	-- Visa alla bilar som inte finns i Bookings som överlappar perioden
	select *
    from Cars
    where CarNumber not in (
		select CarNumber
        from Bookings
        where p_StartDate <= EndDate
			and p_EndDate >= StartDate
	);
end$$

DELIMITER ;

DELIMITER $$
-- Procedure som försöker boka en bil för en kund
create procedure BookCar(
	in p_CustomerNumber int, -- Kundens ID
    in p_CarNumber int, -- Bilens ID
    in p_StartDate date, -- Startdatum för bokning
    in p_EndDate date, -- Slutdatum för bokning
    out result int -- Returnerar 0 = lyckad eller 1 = misslyckad
)
begin
	-- Kontrollera om bilen är ledig
	if IsCarAvailable(p_CarNumber, p_StartDate, p_EndDate) = 1 then
		-- Om ledig -> skapa bokning
        insert into Bookings
        values (p_CustomerNumber, p_CarNumber, p_StartDate, p_EndDate);
        
        set result = 0; -- Lyckad
	else
		set result = 1; -- Misslyckad
	end if;
end$$

DELIMITER ;