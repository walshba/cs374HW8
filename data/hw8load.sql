-- ---------- Hotels ----------
INSERT INTO Hotels (ID, Name, Address) VALUES
  (1, 'JMU', '123, VA'),
  (2, 'Harrisonburg', '456, VA'),
  (3, 'King Hall', '789, VA'),
  (4, 'Festival', '1011, VA'),
  (5, 'EHll', '1213, VA');
 
-- ---------- Hotel phone numbers ----------
INSERT INTO HotelPhoneNumbers (HotelID, PhoneNumber) VALUES
  (1, '540-555-0101'),
  (2, '540-555-0202'),
  (3, '703-555-0303'),
  (4, '434-555-0404'),
  (5, '757-555-0505');
 
-- ---------- Hotel features ----------
INSERT INTO HotelFeatures (HotelID, Feature) VALUES
  (1, 'Pool'), (1, 'Gym'),
  (2, 'Free Breakfast'),
  (3, 'Pool'), (3, 'Spa'),
  (4, 'Pet Friendly'),
  (5, 'Beach'), (5, 'Pool');
 
INSERT INTO Season (HotelID, Name, StartDate, EndDate) VALUES
  (1, 'Warm', '2025-06-01', '2025-08-31'),
  (1, 'Cold', '2025-11-01', '2026-02-28'),
  (2, 'Warm', '2025-06-15', '2025-09-15'),
  (2, 'Cold', '2025-12-01', '2026-02-28'),
  (3, 'Warm', '2025-05-15', '2025-09-15'),
  (3, 'Cold', '2025-11-15', '2026-03-15'),
  (4, 'Warm', '2025-06-01', '2025-08-31'),
  (4, 'Cold', '2025-12-15', '2026-02-28'),
  (5, 'Warm', '2025-05-01', '2025-09-30'),
  (5, 'Cold', '2025-11-15', '2026-03-01');
 
-- ---------- Category Discounts ----------
INSERT INTO CategoryDiscount (DiscountID, DiscountType, DiscountKind, DiscountAmount) VALUES
  (1, 'Gold', 'PERCENT', 15.00),
  (2, 'Silver', 'PERCENT',  5.00); 
 
-- ---------- Room Types (2 per hotel) ----------
-- Hotel 1
INSERT INTO RoomType (RoomTypeID, HotelID, Size, Capacity) VALUES
  (1, 1, 'Single', 1),
  (2, 1, 'Double', 2),
-- Hotel 2
  (3, 2, 'Single', 1),
  (4, 2, 'Double', 2),
-- Hotel 3
  (5, 3, 'Double', 2),
  (6, 3, 'Suite',  4),
-- Hotel 4
  (7, 4, 'Double', 2),
  (8, 4, 'Suite',  4),
-- Hotel 5
  (9,  5, 'Single', 1),
  (10, 5, 'Suite',  4);
 
-- ---------- Room Type Features ----------
INSERT INTO RoomTypeFeatures (RoomTypeID, Feature) VALUES
  (1, 'WiFi'),
  (2, 'WiFi'), (2, 'Balcony'),
  (3, 'WiFi'),
  (4, 'WiFi'), (4, 'Mini Bar'),
  (5, 'WiFi'), (5, 'Mini Bar'),
  (6, 'WiFi'), (6, 'Kitchen'),
  (7, 'WiFi'),
  (8, 'WiFi'), (8, 'Jacuzzi'), (8, 'Kitchen'),
  (9, 'WiFi'),
  (10,'WiFi'), (10,'Kitchen'), (10,'Ocean Front');
 
-- ---------- Rooms (3 per room type) ----------
-- Single 1, Double 2, Suite 3+
INSERT INTO Room (HotelID, RoomNumber, Floor, RoomTypeID) VALUES
  (1, 101, 1, 1), (1, 102, 1, 1), (1, 103, 1, 1),
  (1, 201, 2, 2), (1, 202, 2, 2), (1, 203, 2, 2),
  (2, 101, 1, 3), (2, 102, 1, 3), (2, 103, 1, 3),
  (2, 201, 2, 4), (2, 202, 2, 4), (2, 203, 2, 4),
  (3, 301, 3, 5), (3, 302, 3, 5), (3, 303, 3, 5),
  (3, 401, 4, 6), (3, 402, 4, 6), (3, 403, 4, 6),
  (4, 201, 2, 7), (4, 202, 2, 7), (4, 203, 2, 7),
  (4, 301, 3, 8), (4, 302, 3, 8), (4, 303, 3, 8),
  (5, 101, 1, 9), (5, 102, 1, 9), (5, 103, 1, 9),
  (5, 501, 5, 10), (5, 502, 5, 10), (5, 503, 5, 10);
 
