-- (A) Mrs. Smith — Guest has no name column, so her name lives in Occupant
INSERT INTO Guest (GID, IdentificationType, IdentificationNumber, Address,
                   HomePhoneNumber, MobilePhoneNumber, DiscountID) VALUES
  (11, 'Drivers License', 'VA-11', 'Charlottesville, VA',
   '434-555-1011', '434-555-2011', NULL);

INSERT INTO Occupant (GuestID, Name) VALUES
  (11, 'Mrs. Smith');

-- Her reservation at Hotel 2 for a Double, checking in today.
-- Deliberately NO ReservationRoom row — the clerk picks the specific room at check-in.
INSERT INTO Reservation (ReservationID, HotelID, GuestID,
                         CheckInDate, CheckOutDate, NumberOfRooms) VALUES
  (13, 2, 11, '2026-04-30', '2026-05-02', 1);

-- (B) Someone else currently occupying Double 201 so the SELECT must filter it out
INSERT INTO Reservation (ReservationID, HotelID, GuestID,
                         CheckInDate, CheckOutDate, NumberOfRooms) VALUES
  (14, 2, 6, '2026-04-29', '2026-05-01', 1);

INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber) VALUES
  (14, 2, 201);

INSERT INTO Stay (ID, ReservationID, GuestID, start_date, end_date, Occupants) VALUES
  (4, 14, 6, '2026-04-29', '2026-05-01', 1);

INSERT INTO StayRoom (StayID, HotelID, RoomNumber) VALUES
  (4, 2, 201);