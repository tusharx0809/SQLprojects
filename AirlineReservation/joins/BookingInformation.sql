--Booking information (Flight Details + Passengers Info)

SELECT
    b.booking_id,
    b.seat_number,
    b.status AS booking_status,
    f.airline,
    f.source,
    f.destination,
    f.departure_time,
    f.arrival_time,
    p.f_name,
    p.l_name,
    p.email
FROM 
    Bookings b 
JOIN
    Flights f ON b.flight_id = f.flight_id
JOIN
    Passengers p on b.passenger_id = p.passenger_id