-- ---------- Room Cost ----------
-- Pricing model (base * season_mult * day_mult):
--   Base by size: Single=80, Double=120, Suite=180
--   Season:  Warm = 1.25x, Cold = 0.90x
--   Day:     Fri/Sat = 1.30x, others = 1.00x
 
-- Hotel 1, RoomType 1 
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (1,1,'Warm','Monday',100.00),(1,1,'Warm','Tuesday',100.00),(1,1,'Warm','Wednesday',100.00),
  (1,1,'Warm','Thursday',100.00),(1,1,'Warm','Friday',130.00),(1,1,'Warm','Saturday',130.00),
  (1,1,'Warm','Sunday',100.00),
  (1,1,'Cold','Monday',72.00),(1,1,'Cold','Tuesday',72.00),(1,1,'Cold','Wednesday',72.00),
  (1,1,'Cold','Thursday',72.00),(1,1,'Cold','Friday',93.60),(1,1,'Cold','Saturday',93.60),
  (1,1,'Cold','Sunday',72.00);
 
-- Hotel 1, RoomType 2 
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (2,1,'Warm','Monday',150.00),(2,1,'Warm','Tuesday',150.00),(2,1,'Warm','Wednesday',150.00),
  (2,1,'Warm','Thursday',150.00),(2,1,'Warm','Friday',195.00),(2,1,'Warm','Saturday',195.00),
  (2,1,'Warm','Sunday',150.00),
  (2,1,'Cold','Monday',108.00),(2,1,'Cold','Tuesday',108.00),(2,1,'Cold','Wednesday',108.00),
  (2,1,'Cold','Thursday',108.00),(2,1,'Cold','Friday',140.40),(2,1,'Cold','Saturday',140.40),
  (2,1,'Cold','Sunday',108.00);
 
-- Hotel 2, RoomType 3 
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (3,2,'Warm','Monday',100.00),(3,2,'Warm','Tuesday',100.00),(3,2,'Warm','Wednesday',100.00),
  (3,2,'Warm','Thursday',100.00),(3,2,'Warm','Friday',130.00),(3,2,'Warm','Saturday',130.00),
  (3,2,'Warm','Sunday',100.00),
  (3,2,'Cold','Monday',72.00),(3,2,'Cold','Tuesday',72.00),(3,2,'Cold','Wednesday',72.00),
  (3,2,'Cold','Thursday',72.00),(3,2,'Cold','Friday',93.60),(3,2,'Cold','Saturday',93.60),
  (3,2,'Cold','Sunday',72.00);
 
-- Hotel 2, RoomType 4
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (4,2,'Warm','Monday',150.00),(4,2,'Warm','Tuesday',150.00),(4,2,'Warm','Wednesday',150.00),
  (4,2,'Warm','Thursday',150.00),(4,2,'Warm','Friday',195.00),(4,2,'Warm','Saturday',195.00),
  (4,2,'Warm','Sunday',150.00),
  (4,2,'Cold','Monday',108.00),(4,2,'Cold','Tuesday',108.00),(4,2,'Cold','Wednesday',108.00),
  (4,2,'Cold','Thursday',108.00),(4,2,'Cold','Friday',140.40),(4,2,'Cold','Saturday',140.40),
  (4,2,'Cold','Sunday',108.00);
 
-- Hotel 3, RoomType 5
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (5,3,'Warm','Monday',150.00),(5,3,'Warm','Tuesday',150.00),(5,3,'Warm','Wednesday',150.00),
  (5,3,'Warm','Thursday',150.00),(5,3,'Warm','Friday',195.00),(5,3,'Warm','Saturday',195.00),
  (5,3,'Warm','Sunday',150.00),
  (5,3,'Cold','Monday',108.00),(5,3,'Cold','Tuesday',108.00),(5,3,'Cold','Wednesday',108.00),
  (5,3,'Cold','Thursday',108.00),(5,3,'Cold','Friday',140.40),(5,3,'Cold','Saturday',140.40),
  (5,3,'Cold','Sunday',108.00);
 
