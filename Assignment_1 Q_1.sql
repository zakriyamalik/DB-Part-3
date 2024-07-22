create database assignment1_q1;
use assignment1_q1
CREATE TABLE Airport (
    Airport_code VARCHAR(10) PRIMARY KEY NOT NULL,
    city VARCHAR(255),
    state VARCHAR(255),
    name VARCHAR(255)
);
CREATE TABLE Airplane_type (
    Type_name VARCHAR(255) PRIMARY KEY NOT NULL,
    max_seats INT,
    company VARCHAR(255)
);
CREATE TABLE Airplane (
    Airplane_id VARCHAR(255) PRIMARY KEY NOT NULL,
    total_no_of_seats INT
);
CREATE TABLE flight_leg (
    leg_no INT,
	Airport_code VARCHAR(10),
    PRIMARY KEY (leg_no, Airport_code),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);
CREATE TABLE Seat (
    seat_no VARCHAR(255) PRIMARY KEY NOT NULL
);
CREATE TABLE flight (
    Number VARCHAR(255) PRIMARY KEY NOT NULL,
    airline VARCHAR(255),
    weekdays VARCHAR(255)
);
CREATE TABLE fare (
    code VARCHAR(255)NOT NULL,
    amount DECIMAL(10, 2),
    restrictions VARCHAR(255),
	flight_number VARCHAR(255) NOT NULL,
    PRIMARY KEY (code, flight_number) ,
    FOREIGN KEY (flight_number) REFERENCES flight(Number)
);
CREATE TABLE leg_instance (
    Number_of_available_seats INT,
    Date DATE,
	Airport_code VARCHAR(10),
    PRIMARY KEY (Date, Airport_code),
    FOREIGN KEY (Airport_code) REFERENCES Airport(Airport_code)
);
CREATE TABLE departure_airport (
    schedual_dep_time TIME
);
CREATE TABLE arrival_airport (
    schedual_arr_time TIME
);
CREATE TABLE arrival (
    arr_time TIME
);
CREATE TABLE departure (
    departure_time TIME
);
CREATE TABLE reservation (
    customer_name VARCHAR(255),
    c_phone VARCHAR(255)
);
