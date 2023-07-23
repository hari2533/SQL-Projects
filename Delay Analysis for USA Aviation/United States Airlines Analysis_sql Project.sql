/* Question No1:- Determine the number of flights that are delayed on various days of the week */

-- First calling the database to import the data.
-- create database job_readiness;
USE job_readiness;
-- Import the data set to perform further operation.
SELECT * FROM airline;
SELECT * FROM airports;
SELECT * FROM runways;

SELECT 
    DayOfWeek, 
    COUNT(Flight) AS delayed_flights_count, 
    Delay 
FROM 
    airline 
WHERE 
    Delay = 1 
GROUP BY 
    DayOfWeek, Delay;

/* Question No2:- Determine the number of delayed flights for various airlines */

SELECT 
    Airline, 
    COUNT(Flight) AS delayed_flights_count 
FROM 
    airline 
WHERE 
    Delay = 1 
GROUP BY 
    Airline;

/* Question No3:- Determine how many delayed flights land at airports with at least 10 runways */

SELECT 
    AirportTo, 
    Flight, 
    Delay 
FROM 
    airline 
WHERE 
    Delay = 1 
GROUP BY 
    AirportTo, Flight, Delay;

/* Question No4:- Compare the number of delayed flights at airports higher than average elevation and 
those that are lower than average elevation for both source and destination airports */

-- Lets first compare for the source airport
SELECT 
    l.AirportFrom, 
    COUNT(l.Flight) AS delayed_flights_count, 
    AVG(p.elevation_ft) AS average_departure_elevation
FROM 
    airline AS l
    INNER JOIN airports AS p ON p.iata_code = l.AirportFrom
WHERE 
    p.elevation_ft > 1037.25 
    AND l.Delay = 1
GROUP BY 
    l.AirportFrom, p.elevation_ft;

SELECT 
    l.AirportFrom, 
    COUNT(l.Flight) AS delayed_flights_count, 
    AVG(p.elevation_ft) AS average_departure_elevation
FROM 
    airline AS l
    INNER JOIN airports AS p ON p.iata_code = l.AirportFrom
WHERE 
    p.elevation_ft < 1037.25 
    AND l.Delay = 1
GROUP BY 
    l.AirportFrom, p.elevation_ft;

-- Lets now compare for the destination airport
SELECT 
    l.AirportTo, 
    COUNT(l.Flight) AS delayed_flights_count, 
    AVG(p.elevation_ft) AS average_destination_elevation, 
    p.elevation_ft AS destination_elevation
FROM 
    airline AS l
    INNER JOIN airports AS p ON p.iata_code = l.AirportTo
WHERE 
    p.elevation_ft > 1037.25 
    AND l.Delay = 1
GROUP BY 
    l.AirportTo, p.elevation_ft;


SELECT 
    l.AirportTo, 
    COUNT(l.Flight) AS delayed_flights_count, 
    AVG(p.elevation_ft) AS average_destination_elevation, 
    p.elevation_ft AS destination_elevation
FROM 
    airline AS l
    INNER JOIN airports AS p ON p.iata_code = l.AirportTo
WHERE 
    p.elevation_ft < 1037.25 
    AND l.Delay = 1
GROUP BY 
    l.AirportTo, p.elevation_ft;