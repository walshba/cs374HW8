CREATE TABLE Hotels (
  ID INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Address VARCHAR(255) NOT NULL
);
 
CREATE TABLE HotelPhoneNumbers (
  HotelID INT NOT NULL,
  PhoneNumber VARCHAR(255) NOT NULL,
  PRIMARY KEY (HotelID, PhoneNumber)
);
 
CREATE TABLE HotelFeatures (
  HotelID INT NOT NULL,
  Feature VARCHAR(255) NOT NULL,
  PRIMARY KEY (HotelID, Feature)
);
 
CREATE TABLE CategoryDiscount (
  DiscountID INT PRIMARY KEY,
  DiscountType VARCHAR(255) NOT NULL UNIQUE,
  DiscountKind VARCHAR(10) NOT NULL CHECK (DiscountKind IN ('PERCENT', 'FLAT')),
  DiscountAmount DECIMAL(10,2) NOT NULL
);
 
CREATE TABLE Guest (
  GID INT PRIMARY KEY,
  IdentificationType VARCHAR(255) NOT NULL,
  IdentificationNumber VARCHAR(255) NOT NULL,
  Address VARCHAR(255),
  HomePhoneNumber VARCHAR(255),
  MobilePhoneNumber VARCHAR(255),
  DiscountID INT
);
 
CREATE TABLE Occupant (
  GuestID INT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (GuestID, Name)
);
 
CREATE TABLE RoomType (
  RoomTypeID INT PRIMARY KEY,
  HotelID INT NOT NULL,
  Size VARCHAR(255) NOT NULL,
  Capacity INT NOT NULL
);
 
CREATE TABLE RoomTypeFeatures (
  RoomTypeID INT NOT NULL,
  Feature VARCHAR(255) NOT NULL,
  PRIMARY KEY (RoomTypeID, Feature)
);
 
CREATE TABLE Room (
  HotelID INT NOT NULL,
  RoomNumber INT NOT NULL,
  Floor INT,
  RoomTypeID INT NOT NULL,
  PRIMARY KEY (HotelID, RoomNumber)
);
 
-- Season now belongs to a specific Hotel
CREATE TABLE Season (
  HotelID INT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  PRIMARY KEY (HotelID, Name)
);
 
CREATE TABLE RoomCost (
  RoomTypeID INT NOT NULL,
  HotelID INT NOT NULL,
  SeasonName VARCHAR(255) NOT NULL,
  DayOfWeek VARCHAR(255) NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (RoomTypeID, SeasonName, DayOfWeek)
);
 
CREATE TABLE Reservation (
  ReservationID INT PRIMARY KEY,
  HotelID INT NOT NULL,
  GuestID INT NOT NULL,
  CheckInDate DATE NOT NULL,
  CheckOutDate DATE NOT NULL,
  NumberOfRooms INT NOT NULL
);
 
CREATE TABLE Stay (
  ID INT PRIMARY KEY,
  ReservationID INT NOT NULL,
  GuestID INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  Occupants INT
);
 
CREATE TABLE RoomService (
  RoomServiceID INT PRIMARY KEY,
  Cost DECIMAL(10,2) NOT NULL
);
 
CREATE TABLE Billing (
  bill_id INT PRIMARY KEY,
  reservation_id INT NOT NULL,
  guest_id INT NOT NULL,
  hotel_id INT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);
 
CREATE TABLE ReservationRoom (
  ReservationID INT NOT NULL,
  HotelID INT NOT NULL,
  RoomNumber INT NOT NULL,
  PRIMARY KEY (ReservationID, HotelID, RoomNumber)
);
 
CREATE TABLE StayRoom (
  StayID INT NOT NULL,
  HotelID INT NOT NULL,
  RoomNumber INT NOT NULL,
  PRIMARY KEY (StayID, HotelID, RoomNumber)
);
 
CREATE TABLE StayRoomService (
  StayID INT NOT NULL,
  RoomServiceID INT NOT NULL,
  PRIMARY KEY (StayID, RoomServiceID)
);
 
CREATE TABLE BillingDiscount (
  bill_id INT NOT NULL,
  DiscountID INT NOT NULL,
  PRIMARY KEY (bill_id, DiscountID)
);
 
-- =========================================================
-- Indexes
-- =========================================================
 
CREATE INDEX ON RoomType (HotelID);
 
CREATE INDEX ON Room (RoomTypeID);
 
CREATE INDEX ON RoomCost (HotelID, SeasonName);
 
CREATE INDEX ON Reservation (HotelID);
 
CREATE INDEX ON Reservation (GuestID);
 
CREATE INDEX ON Stay (ReservationID);
 
CREATE INDEX ON Stay (GuestID);
 
CREATE INDEX ON Billing (reservation_id);
 
CREATE INDEX ON Billing (guest_id);
 
CREATE INDEX ON Billing (hotel_id);
 
CREATE INDEX ON ReservationRoom (HotelID, RoomNumber);
 
CREATE INDEX ON StayRoom (HotelID, RoomNumber);
 
CREATE INDEX ON StayRoomService (RoomServiceID);
 
CREATE INDEX ON BillingDiscount (DiscountID);
 
CREATE INDEX ON Guest (DiscountID);
 
-- =========================================================
-- Foreign Key Constraints
-- =========================================================
 
ALTER TABLE HotelPhoneNumbers ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE HotelFeatures ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Guest ADD FOREIGN KEY (DiscountID) REFERENCES CategoryDiscount (DiscountID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Occupant ADD FOREIGN KEY (GuestID) REFERENCES Guest (GID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE RoomType ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE RoomTypeFeatures ADD FOREIGN KEY (RoomTypeID) REFERENCES RoomType (RoomTypeID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Room ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Room ADD FOREIGN KEY (RoomTypeID) REFERENCES RoomType (RoomTypeID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Season ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE RoomCost ADD FOREIGN KEY (RoomTypeID) REFERENCES RoomType (RoomTypeID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE RoomCost ADD FOREIGN KEY (HotelID, SeasonName) REFERENCES Season (HotelID, Name) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Reservation ADD FOREIGN KEY (HotelID) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Reservation ADD FOREIGN KEY (GuestID) REFERENCES Guest (GID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Stay ADD FOREIGN KEY (ReservationID) REFERENCES Reservation (ReservationID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Stay ADD FOREIGN KEY (GuestID) REFERENCES Guest (GID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Billing ADD FOREIGN KEY (reservation_id) REFERENCES Reservation (ReservationID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Billing ADD FOREIGN KEY (guest_id) REFERENCES Guest (GID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE Billing ADD FOREIGN KEY (hotel_id) REFERENCES Hotels (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE ReservationRoom ADD FOREIGN KEY (ReservationID) REFERENCES Reservation (ReservationID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE ReservationRoom ADD FOREIGN KEY (HotelID, RoomNumber) REFERENCES Room (HotelID, RoomNumber) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE StayRoom ADD FOREIGN KEY (StayID) REFERENCES Stay (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE StayRoom ADD FOREIGN KEY (HotelID, RoomNumber) REFERENCES Room (HotelID, RoomNumber) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE StayRoomService ADD FOREIGN KEY (StayID) REFERENCES Stay (ID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE StayRoomService ADD FOREIGN KEY (RoomServiceID) REFERENCES RoomService (RoomServiceID) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE BillingDiscount ADD FOREIGN KEY (bill_id) REFERENCES Billing (bill_id) DEFERRABLE INITIALLY IMMEDIATE;
 
ALTER TABLE BillingDiscount ADD FOREIGN KEY (DiscountID) REFERENCES CategoryDiscount (DiscountID) DEFERRABLE INITIALLY IMMEDIATE;