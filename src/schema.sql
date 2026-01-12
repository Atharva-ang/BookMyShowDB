-- ==============================================================
-- PROJECT: BookMyShow Database Design (Assignment P1 & P2)
-- AUTHOR: Atharva Gandhe
-- DATE: 2026-01-12
-- ==============================================================

-- 1. DATABASE SETUP
-- --------------------------------------------------------------
-- Create the database if it doesn't exist and select it for use.
CREATE DATABASE IF NOT EXISTS bookmyshow_db;
USE bookmyshow_db;

-- 2. CLEANUP (RESET)
-- --------------------------------------------------------------
-- Drop tables in reverse order of dependencies to avoid foreign key errors.
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS theatres;

-- 3. TABLE CREATION (DDL)
-- --------------------------------------------------------------

-- Table: THEATRES
-- Represents the physical venue locations.
CREATE TABLE theatres (
    theatre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- Table: MOVIES
-- Represents the film content.
CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    language VARCHAR(50),      -- e.g., Telugu, Hindi
    format VARCHAR(10),        -- e.g., 2D, 3D
    certificate VARCHAR(10),   -- e.g., UA, A
    duration_mins INT NOT NULL,
    genre VARCHAR(100)
);

-- Table: SHOWS
-- This is the Mapping Table linking Movies to Theatres at specific times.
CREATE TABLE shows (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    theatre_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00,

    -- Foreign Key Constraints to ensure data integrity
    CONSTRAINT fk_movie FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_theatre FOREIGN KEY (theatre_id)
        REFERENCES theatres(theatre_id)
        ON DELETE CASCADE
);

-- 4. DATA POPULATION (DML)
-- --------------------------------------------------------------

-- Inserting Theatre (PVR: Nexus from the screenshot)
INSERT INTO theatres (name, city) VALUES
('PVR: Nexus', 'Hyderabad');

-- Inserting Movies (Matching the screenshot details)
INSERT INTO movies (title, language, format, certificate, duration_mins, genre) VALUES
('Dasara', 'Telugu', '2D', 'UA', 156, 'Action/Drama'),
('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', '2D', 'UA', 145, 'Action/Comedy'),
('Tu Jhoothi Main Makkaar', 'Hindi', '2D', 'UA', 160, 'Rom-Com'),
('Avatar: The Way of Water', 'English', '3D', 'UA', 192, 'Sci-Fi');

-- Inserting Shows (Matching the timestamps in the screenshot)
-- We assume the date is 2023-04-25 (Tuesday)
INSERT INTO shows (movie_id, theatre_id, show_date, show_time, price) VALUES
(1, 1, '2023-04-25', '12:15:00', 250.00), -- Dasara
(2, 1, '2023-04-25', '13:00:00', 200.00), -- Kisi Ka Bhai...
(2, 1, '2023-04-25', '16:10:00', 200.00), -- Kisi Ka Bhai...
(2, 1, '2023-04-25', '18:20:00', 220.00), -- Kisi Ka Bhai...
(3, 1, '2023-04-25', '13:15:00', 300.00), -- Tu Jhoothi...
(4, 1, '2023-04-25', '13:20:00', 450.00); -- Avatar (3D)

-- 5. PROBLEM STATEMENT 2 (QUERY)
-- --------------------------------------------------------------
-- Requirement: List all shows on a given date at a given theatre.

SELECT
    m.title AS Movie_Name,
    m.language AS Lang,
    m.format AS Format,
    s.show_time AS Show_Time,
    s.price AS Ticket_Price
FROM
    shows s
JOIN
    movies m ON s.movie_id = m.movie_id
WHERE
    s.theatre_id = 1              -- PVR: Nexus
    AND s.show_date = '2023-04-25' -- The date from the image
ORDER BY
    s.show_time ASC;