-- Hotel 3, RoomType 6
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (6,3,'Warm','Monday',225.00),(6,3,'Warm','Tuesday',225.00),(6,3,'Warm','Wednesday',225.00),
  (6,3,'Warm','Thursday',225.00),(6,3,'Warm','Friday',292.50),(6,3,'Warm','Saturday',292.50),
  (6,3,'Warm','Sunday',225.00),
  (6,3,'Cold','Monday',162.00),(6,3,'Cold','Tuesday',162.00),(6,3,'Cold','Wednesday',162.00),
  (6,3,'Cold','Thursday',162.00),(6,3,'Cold','Friday',210.60),(6,3,'Cold','Saturday',210.60),
  (6,3,'Cold','Sunday',162.00);
 
-- Hotel 4, RoomType 7
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (7,4,'Warm','Monday',150.00),(7,4,'Warm','Tuesday',150.00),(7,4,'Warm','Wednesday',150.00),
  (7,4,'Warm','Thursday',150.00),(7,4,'Warm','Friday',195.00),(7,4,'Warm','Saturday',195.00),
  (7,4,'Warm','Sunday',150.00),
  (7,4,'Cold','Monday',108.00),(7,4,'Cold','Tuesday',108.00),(7,4,'Cold','Wednesday',108.00),
  (7,4,'Cold','Thursday',108.00),(7,4,'Cold','Friday',140.40),(7,4,'Cold','Saturday',140.40),
  (7,4,'Cold','Sunday',108.00);
 
-- Hotel 4, RoomType 8 
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (8,4,'Warm','Monday',225.00),(8,4,'Warm','Tuesday',225.00),(8,4,'Warm','Wednesday',225.00),
  (8,4,'Warm','Thursday',225.00),(8,4,'Warm','Friday',292.50),(8,4,'Warm','Saturday',292.50),
  (8,4,'Warm','Sunday',225.00),
  (8,4,'Cold','Monday',162.00),(8,4,'Cold','Tuesday',162.00),(8,4,'Cold','Wednesday',162.00),
  (8,4,'Cold','Thursday',162.00),(8,4,'Cold','Friday',210.60),(8,4,'Cold','Saturday',210.60),
  (8,4,'Cold','Sunday',162.00);
 
-- Hotel 5, RoomType 9 
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (9,5,'Warm','Monday',100.00),(9,5,'Warm','Tuesday',100.00),(9,5,'Warm','Wednesday',100.00),
  (9,5,'Warm','Thursday',100.00),(9,5,'Warm','Friday',130.00),(9,5,'Warm','Saturday',130.00),
  (9,5,'Warm','Sunday',100.00),
  (9,5,'Cold','Monday',72.00),(9,5,'Cold','Tuesday',72.00),(9,5,'Cold','Wednesday',72.00),
  (9,5,'Cold','Thursday',72.00),(9,5,'Cold','Friday',93.60),(9,5,'Cold','Saturday',93.60),
  (9,5,'Cold','Sunday',72.00);
 
-- ---------- Guests ----------
-- DiscountID 1 = Gold, 2 = Silver
INSERT INTO Guest (GID, IdentificationType, IdentificationNumber, Address, HomePhoneNumber, MobilePhoneNumber, DiscountID) VALUES
  (1,  'Drivers License', 'VA-1', 'Richmond, VA',        '571-555-1001', '571-555-2001', 1),
  (2,  'Passport',        'P2',   'Roanoke, VA',      '540-555-1002', '540-555-2002', 2),
  (3,  'Drivers License', 'VA-3', 'Norfolk, VA',        '757-555-1003', '757-555-2003', 1),
  (4,  'Passport',        'P4',   'Alexandria, VA',      '703-555-1004', '703-555-2004', 2),
  (5,  'Drivers License', 'MD-5', 'Baltimore, MD',     '434-555-1005', '434-555-2005', 1),
  (6,  'State ID',        'VA-6', 'Arlington, VA',    '703-555-1006', '703-555-2006', 2),
  (7,  'Drivers License', 'VA-7', 'Fairfax, VA',         '703-555-1007', '703-555-2007', 1),
  (8,  'Passport',        'P8',   'Virginia Beach, VA',    '757-555-1008', '757-555-2008', 2),
  (9,  'Drivers License', 'NC-9', 'Raleigh, NC',      '703-555-1009', '703-555-2009', 1),
  (10, 'State ID',        'VA-10', 'Staunton, VA',   '434-555-1010', '434-555-2010', 2);
 
