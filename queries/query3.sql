SELECT
    s.start_date,
    s.end_date,
    rt.Size AS RoomType,

    -- extra services
    SUM(rs.Cost) AS ServiceCost,

    -- discount
    cd.DiscountAmount,

    -- final total
    (SUM(rc.Price) + SUM(rs.Cost))
        * (1 - cd.DiscountAmount) AS TotalCost

FROM Stay s
JOIN Reservation r ON s.ReservationID = r.ReservationID
JOIN ReservationRoom rr ON r.ReservationID = rr.ReservationID
JOIN Room rm ON rr.RoomNumber = rm.RoomNumber AND rr.HotelID = rm.HotelID
JOIN RoomType rt ON rm.RoomTypeID = rt.RoomTypeID

-- pricing varies by day of week
JOIN RoomCost rc ON rc.RoomTypeID = rt.RoomTypeID
  AND rc.DayOfWeek IN (
  TO_CHAR(s.start_date, 'Day'),
  TO_CHAR(s.end_date, 'Day')
)

-- extra services
JOIN StayRoomService srs ON s.ID = srs.StayID
LEFT JOIN RoomService rs ON rs.RoomServiceID = srs.RoomServiceID

-- guest + discount
JOIN Guest g ON s.GuestID = g.GID
JOIN Billing b ON r.GuestID  = b.guest_id
JOIN BillingDiscount bd ON b.bill_id = bd.bill_id
JOIN CategoryDiscount cd ON bd.DiscountID = cd.DiscountID

WHERE s.ID = 5
GROUP BY

s.ID, s.start_date, s.end_date, rt.Size, cd.DiscountAmount;

-- Create season
INSERT INTO Season (HotelID, Name, StartDate, EndDate)
VALUES (2, 'Spring', '2026-03-21', '2026-06-21');

-- Add Mr.smith as an occupand
INSERT INTO Guest (GID, GuestCategory)
VALUES (11, 'Platinum');

-- Add Mr.smith as an occupand
INSERT INTO Guest (GID, GuestCategory)
VALUES (11, 'Platinum');

INSERT INTO Reservation (ReservationID, GuestID, HotelID, CheckInDate, CheckOutDate, NumberOfRooms)
VALUES (13, 11, 2, '2026-04-30', '2026-05-02', 1);

-- Create stay
INSERT INTO Stay (ID, ReservationID, GuestID, start_date, end_date, Occupants)
VALUES (5, 13, 11, '2026-04-30', '2026-05-02', 2);

-- Thursday price
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price)
VALUES (2, 2, 'Spring', 'Thursday', 120.00);

-- Friday price
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price)
VALUES (2, 2, 'Spring', 'Friday', 150.00);

-- Create a room service item
WITH next_id AS (
  SELECT COALESCE(MAX(RoomServiceID), 0) + 1 AS id FROM RoomService
)
INSERT INTO RoomService (RoomServiceID, Cost)
SELECT id, 40.00 FROM next_id;

INSERT INTO StayRoomService (StayID, RoomServiceID)
VALUES (5, (SELECT MAX(RoomServiceID) FROM RoomService));

INSERT INTO Billing (bill_id, guest_id)
VALUES (1001, 11);

-- Assign category to guest
UPDATE Guest
SET GuestCategory = 'Platinum'
WHERE GID = 11;

-- Platinum discount
INSERT INTO CategoryDiscount (DiscountID, DiscountType, DiscountAmount)
VALUES (1, 'Platinum', 0.10);  -- 10% discount

INSERT INTO BillingDiscount (bill_id, DiscountID)
VALUES (1001, 1);

-- Check out
UPDATE Stay
SET end_date = '2026-05-02'


WHERE ID = 5;