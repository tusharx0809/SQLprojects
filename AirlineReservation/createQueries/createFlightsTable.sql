-- Create table for flights

CREATE TABLE Flights (
    flight_id INT IDENTITY(1,1) PRIMARY KEY,
    airline varchar(100),
    source varchar(100),
    destination varchar(100),
    departure_time DATETIME,
    arrival_time DATETIME,
    total_seats INT,
    available_seats INT,
    price DECIMAL(10, 2),
);