-- ---------- Occupants ----------
INSERT INTO Occupant (GuestID, Name) VALUES
  (1,  'Jane Smith'),
  (3,  'Sarah Davis'), (3,  'Tommy Davis'),
  (4,  'Mark Brown'),
  (5,  'Susan Wilson'), (5,  'Kyle Wilson'), (5,  'Emma Wilson'),
  (7,  'Emily Anderson'),
  (8,  'Kevin Thomas'), (8,  'Rachel Thomas'),
  (10, 'David Martin'), (10, 'Olivia Martin');
 
-- ---------- Room Services ----------
INSERT INTO RoomService (RoomServiceID, Cost) VALUES
  (1, 15.00),   -- Breakfast 
  (2, 35.00),   -- Dinner 
  (3, 20.00),   -- Laundry
  (4, 75.00);   -- Spa 
 
-- ---------- Reservations ----------
-- R1  GID 1  Hotel 1  future single-day, 1 room
-- R2  GID 1  Hotel 2  PAST 3-night, 2 rooms SAME type (Double), within Peak
-- R3  GID 2  Hotel 3  future single-day, 1 room
-- R4  GID 3  Hotel 4  PAST 2-night, MULTIPLE room types (Double + Suite), within Peak
-- R5  GID 3  Hotel 5  future single-day, 1 room
-- R6  GID 4  Hotel 1  PAST 3-night, 1 room, within OffPeak
-- R7  GID 5  Hotel 3  future single-day, 2 rooms DIFFERENT types
-- R8  GID 6  Hotel 2  future single-day, 1 room
-- R9  GID 7  Hotel 4  future single-day, 1 room
-- R10 GID 8  Hotel 5  future single-day, 2 rooms SAME type (Suite)
-- R11 GID 9  Hotel 1  future single-day, 1 room
-- R12 GID 10 Hotel 3  future single-day, 1 room
INSERT INTO Reservation (ReservationID, HotelID, GuestID, CheckInDate, CheckOutDate, NumberOfRooms) VALUES
  (1,  1, 1,  '2026-05-04', '2026-05-05', 1),
  (2,  2, 1,  '2025-07-10', '2025-07-13', 2),
  (3,  3, 2,  '2026-05-10', '2026-05-11', 1),
  (4,  4, 3,  '2025-06-15', '2025-06-17', 2),
  (5,  5, 3,  '2026-06-01', '2026-06-02', 1),
  (6,  1, 4,  '2025-12-15', '2025-12-18', 1),
  (7,  3, 5,  '2026-07-04', '2026-07-05', 2),
  (8,  2, 6,  '2026-05-20', '2026-05-21', 1),
  (9,  4, 7,  '2026-06-10', '2026-06-11', 1),
  (10, 5, 8,  '2026-08-01', '2026-08-02', 2),
  (11, 1, 9,  '2026-05-15', '2026-05-16', 1),
  (12, 3, 10, '2026-05-25', '2026-05-26', 1);
 
-- ---------- ReservationRoom  ----------
INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber) VALUES
  (1,  1, 101),                               -- R1: Single type 1
  (2,  2, 201), (2,  2, 202),                 -- R2: 2x Double type 4 (same type)
  (3,  3, 301),                               -- R3: Double type 5
  (4,  4, 201), (4,  4, 301),                 -- R4: Double type 7 + Suite type 8 (different types)
  (5,  5, 101),                               -- R5: Single type 9
  (6,  1, 101),                               -- R6: Single type 1 (past; no conflict with R1 date)
  (7,  3, 302), (7,  3, 401),                 -- R7: Double type 5 + Suite type 6 (different types)
  (8,  2, 101),                               -- R8: Single type 3
  (9,  4, 202),                               -- R9: Double type 7
  (10, 5, 501), (10, 5, 502),                 -- R10: 2x Suite type 10 (same type)
  (11, 1, 102),                               -- R11: Single type 1
  (12, 3, 303);                               -- R12: Double type 5
 
