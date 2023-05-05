CREATE TABLE AIRPORT (
    Airport_code char(3),
    Name varchar(40),
    City varchar(20),
    State char(2),
    PRIMARY KEY (Airport_code)
);

CREATE TABLE FLIGHT (
    Flight_number char(6),
    Airline varchar(20),
    Weekdays varchar(14),
    PRIMARY KEY (Flight_number)
);

CREATE TABLE FLIGHT_LEG (
    Flight_number char(6),
    Leg_number int,
    Departure_AIRPORT_code char(3),
    Scheduled_departure_time TIME,
    Arrival_AIRPORT_code char(3),
    Scheduled_arrival_time TIME,
    PRIMARY KEY (Flight_number, Leg_number)
);

CREATE TABLE AIRPLANE_TYPE (
    Airplane_type_name char(4),
    Max_seats int,
    Company varchar(14),
    PRIMARY KEY (Airplane_type_name)
);

CREATE TABLE AIRPLANE (
    Airplane_id char(6),
    Total_number_of_seats int,
    Airplane_type_name char(4),
    PRIMARY KEY (Airplane_id),
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE (Airplane_type_name)
);

CREATE TABLE LEG_INSTANCE (
    Flight_number char(6),
    Leg_number int,
    Date DATE,
    Number_of_available_seats int,
    Airplane_id char(6),
    Departure_AIRPORT_code char(3),
    Departure_time TIME,
    Arrival_AIRPORT_code char(3),
    Arrival_time TIME,
    PRIMARY KEY (Flight_number, Leg_number, Date),
    FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE (Airplane_id)
);

CREATE TABLE FARE (
    Flight_number char(6),
    Fare_code char(2),
    Amount int,
    Restrictions varchar(20),
    PRIMARY KEY (Flight_number, Fare_code),
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT (Flight_number)
);

CREATE TABLE CAN_LAND (
    Airplane_type_name char(4),
    Airport_code char(3),
    PRIMARY KEY (Airplane_type_name, Airport_code),
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE (Airplane_type_name)
);

CREATE TABLE SEAT_RESERVATION (
    Flight_number char(6),
    Leg_number int,
    Date DATE,
    Seat_number char(3),
    Customer_name varchar(20),
    Customer_phone char(10),
    PRIMARY KEY (Flight_number, Leg_number, Date, Seat_number),
    FOREIGN KEY (Flight_number, Leg_number) REFERENCES FLIGHT_LEG (Flight_number, Leg_number)
);

INSERT INTO AIRPORT VALUES ('iah', 'Houston Intercontinental', 'Houston', 'TX');
INSERT INTO AIRPORT VALUES ('atl', 'Hartsfield-Jackson', 'Atlanta', 'GA');
INSERT INTO AIRPORT VALUES ('ord', 'OHare International', 'Chicago', 'IL');
INSERT INTO AIRPORT VALUES ('lax', 'Los Angeles International', 'Los Angeles', 'CA');

INSERT INTO FLIGHT VALUES ('ua1234', 'United', 'MoTuWeThFr');
INSERT INTO FLIGHT VALUES ('co197', 'Continental', 'MoTuWeThFr');
INSERT INTO FLIGHT VALUES ('jb222', 'Jet Blue', 'MoTuWeThFr');
INSERT INTO FLIGHT VALUES ('sw3333', 'Southwest', 'SaSu');

INSERT INTO FLIGHT_LEG VALUES ('ua1234', 1, 'iah', '00:01:00', 'lax', '01:01:00');
INSERT INTO FLIGHT_LEG VALUES ('co197', 1, 'iah', '00:01:00', 'mci', '01:01:00');
INSERT INTO FLIGHT_LEG VALUES ('co197', 2, 'mci', '02:02:00', 'lax', '03:03:00');
INSERT INTO FLIGHT_LEG VALUES ('jb222', 1, 'atl', '02:02:00', 'lax', '03:03:00');
INSERT INTO FLIGHT_LEG VALUES ('sw3333', 1, 'iah', '04:01:00', 'mci', '05:01:00');
INSERT INTO FLIGHT_LEG VALUES ('sw3333', 2, 'mci', '06:02:00', 'lax', '07:03:00');

INSERT INTO AIRPLANE_TYPE VALUES ('b737', 180, 'Boeing');
INSERT INTO AIRPLANE_TYPE VALUES ('b747', 380, 'Boeing');
INSERT INTO AIRPLANE_TYPE VALUES ('a320', 160, 'Airbus');


