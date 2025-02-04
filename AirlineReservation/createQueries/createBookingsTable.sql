-- Create Bookings Table

CREATE TABLE Bookings (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    flight_id INT REFERENCES Flights(flight_id) ON DELETE CASCADE,
    passenger_id INT REFERENCES Passengers(passenger_id) ON DELETE CASCADE,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    seat_number varchar(5),
    status VARCHAR(20) CHECK (status IN ('Confirmed','Cancelled','Pending'))
);