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
 
-- Hotel 5, RoomType 10
INSERT INTO RoomCost (RoomTypeID, HotelID, SeasonName, DayOfWeek, Price) VALUES
  (10,5,'Warm','Monday',240.00),(10,5,'Warm','Tuesday',240.00),(10,5,'Warm','Wednesday',240.00),
  (10,5,'Warm','Thursday',240.00),(10,5,'Warm','Friday',320.00),(10,5,'Warm','Saturday',320.00),
  (10,5,'Warm','Sunday',240.00),
  (10,5,'Cold','Monday',170.00),(10,5,'Cold','Tuesday',170.00),(10,5,'Cold','Wednesday',170.00),
  (10,5,'Cold','Thursday',170.00),(10,5,'Cold','Friday',220.00),(10,5,'Cold','Saturday',220.00),
  (10,5,'Cold','Sunday',170.00);