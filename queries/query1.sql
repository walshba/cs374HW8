SELECT rt.RoomTypeID, rt.Size AS room_type, rt.Capacity, COUNT(DISTINCT r.RoomNumber) AS available_rooms, ROUND(AVG(rc.Price * (1 - cd.DiscountAmount / 100)), 2) AS average_cost_per_night
FROM RoomType rt
JOIN Room r ON rt.RoomTypeID = r.RoomTypeID
JOIN Season s ON s.HotelID = rt.HotelID
JOIN RoomCost rc ON rc.RoomTypeID = rt.RoomTypeID
    AND rc.HotelID = rt.HotelID
    AND rc.SeasonName = s.Name
JOIN (
    SELECT DATE '2027-07-15' AS stay_date, 'Thursday' AS day_of_week
    UNION ALL
    SELECT DATE '2027-07-16' AS stay_date, 'Friday' AS day_of_week
) AS nights ON rc.DayOfWeek = nights.day_of_week
    AND nights.stay_date BETWEEN s.StartDate AND s.EndDate
JOIN CategoryDiscount cd ON cd.DiscountType = 'Gold'
WHERE rt.HotelID = 1
AND NOT EXISTS (
    SELECT *
    FROM ReservationRoom rr
    JOIN Reservation res
        ON rr.ReservationID = res.ReservationID
    WHERE rr.HotelID = r.HotelID
    AND rr.RoomNumber = r.RoomNumber
    AND res.CheckInDate < DATE '2027-07-17'
    AND res.CheckOutDate > DATE '2027-07-15'
)
GROUP BY rt.RoomTypeID, rt.Size, rt.Capacity
ORDER BY rt.RoomTypeID;


-- VIP GUEST --
INSERT INTO Guest (
    GID,
    IdentificationType,
    IdentificationNumber,
    Address,
    HomePhoneNumber,
    MobilePhoneNumber,
    DiscountID
)
VALUES (
    100,
    'Drivers License',
    'VA-100',
    'Harrisonburg, VA',
    '540-555-3000',
    '540-555-4000',
    1
);

-- Insert Reservation --
INSERT INTO Reservation (
    ReservationID,
    HotelID,
    GuestID,
    CheckInDate,
    CheckOutDate,
    NumberOfRooms
)
VALUES (
    100,
    1,
    100,
    '2027-07-15',
    '2027-07-17',
    1
);

-- Reserve Room --
INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber)
VALUES (100, 1, 201);