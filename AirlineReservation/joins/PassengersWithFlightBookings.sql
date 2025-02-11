--Passengers details with flight bookings

SELECT
    p.f_name,
    p.l_name,
    f.airline,
    f.source,
    f.destination,
    f.departure_time,
    b.status,
    b.seat_number
FROM
    Passengers p 
JOIN
    Bookings b ON p.passenger_id = b.passenger_id
JOIN
    Flights f ON b.flight_id = f.flight_id
ORDER BY
    f.departure_time