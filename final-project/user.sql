CREATE DATABASE IF NOT EXISTS `TrainDatabase`;

USE TrainDatabase;
SHOW TABLES;

CREATE TABLE station (
    name VARCHAR(50) DEFAULT NULL,
    state_name VARCHAR(50) DEFAULT NULL,
    city_name VARCHAR(50) DEFAULT NULL,
    station_id INT NOT NULL,
    PRIMARY KEY (station_id)
);

CREATE TABLE train_schedule (
    line_name VARCHAR(50) NOT NULL,
    num_stops INT, 
    fare INT,
    departure_time TIME,
    arrival_time TIME,
    travel_time TIME,
    origin_station_id INT,
    destination_station_id INT,
    is_operational BOOLEAN,
    PRIMARY KEY (line_name, arrival_time, departure_time),
    FOREIGN KEY (origin_station_id) REFERENCES station(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES station(station_id)
);

CREATE TABLE reservations (
    rid INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50),
    total_cost REAL NOT NULL,
    origin_station_id INT,
    destination_station_id INT,
    date_ticket DATE NOT NULL,
    date_reserved DATE NOT NULL,
    discount ENUM('Disabled', 'Senior', 'Child', 'Normal') NOT NULL,
    trip ENUM('Round', 'One') NOT NULL,
    line_name VARCHAR(50) NOT NULL,
    status VARCHAR(20),
    PRIMARY KEY (rid),
    FOREIGN KEY (origin_station_id) REFERENCES station(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES station(station_id),
    FOREIGN KEY (line_name) REFERENCES train_schedule(line_name)
);

CREATE TABLE stops_at (
    line_name VARCHAR(50) NOT NULL,
    station_id INT NOT NULL,
    stop_arrival_time TIME,
    stop_departure_time TIME,
    stop_number INT,
    PRIMARY KEY (line_name, station_id),
    FOREIGN KEY (line_name) REFERENCES train_schedule(line_name),
    FOREIGN KEY (station_id) REFERENCES station(station_id)
);

CREATE TABLE train (
    train_id INT(4) NOT NULL,
    line_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (train_id),
    FOREIGN KEY (line_name) REFERENCES train_schedule(line_name)
);

CREATE TABLE users (
    username VARCHAR(50) NOT NULL DEFAULT '',
    password VARCHAR(50) NOT NULL DEFAULT '',
    email VARCHAR(50) DEFAULT NULL,
    ssn VARCHAR(15) DEFAULT NULL,
    fname VARCHAR(50) DEFAULT NULL,
    lname VARCHAR(50) DEFAULT NULL,
    role ENUM('customer_service_rep', 'customer', 'administrator') DEFAULT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE messaging (
    mid INT NOT NULL AUTO_INCREMENT,
    user VARCHAR(50),
    subject VARCHAR(150),
    content TEXT,
    answer TEXT,
    PRIMARY KEY (mid),
    FOREIGN KEY (user) REFERENCES users(username) ON DELETE CASCADE
);

-- Populate `station` table
INSERT INTO station (name, state_name, city_name, station_id)
VALUES 
('Central Station', 'California', 'Los Angeles', 1),
('Union Station', 'California', 'San Francisco', 2),
('Grand Terminal', 'Nevada', 'Las Vegas', 3),
('South Station', 'Arizona', 'Phoenix', 4),
('East Side Depot', 'Utah', 'Salt Lake City', 5);

-- Populate `train_schedule` table
INSERT INTO train_schedule (line_name, num_stops, fare, departure_time, arrival_time, travel_time, origin_station_id, destination_station_id, is_operational)
VALUES 
('Pacific Line', 2, 120, '08:00:00', '12:00:00', '04:00:00', 1, 2, TRUE),
('Desert Express', 4, 150, '09:30:00', '14:00:00', '04:30:00', 3, 4, TRUE),
('Mountain Route', 5, 200, '10:00:00', '21:00:00', '11:00:00', 4, 5, TRUE),
('Gold Rush', 3, 300, '05:00:00', '19:00:00', '14:00:00', 3, 2, TRUE),
('Sunset Rail', 2, 180, '15:00:00', '20:00:00', '05:00:00', 2, 3, FALSE);

-- Populate `reservations` table
INSERT INTO reservations (username, total_cost, origin_station_id, destination_station_id, date_ticket, date_reserved, discount, trip, line_name, status)
VALUES 
('john_doe', 120.00, 1, 2, '2024-12-15', '2024-12-10', 'Normal', 'One', 'Pacific Line', 'Confirmed'),
('jane_smith', 150.00, 3, 4, '2024-12-20', '2024-12-18', 'Child', 'Round', 'Desert Express', 'Confirmed'),
('alice_williams', 250.00, 1, 3, '2024-12-25', '2024-12-20', 'Normal', 'Round', 'Gold Rush', 'Confirmed'), 
('bob_johnson', 200.00, 2, 4, '2024-12-30', '2024-12-28', 'Child', 'One', 'Sunset Rail', 'Confirmed'), 
('susan_davis', 180.00, 3, 5, '2024-12-28', '2024-12-22', 'Senior', 'Round', 'Desert Express', 'Confirmed'), 
('michael_brown', 120.00, 4, 2, '2024-12-24', '2024-12-23', 'Normal', 'One', 'Mountain Route', 'Confirmed'), 
('emily_jones', 150.00, 5, 1, '2024-12-29', '2024-12-26', 'Child', 'Round', 'Pacific Line', 'Confirmed'), 
('david_white', 170.00, 2, 5, '2024-12-30', '2024-12-29', 'Normal', 'One', 'Sunset Rail', 'Confirmed'), 
('lisa_martin', 200.00, 1, 4, '2024-12-31', '2024-12-29', 'Senior', 'Round', 'Gold Rush', 'Confirmed'), 
('james_anderson', 130.00, 4, 2, '2024-12-26', '2024-12-23', 'Child', 'One', 'Mountain Route', 'Confirmed'), 
('olivia_lee', 190.00, 3, 1, '2024-12-23', '2024-12-20', 'Normal', 'Round', 'Desert Express', 'Confirmed'), 
('charles_wilson', 220.00, 5, 2, '2024-11-27', '2024-11-25', 'Senior', 'One', 'Pacific Line', 'Confirmed'),
('test', 200.00, 4, 5, '2024-12-22', '2024-12-20', 'Senior', 'One', 'Mountain Route', 'Confirmed');

-- Populate `stops_at` table
INSERT INTO stops_at (line_name, station_id, stop_arrival_time, stop_departure_time, stop_number)
VALUES 
('Pacific Line', 1, '07:50:00', '08:00:00', 1),
('Pacific Line', 2, '12:00:00', '12:10:00', 2),
("Gold Rush", 3, "04:55:00", "05:00:00", 1),
("Gold Rush", 1, "12:00:00", "15:30:00", 2),
("Gold Rush", 2, "19:00:00", "19:05:00", 3),
('Sunset Rail', 2, '14:45:00', '15:00:00', 1),
('Sunset Rail', 3, '20:00:00', '20:15:00', 2),
('Desert Express', 3, '09:20:00', '09:30:00', 1),
('Desert Express', 5, '10:50:00', '11:00:00', 2),
('Desert Express', 1, '12:40:00', '12:55:00', 3),
('Desert Express', 4, '14:00:00', '14:15:00', 4),
('Mountain Route', 4, '10:00:00', '10:10:00', 1),
('Mountain Route', 3, '12:00:00', '12:10:00', 2),
('Mountain Route', 2, '15:30:00', '15:45:00', 3),
('Mountain Route', 1, '17:10:00', '17:20:00', 4),
('Mountain Route', 5, '21:00:00', '21:10:00', 5);

-- Populate `train` table
INSERT INTO train (train_id, line_name)
VALUES 
(1001, 'Pacific Line'),
(1002, 'Desert Express'),
(1003, 'Mountain Route'),
(1004, 'Sunset Rail');

-- Populate `users` table
INSERT INTO users (username, password, email, ssn, fname, lname, role)
VALUES 
('john_doe', 'password123', 'john@example.com', '123-45-6789', 'John', 'Doe', 'customer'),
('jane_smith', 'securepass', 'jane@example.com', '987-65-4321', 'Jane', 'Smith', 'customer'),
('admin_user', 'admin2024', 'admin@example.com', '111-22-3333', 'Admin', 'User', 'administrator'),
('alice_williams', 'password123', 'alice@example.com', '987-65-4321', 'Alice', 'Williams', 'customer'), 
('bob_johnson', 'password123', 'bob@example.com', '876-54-3210', 'Bob', 'Johnson', 'customer'), 
('susan_davis', 'password123', 'susan@example.com', '765-43-2109', 'Susan', 'Davis', 'customer'), 
('michael_brown', 'password123', 'michael@example.com', '654-32-1098', 'Michael', 'Brown', 'customer'), 
('emily_jones', 'password123', 'emily@example.com', '543-21-0987', 'Emily', 'Jones', 'customer'), 
('david_white', 'password123', 'david@example.com', '432-10-9876', 'David', 'White', 'customer'), 
('lisa_martin', 'password123', 'lisa@example.com', '321-09-8765', 'Lisa', 'Martin', 'customer'), 
('james_anderson', 'password123', 'james@example.com', '210-98-7654', 'James', 'Anderson', 'customer'), 
('olivia_lee', 'password123', 'olivia@example.com', '109-87-6543', 'Olivia', 'Lee', 'customer'), 
('charles_wilson', 'password123', 'charles@example.com', '098-76-5432', 'Charles', 'Wilson', 'customer'),
('rep_alex', 'rep456', 'alex@example.com', '555-66-7777', 'Alex', 'Johnson', 'customer_service_rep'),
('jane_doe', 'password456', 'jane@example.com', '987-65-4321', 'Jane', 'Doe', 'customer_service_rep'),
('nnm', 'password123', 'nnm@example.com','123-45-6789','Neha','Murthy','customer');
