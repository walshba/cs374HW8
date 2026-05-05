WITH stay_dates AS (
    SELECT generate_series(s.start_date, s.end_date - INTERVAL '1 day', INTERVAL '1 day') AS stay_day,
           s.ID,
           s.ReservationID,
           s.GuestID
    FROM Stay s
    WHERE s.ID = 5
),

room_cost_calc AS (
    SELECT
        sd.ID,
        SUM(rc.Price) AS RoomCost
    FROM stay_dates sd
    JOIN Reservation r ON sd.ReservationID = r.ReservationID
    JOIN ReservationRoom rr ON r.ReservationID = rr.ReservationID
    JOIN Room rm ON rr.RoomNumber = rm.RoomNumber AND rr.HotelID = rm.HotelID
    JOIN RoomType rt ON rm.RoomTypeID = rt.RoomTypeID

    JOIN Season s ON s.HotelID = rm.HotelID
        AND sd.stay_day BETWEEN s.StartDate AND s.EndDate

    JOIN RoomCost rc ON rc.RoomTypeID = rt.RoomTypeID
        AND rc.HotelID = rm.HotelID
        AND rc.SeasonName = s.Name
        AND LOWER(rc.DayOfWeek) = LOWER(TO_CHAR(sd.stay_day, 'Day'))

    GROUP BY sd.ID
),

service_cost AS (
    SELECT srs.StayID, SUM(rs.Cost) AS ServiceCost
    FROM StayRoomService srs
    JOIN RoomService rs ON rs.RoomServiceID = srs.RoomServiceID
    GROUP BY srs.StayID
)

SELECT
    s.start_date,
    s.end_date,
    rt.Size AS RoomType,

    COALESCE(svc.ServiceCost, 0) AS ServiceCost,

    cd.DiscountAmount,
    cd.DiscountType,

    (
        room.RoomCost + COALESCE(svc.ServiceCost, 0)
    ) * (
        1 -
        CASE
            WHEN cd.DiscountAmount > 1 THEN cd.DiscountAmount / 100
            ELSE cd.DiscountAmount
        END
    ) AS TotalCost

FROM Stay s
JOIN room_cost_calc room ON room.ID = s.ID

JOIN Reservation r ON s.ReservationID = r.ReservationID
JOIN ReservationRoom rr ON r.ReservationID = rr.ReservationID
JOIN Room rm ON rr.RoomNumber = rm.RoomNumber AND rr.HotelID = rm.HotelID
JOIN RoomType rt ON rm.RoomTypeID = rt.RoomTypeID

LEFT JOIN service_cost svc ON svc.StayID = s.ID

JOIN Billing b ON b.reservation_id = s.ReservationID
JOIN BillingDiscount bd ON b.bill_id = bd.bill_id
JOIN CategoryDiscount cd ON bd.DiscountID = cd.DiscountID

WHERE s.ID = 5;
