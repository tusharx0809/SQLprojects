--Stored procedure for booking flight

CREATE PROCEDURE book_flight
    @PassengerID INT,
    @FlightID INT,
    @SeatNumber VARCHAR(10)

AS
BEGIN
    DECLARE @BookingID INT;
    DECLARE @FlightPrice DECIMAL(10, 2);
    DECLARE @AvailableSeats INT,

    BEGIN TRANSACTION;

    --get the flight price and available seats
    SELECT @FlightPrice = price, @AvailableSeats = available_seats
    FROM Flights
    WHERE flight_id = @FlightID


    --check seat availability
    IF @AvailableSeats <= 0
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'No available seats, transaction rolled back';
        RETURN;
    END

    --update available seats
    UPDATE Flights
    SET available_seats = available_seats - 1
    WHERE flight_id =@FlightID;

    --insert booking
    INSERT INTO Bookings(flight_id, passenger_id, seat_number, status)
    VALUES (@FlightID, @PassengerID, @SeatNumber, 'Confirmed');

    --get the last inserted booking id
    SET @BookingID = SCOPE_IDENTITY();

    --insert payment record
    INSERT INTO Payments (booking_id, amount, status, payment_date)
    VALUES (@BookingID, @FlightPrice, 'Successful', GETDATE());

    --commit
    COMMIT TRANSACTION;

    PRINT 'Booking and payment successful!';

END;