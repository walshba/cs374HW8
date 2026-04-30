WITH params AS (
    SELECT DATE '2025-06-15' AS year_start,
           DATE '2026-06-14' AS year_end
),
-- Guest reservations in the year window.
guest_reservations AS (
    SELECT r.GuestID,
           COUNT(*)                  AS num_reservations,
           COUNT(DISTINCT r.HotelID) AS hotels_reserved
    FROM   Reservation r, params p
    WHERE  r.CheckInDate BETWEEN p.year_start AND p.year_end
    GROUP  BY r.GuestID
),
-- >= 2 reservations across >= 2 hotels.
qualifying_guests AS (
    SELECT GuestID, num_reservations, hotels_reserved
    FROM   guest_reservations
    WHERE  num_reservations >= 2
      AND  hotels_reserved  >= 2
),
-- guest billing in the same window
guest_billing AS (
    SELECT b.guest_id                       AS GuestID,
           COUNT(DISTINCT b.bill_id)        AS num_bills,
           COUNT(DISTINCT b.hotel_id)       AS hotels_billed,
           SUM(b.total_amount)              AS total_spent
    FROM   Billing b, params p
    WHERE  b.start_date BETWEEN p.year_start AND p.year_end
    GROUP  BY b.guest_id
)
SELECT g.GID,
       g.IdentificationType,
       g.IdentificationNumber,
       g.Address,
       qg.num_reservations,
       qg.hotels_reserved,
       COALESCE(gb.total_spent,   0.00) AS total_spent
FROM       Guest g
JOIN       qualifying_guests qg ON qg.GuestID = g.GID
LEFT JOIN  guest_billing     gb ON gb.GuestID = g.GID
ORDER BY   total_spent DESC, g.GID;
