BEGIN TRANSACTION;

DECLARE @FlightID INT = 2;
DECLARE @PassengerID INT = 2;
DECLARE @SeatNumber VARCHAR(10) = '25B';
DECLARE @BookingID INT;
DECLARE @FlightPrice DECIMAL(10,2); 

-- Get the flight price
SELECT @FlightPrice = price FROM Flights WHERE flight_id = @FlightID;

-- Check if seats are available and update
UPDATE Flights
SET available_seats = available_seats - 1
WHERE flight_id = @FlightID AND available_seats > 0;

-- If no rows were updated, rollback
IF @@ROWCOUNT = 0
BEGIN 
    ROLLBACK;
    PRINT 'No available seats, transaction rolled back.';
    RETURN;
END

-- Create a booking
INSERT INTO Bookings (flight_id, passenger_id, seat_number)
VALUES (@FlightID, @PassengerID, @SeatNumber);

-- Get last inserted booking_id
SET @BookingID = SCOPE_IDENTITY();

-- Create a payment for booking using the flight price
INSERT INTO Payments (booking_id, amount, status)
VALUES (@BookingID, @FlightPrice, 'Successful');

-- Update the booking status
UPDATE Bookings SET status = 'Confirmed' WHERE booking_id = @BookingID;

COMMIT;

PRINT 'Booking successful!';
