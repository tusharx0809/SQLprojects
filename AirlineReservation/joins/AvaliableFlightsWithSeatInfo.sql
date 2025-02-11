--View available flights with seat information

SELECT
    f.flight_id,
    f.airline,
    f.source,
    f.destination,
    f.departure_time,
    f.arrival_time,
    f.price,
    (f.total_seats - COUNT(b.booking_id)) AS available_seats
FROM
    Flights f
LEFT JOIN
    Bookings b ON f.flight_id = b.flight_id
GROUP BY
    f.flight_id, f.airline, f.source, f.destination, f.departure_time, f.arrival_time, f.price, f.total_seats
HAVING
    (f.total_seats - COUNT(b.booking_id)) > 0;