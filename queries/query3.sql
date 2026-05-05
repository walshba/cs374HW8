TRUNCATE TABLE
    StayRoomService,
    RoomService,
    BillingDiscount,
    Billing,
    StayRoom,
    Stay,
    ReservationRoom,
    Reservation,
    Occupant,
    CategoryDiscount,
    RoomCost,
    Season,
    Guest
RESTART IDENTITY CASCADE;

INSERT INTO CategoryDiscount (DiscountID, DiscountType, discountkind, DiscountAmount)
VALUES (1, 'Platinum', 'PERCENT', 0.10);

-- Guest (Mrs. Smith)
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
    11,
    'Drivers License',
    'VA-101',
    'Harrisonburg, VA',
    '540-555-3001',
    '540-555-4001',
    1
);

-- Reservation
INSERT INTO Reservation (ReservationID, GuestID, HotelID, CheckInDate, CheckOutDate, NumberOfRooms)
VALUES (13, 11, 2, '2026-04-30', '2026-05-02', 1);

-- Assign room to reservation
INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber)
VALUES (13, 2, 202);

INSERT INTO Stay (ID, ReservationID, GuestID, start_date, end_date, Occupants)
VALUES (5, 13, 11, '2026-04-30', '2026-05-02', 2);

-- Occupant
INSERT INTO Occupant (GuestID, Name)
VALUES (11, 'Mr. Smith');

-- Link room to stay
INSERT INTO StayRoom (StayID, HotelID, RoomNumber)
VALUES (5, 2, 202);

-- Season
INSERT INTO Season (HotelID, Name, StartDate, EndDate)
VALUES (2, 'Spring', '2026-03-21', '2026-06-21');

INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price)
VALUES
(4, 2, 'Spring', 'Thursday', 120.00),
(4, 2, 'Spring', 'Friday', 150.00);

WITH next_id AS (
  SELECT COALESCE(MAX(RoomServiceID), 0) + 1 AS id FROM RoomService
)
INSERT INTO RoomService (RoomServiceID, Cost)
SELECT id, 40.00 FROM next_id;

-- Link to stay
INSERT INTO StayRoomService (StayID, RoomServiceID)
VALUES (5, (SELECT MAX(RoomServiceID) FROM RoomService));

INSERT INTO Billing (
    bill_id,
    reservation_id,
    guest_id,
    hotel_id,
    total_amount,
    start_date,
    end_date
)
VALUES (
    1001,
    13,
    11,
    2,
	0.0,
    '2026-04-30',
    '2026-05-02'
);

INSERT INTO BillingDiscount (bill_id, DiscountID)
VALUES (1001, 1);

UPDATE Stay
SET end_date = '2026-05-02'
WHERE ID = 5;

SELECT
    s.start_date,
    s.end_date,
    rt.Size AS RoomType,

    -- extra services
    COALESCE(svc.ServiceCost, 0) AS ServiceCost,

    -- discount
    cd.DiscountAmount,
	cd.DiscountType,

    -- final total
    (room.RoomCost + COALESCE(svc.ServiceCost, 0))
        * (1 - cd.DiscountAmount) AS TotalCost

FROM Stay s
JOIN Reservation r ON s.ReservationID = r.ReservationID
JOIN ReservationRoom rr ON r.ReservationID = rr.ReservationID
JOIN Room rm ON rr.RoomNumber = rm.RoomNumber AND rr.HotelID = rm.HotelID
JOIN RoomType rt ON rm.RoomTypeID = rt.RoomTypeID

-- pricing varies by day of week
JOIN (
    SELECT rc.RoomTypeID, rc.HotelID, SUM(rc.Price) AS RoomCost
    FROM RoomCost rc
    WHERE LOWER(rc.DayOfWeek) IN ('thursday','friday')
    GROUP BY rc.RoomTypeID, rc.HotelID
) room ON room.RoomTypeID = rt.RoomTypeID AND room.HotelID = rm.HotelID

-- extra services
LEFT JOIN (
    SELECT srs.StayID, SUM(rs.Cost) AS ServiceCost
    FROM StayRoomService srs
    JOIN RoomService rs ON rs.RoomServiceID = srs.RoomServiceID
    GROUP BY srs.StayID
) svc
ON svc.StayID = s.ID

-- guest + discount
JOIN Guest g ON s.GuestID = g.GID
JOIN Billing b ON r.ReservationID = b.reservation_id
JOIN BillingDiscount bd ON b.bill_id = bd.bill_id
JOIN CategoryDiscount cd ON bd.DiscountID = cd.DiscountID

WHERE s.ID = 5
GROUP BY

s.ID, s.start_date, s.end_date, rt.Size, room.roomcost, svc.ServiceCost, cd.DiscountAmount, cd.DiscountType;
