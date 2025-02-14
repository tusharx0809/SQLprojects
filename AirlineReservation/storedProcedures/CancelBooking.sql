--Stored procedure to cancel a flight

CREATE PROCEDURE cancel_flight
    @BookingID INT
AS
BEGIN
    DECLARE @FlightID INT;

    BEGIN TRANSACTION
        IF NOT EXISTS(SELECT 1 FROM BOOKINGS WHERE booking_id = @BookingID)
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'No Such booking!';
            RETURN;
        END
        --get the FlightID before updating the booking status
        SELECT @FlightID = flight_id FROM Bookings WHERE booking_id = @BookingID;

        UPDATE Bookings 
        SET status= 'Cancelled'
        WHERE booking_id = @BookingID

        -- Ensure the update was successful
        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'Error updating booking status!';
            RETURN;
        END;

        --Update number of seats after cancellation
        UPDATE Flights
        SET available_seats = available_seats + 1
        WHERE flight_id = @FlightID;

        -- Ensure the update was successful
        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'Error updating available seats!';
            RETURN;
        END;

        COMMIT TRANSACTION;

        PRINT 'Booking Cancelled'
END;


