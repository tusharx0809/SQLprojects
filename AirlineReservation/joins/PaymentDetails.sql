--View payment details

SELECT
    b.booking_id,
    b.passenger_id,
    p.amount,
    p.payment_date,
    p.status AS payment_status
FROM 
    bookings b 
JOIN
    Payments p ON b.booking_id = p.booking_id

--Here we can also use WHERE to find the payment details for a booking id
