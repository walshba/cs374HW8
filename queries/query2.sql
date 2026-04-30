SELECT r.HotelID, r.RoomNumber, r.Floor
FROM Room r
JOIN RoomType rt ON r.RoomTypeID = rt.RoomTypeID
WHERE r.HotelID = 2
  AND rt.Size = 'Double'
  AND NOT EXISTS (
    SELECT *
    FROM StayRoom sr
    JOIN Stay s ON sr.StayID = s.ID
    WHERE sr.HotelID    = r.HotelID
      AND sr.RoomNumber = r.RoomNumber
      AND CURRENT_DATE >= s.start_date
      AND CURRENT_DATE <  s.end_date
  )
ORDER BY r.RoomNumber;

-- Add Mr.smith as an occupand
INSERT INTO Occupant (GuestID, Name)
VALUES (11, 'Mr. Smith');

-- Bind reservation 13 to the room the one picked
INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber)
VALUES (13, 2, 202);

-- Open a stay to its now occupied in the system
INSERT INTO Stay (ID, ReservationID, GuestID, start_date, end_date, Occupants)
VALUES (5, 13, 11, '2026-04-30', '2026-05-02', 2);

-- Link the room to the stay
INSERT INTO StayRoom (StayID, HotelID, RoomNumber)
VALUES (5, 2, 202);
