-- Create payments table

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK(status IN ('Successful','Failed','Pending'))
);