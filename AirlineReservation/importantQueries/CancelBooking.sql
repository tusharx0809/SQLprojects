BEGIN TRANSACTION;

--Mark booking as cancelled

UPDATE Bookings SET status='Cancelled' WHERE booking_id = 1;

--Increase available seats
UPDATE Flights
SET available_seats = available_seats + 1
WHERE flight_id = (SELECT flight_id FROM Bookings WHERE booking_id = 1);


COMMIT;