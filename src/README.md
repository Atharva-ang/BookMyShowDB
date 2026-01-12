# 🎬 BookMyShow Database Design

## 📌 Project Overview
This project demonstrates a relational database design for a movie ticketing platform similar to BookMyShow. It handles the scheduling of movies across different theatres and dates while adhering to database normalization rules (3NF/BCNF).

## 📂 File Structure
* **`solution.sql`**: The main SQL script that contains:
    * **DDL:** Commands to create the `Theatres`, `Movies`, and `Shows` tables.
    * **DML:** Sample data population (based on real-world scenarios like *Dasara* & *Avatar*).
    * **Query (P2):** The solution query to list all shows for a specific date and theatre.

## 🛠️ Prerequisites
* **MySQL Server** (Version 8.0 or higher)
* **SQL Client** (DBeaver, MySQL Workbench, or IntelliJ Database Tool)

## 🚀 How to Run
1. Open your SQL Client and connect to your local MySQL instance.
2. Open `solution.sql`.
3. Execute the entire script.
    * *Note:* The script includes `DROP TABLE` commands to reset the environment on every run.
4. Check the **Result Grid** at the bottom to see the scheduled shows.

## 📊 Database Schema
* **Theatres:** Stores venue details (Name, City).
* **Movies:** Stores content details (Title, Language, Format, Certificate).
* **Shows:** The mapping table linking Movies to Theatres with specific timings and prices.

---
*Created as part of the Database Design Assignment.*