INSERT INTO AIRPLANE VALUES ('1a2233', 80, 'b737');
INSERT INTO AIRPLANE VALUES ('1a2234', 120, 'b747');
INSERT INTO AIRPLANE VALUES ('1b2233', 60, 'a320');
INSERT INTO AIRPLANE VALUES ('1c2233', 230, 'b747');
INSERT INTO AIRPLANE VALUES ('1d2233', 110, 'a320');
INSERT INTO AIRPLANE VALUES ('1e2233', 130, 'b737');

INSERT INTO LEG_INSTANCE VALUES ('ua1234', 1, '2021-03-22', 8, '1a2233', 'iah', '00:01:00', 'lax', '01:01:00');
INSERT INTO LEG_INSTANCE VALUES ('co197', 1, '2021-03-22', 10, '1a2234', 'iah', '00:01:00', 'mci', '01:01:00');
INSERT INTO LEG_INSTANCE VALUES ('co197', 2, '2021-03-22', 6, '1b2233', 'mci', '02:02:00', 'lax', '03:03:00');
INSERT INTO LEG_INSTANCE VALUES ('co197', 1, '2009-10-09', 12, '1a2234', 'iah', '00:01:00', 'mci', '01:01:00');
INSERT INTO LEG_INSTANCE VALUES ('co197', 2, '2009-10-09', 5, '1b2233', 'mci', '02:02:00', 'lax', '03:03:00');
INSERT INTO LEG_INSTANCE VALUES ('jb222', 1, '2021-03-22', 23, '1c2233', 'atl', '02:02:00', 'lax', '03:03:00');
INSERT INTO LEG_INSTANCE VALUES ('sw3333', 1, '2021-03-22', 11, '1d2233', 'iah', '04:01:00', 'mci', '05:01:00');
INSERT INTO LEG_INSTANCE VALUES ('sw3333', 2, '2021-03-22', 13, '1e2233', 'mci', '06:02:00', 'lax', '07:03:00');

INSERT INTO CAN_LAND VALUES ('b737', 'atl');
INSERT INTO CAN_LAND VALUES ('b747', 'atl');
INSERT INTO CAN_LAND VALUES ('a320', 'atl');
INSERT INTO CAN_LAND VALUES ('b737', 'iah');
INSERT INTO CAN_LAND VALUES ('b747', 'iah');
INSERT INTO CAN_LAND VALUES ('a320', 'iah');
INSERT INTO CAN_LAND VALUES ('b737', 'lax');
INSERT INTO CAN_LAND VALUES ('b747', 'lax');
INSERT INTO CAN_LAND VALUES ('a320', 'lax');
INSERT INTO CAN_LAND VALUES ('b737', 'mci');
INSERT INTO CAN_LAND VALUES ('b747', 'mci');
INSERT INTO CAN_LAND VALUES ('a320', 'mci');

INSERT INTO SEAT_RESERVATION VALUES ('ua1234', 1, '2021-03-22', 'A1', 'John Smith', '1234567890');
INSERT INTO SEAT_RESERVATION VALUES ('co197', 1, '2021-03-22', 'A2', 'Jim Smith', '1234567890');
INSERT INTO SEAT_RESERVATION VALUES ('co197', 2, '2021-03-22', 'A3', 'Jane Smith', '1234567890');
INSERT INTO SEAT_RESERVATION VALUES ('jb222', 1, '2021-03-22', 'A4', 'Jerry Smith', '1234567890');
INSERT INTO SEAT_RESERVATION VALUES ('sw3333', 1, '2021-03-22', 'A5', 'Jill Smith', '1234567890');
INSERT INTO SEAT_RESERVATION VALUES ('sw3333', 2, '2021-03-22', 'A6', 'Jasper Smith', '1234567890');

INSERT INTO FARE VALUES ('ua1234', 'Y', 123, 'xSu');
INSERT INTO FARE VALUES ('co197', 'Y', 222, 'xSa');
INSERT INTO FARE VALUES ('co197', 'Z', 322, 'xSu');
INSERT INTO FARE VALUES ('co197', 'X', 422, 'Fr');
INSERT INTO FARE VALUES ('jb222', 'Z', 456, 'Mo');
INSERT INTO FARE VALUES ('sw3333', 'Y1', 88, 'TuWe');