-- ---------- Stays  ----------
INSERT INTO Stay (ID, ReservationID, GuestID, start_date, end_date, Occupants) VALUES
  (1, 2, 1, '2025-07-10', '2025-07-13', 2),  -- John Smith + Jane
  (2, 4, 3, '2025-06-15', '2025-06-17', 3),  -- Robert Davis + Sarah + Tommy
  (3, 6, 4, '2025-12-15', '2025-12-18', 2);  -- Linda Brown + Mark
 
-- ---------- StayRoom  ----------
INSERT INTO StayRoom (StayID, HotelID, RoomNumber) VALUES
  (1, 2, 201), (1, 2, 202),
  (2, 4, 201), (2, 4, 301),
  (3, 1, 101);
 
-- ---------- StayRoomService  ----------
INSERT INTO StayRoomService (StayID, RoomServiceID) VALUES
  (1, 1),   -- Stay 1: Breakfast
  (1, 3),   -- Stay 1: Laundry
  (2, 2),   -- Stay 2: Dinner
  (2, 4),   -- Stay 2: Spa
  (3, 1);   -- Stay 3: Breakfast
 
-- ---------- Billing  ----------
-- Bill 1:
--   Rooms: 2 * ( $150 Thu + $195 Fri + $195 Sat ) = 2 * $540 = $1080
--   Gold 15% off rooms: $1080 * 0.85 = $918.00
--   Services: Breakfast $15 + Laundry $20 = $35
--   Total: $918.00 + $35.00 = $953.00
--
-- Bill 2:
--   RoomType 7 (Double): Sun $150 + Mon $150 = $300
--   RoomType 8 (Suite):  Sun $225 + Mon $225 = $450
--   Rooms total: $750
--   Gold 15% off rooms: $750 * 0.85 = $637.50
--   Services: Dinner $35 + Spa $75 = $110
--   Total: $637.50 + $110.00 = $747.50
--
-- Bill 3:
--   Rooms: 3 * $72 = $216
--   Silver 5% off rooms: $216 * 0.95 = $205.20
--   Services: Breakfast $15
--   Total: $205.20 + $15.00 = $220.20
INSERT INTO Billing (bill_id, reservation_id, guest_id, hotel_id, total_amount, start_date, end_date) VALUES
  (1, 2, 1, 2, 953.00,  '2025-07-10', '2025-07-13'),
  (2, 4, 3, 4, 747.50,  '2025-06-15', '2025-06-17'),
  (3, 6, 4, 1, 220.20,  '2025-12-15', '2025-12-18');
 
-- ---------- BillingDiscount  ----------
INSERT INTO BillingDiscount (bill_id, DiscountID) VALUES
  (1, 1),   -- Gold applied to Bill 1
  (2, 1),   -- Gold applied to Bill 2
  (3, 2);   -- Silver applied to Bill 3

--------------------- HOMEWORK QUERY 1 ADDITIONS ----------------------------
-- Make July 15-17, 2027 fall within a season for Hotel A / HotelID 1
INSERT INTO Season (HotelID, Name, StartDate, EndDate)
VALUES (1, 'Summer2027', '2027-06-01', '2027-08-31');

-- Prices for Hotel 1 room types during Summer 2027
-- Thursday and Friday are different
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (1, 1, 'Summer2027', 'Thursday', 100.00),
  (1, 1, 'Summer2027', 'Friday',   130.00),
  (2, 1, 'Summer2027', 'Thursday', 150.00),
  (2, 1, 'Summer2027', 'Friday',   195.00);

-- Block all Single rooms in Hotel 1, so at least one room type is NOT available.
INSERT INTO Reservation (ReservationID, HotelID, GuestID, CheckInDate, CheckOutDate, NumberOfRooms)
VALUES (90, 1, 1, '2027-07-15', '2027-07-17', 3);

INSERT INTO ReservationRoom (ReservationID, HotelID, RoomNumber) VALUES
  (90, 1, 101),
  (90, 1, 102),
  (90, 1, 103);