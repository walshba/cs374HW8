--Our Schema doesn't store the Reserver's Name --
SELECT 'Reserved By' AS person_type, CAST(s.GuestID AS VARCHAR) AS person, sr.HotelID, sr.RoomNumber
FROM Stay s
JOIN StayRoom sr ON s.ID = sr.StayID
WHERE sr.HotelID = 2
AND sr.RoomNumber = 201
AND DATE '2025-07-11' >= s.start_date
AND DATE '2025-07-11' < s.end_date

UNION ALL

SELECT 'Occupant' AS person_type, o.Name AS person, sr.HotelID, sr.RoomNumber
FROM Stay s
JOIN StayRoom sr ON s.ID = sr.StayID
JOIN Occupant o ON s.GuestID = o.GuestID
WHERE sr.HotelID = 2
AND sr.RoomNumber = 201
AND DATE '2025-07-11' >= s.start_date
AND DATE '2025-07-11' < s.end_date

ORDER BY person_type, person;