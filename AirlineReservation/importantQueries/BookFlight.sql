BEGIN TRANSACTION;

--Check if seats are available
UPDATE Flights
SET available_seats = available_seats -1
WHERE flight_id = 1 AND available_seats > 0; 
--Flight 1 is Delta Airlines

IF @@ROWCOUNT = 0
BEGIN 
    ROLLBACK;
    PRINT 'No available seats, transaction rolled back.';
    RETURN;
END

--Create a booking
INSERT INTO Bookings (flight_id, passenger_id, seat_number)
VALUES(1, 1, '12A');

--Get last inserted booking_id
DECLARE @BookingID INT = SCOPE_IDENTITY();

--Create a payment for booking
INSERT INTO Payments(booking_id, amount, status)
VALUES(@BookingID, 5000.00, 'Successfull');

--Update the booking status
UPDATE Bookings SET status ='Confirmed' WHERE booking_id = @BookingID;

COMMIT;