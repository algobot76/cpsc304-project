DROP DATABASE IF EXISTS RentalDatabase;
CREATE DATABASE IF NOT EXISTS RentalDatabase;
USE RentalDatabase;

DROP TABLE IF EXISTS PostalCode;
DROP TABLE IF EXISTS RealtyOffice;
DROP TABLE IF EXISTS Realtor;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS ForSale;
DROP TABLE IF EXISTS ForRent;
DROP TABLE IF EXISTS Sold;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Rented;
DROP TABLE IF EXISTS Feature;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS CustomerContactRealtor;

CREATE TABLE PostalCode (
  postal_code CHAR(7),
  city        CHAR(50),
  province    CHAR(2),
  PRIMARY KEY (postal_code)
);

CREATE TABLE Customer (
  phone       CHAR(25),
  email       CHAR(50) NOT NULL,
  name        CHAR(50),
  customer_id CHAR(10),
  PRIMARY KEY (customer_id),
  UNIQUE (email)
);

INSERT INTO `Customer` VALUES ('5195850524', 'Marcy@armyspy.com', 'Marcy R. Plascencia', '1'),
  ('9056029275', 'Wilson@teleworm.us', 'Stephanie D. Wilson', '2'),
  ('7809200082', 'Watts@teleworm.us', 'Molly B. Watts', '3'),
  ('2503564541', 'YongHsiung@dayrep.com', 'Yong Hsiung', '4');

CREATE TABLE RealtyOffice (
  branch_id   CHAR(10),
  branch_name CHAR(50),
  address     CHAR(50),
  postal_code CHAR(7),
  PRIMARY KEY (branch_id),
  FOREIGN KEY (postal_code) REFERENCES PostalCode (postal_code)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Realtor (
  phone      CHAR(25),
  email      CHAR(50) NOT NULL,
  name       CHAR(50),
  realtor_id CHAR(10),
  branch_id  CHAR(10) NOT NULL,
  UNIQUE (email),
  PRIMARY KEY (realtor_id),
  FOREIGN KEY (branch_id) REFERENCES RealtyOffice (branch_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Property (
  property_id   CHAR(10),
  address       CHAR(50) NOT NULL,
  postal_code   CHAR(7),
  property_type CHAR(50),
  date_built    DATETIME,
  sq_ft         FLOAT,
  date_added    DATETIME,
  num_beds      INT,
  num_baths     FLOAT,
  realtor_id    CHAR(10) NOT NULL,
  PRIMARY KEY (property_id),
  FOREIGN KEY (realtor_id) REFERENCES Realtor (realtor_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (postal_code) REFERENCES PostalCode (postal_code)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE ForSale (
  property_id CHAR(10),
  price       INT,
  PRIMARY KEY (property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE ForRent (
  property_id CHAR(10),
  rent        INT,
  PRIMARY KEY (property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Sold (
  property_id CHAR(10),
  final_price INT,
  date_sold   DATETIME,
  customer_id CHAR(10),
  PRIMARY KEY (property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Rented (
  property_id CHAR(10),
  final_rent  INT,
  from_date   DATETIME,
  to_date     DATETIME,
  customer_id CHAR(10) NOT NULL,
  PRIMARY KEY (property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Feature (
  feature_name CHAR(50),
  description  CHAR(50),
  property_id  CHAR(10),
  PRIMARY KEY (feature_name, property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Room (
  room_name   CHAR(50),
  image_url   CHAR(255),
  property_id CHAR(10),
  PRIMARY KEY (room_name, property_id),
  FOREIGN KEY (property_id) REFERENCES Property (property_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE CustomerContactRealtor (
  customer_id     CHAR(10),
  realtor_id      CHAR(10),
  date            DATETIME,
  contact_message CHAR(200),
  PRIMARY KEY (customer_id, realtor_id),
  FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  FOREIGN KEY (realtor_id) REFERENCES Realtor (realtor_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO PostalCode VALUES ('V6M 3W5', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6S 2H2', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6T 1Z4', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6K 2J6', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6R 2J2', 'Vancouver', 'BC');

INSERT INTO PostalCode VALUES ('V6R 2E2', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6M 1T6', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6N 3A7', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6P 2H9', 'Vancouver', 'BC');
INSERT INTO PostalCode VALUES ('V6M 3R5', 'Vancouver', 'BC');

INSERT INTO RealtyOffice VALUES ('1', 'Kerrisdale Remax', '5487 West Blvd', 'V6M 3W5');
INSERT INTO RealtyOffice VALUES ('2', 'Dunbar Realty Group', '4747 Dunbar St', 'V6S 2H2');
INSERT INTO RealtyOffice VALUES ('3', 'University Hill Realty', '2329 West Mall', 'V6T 1Z4');
INSERT INTO RealtyOffice VALUES ('4', 'Kitsilano Beach Houses', '2706 Trafalgar St', 'V6K 2J6');
INSERT INTO RealtyOffice VALUES ('5', 'Sasamat Select Homes', '4575 W 10th Ave', 'V6R 2J2');

INSERT INTO Realtor VALUES ('416-945-4647', 'LeonardHTiggs@dayrep.com', 'Leonard H. Tiggs', '1', '1');
INSERT INTO Realtor VALUES ('819-768-6717', 'JoanneBJudd@armyspy.com', 'Joanne B. Judd', '2', '1');
INSERT INTO Realtor VALUES ('604-765-2713', 'KyleDMoller@armyspy.com', 'Kyle D. Moller', '3', '2');
INSERT INTO Realtor VALUES ('604-606-6238', 'RogerLTrask@rhyta.com', 'Roger L. Trask', '4', '3');
INSERT INTO Realtor VALUES ('306-775-4387', 'JosefinaAWhittaker@jourrapide.com', 'Josefina A. Whittaker', '5', '4');

INSERT INTO Property
VALUES ('1', '4599 W9th St.', 'V6R 2E2', 'House', '1977/02/02', '1518', '2018/02/14', '4', '3', '5');
INSERT INTO Property
VALUES ('2', '201-2161 W 39th Ave', 'V6M 1T6', 'Apartment', '1980/05/11', '900', '2017/12/12', '2', '1', '2');
INSERT INTO Property
VALUES ('3', '3792 W 39th Ave', 'V6N 3A7', 'House', '1950/01/29', '2500', '2017/11/25', '4', '3', '3');
INSERT INTO Property
VALUES ('4', '1877 W 63rd Avenue', 'V6P 2H9', 'House', '1990/10/01', '3784', '2000/11/23', '6', '4', '4');
INSERT INTO Property
VALUES ('5', '5611 Cypress St', 'V6M 3R5', 'House', '1988/01/01', '3000', '2018/01/29', '7', '5.5', '5');

INSERT INTO ForSale VALUES ('1', '3255000');
INSERT INTO ForSale VALUES ('2', '98000');
INSERT INTO ForSale VALUES ('3', '301000');

INSERT INTO ForRent VALUES ('4', '3680000');
INSERT INTO ForRent VALUES ('5', '90000000');

-- SELECT * FROM Property;
-- SELECT * FROM Realtor;
-- SELECT * FROM RealtyOffice;
-- SELECT * FROM PostalCode;
