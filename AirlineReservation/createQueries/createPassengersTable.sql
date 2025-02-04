-- Create passengers table

CREATE TABLE Passengers (
    passenger_id INT IDENTITY(1,1) PRIMARY KEY,
    f_name varchar(25),
    l_name varchar(25),
    email varchar(100) UNIQUE,
    phone varchar(15),
    passport_number VARCHAR(20) UNIQUE
);