🎧 Spotify Data Analysis using Advanced SQL
📌 Project Overview

This project focuses on performing in-depth data analysis on a Spotify dataset using Advanced SQL techniques. The goal is to extract meaningful insights related to tracks, albums, artists, and user engagement metrics while strengthening skills in query writing, optimization, and analytical thinking.

The project follows an end-to-end SQL workflow, starting from data exploration and table creation to advanced querying and performance optimization.

🎯 Objectives

Analyze Spotify track-level data using SQL

Practice Easy, Medium, and Advanced SQL queries

Use CTEs and Window Functions for complex analysis

Understand and apply query optimization techniques

Improve performance using indexes and execution plans

🗂 Dataset Description

The dataset contains detailed information about Spotify tracks and their performance metrics, including:

Artist & Track Details: artist, track, album, album type

Audio Features: danceability, energy, loudness, tempo, liveness, valence

Engagement Metrics: views, likes, comments, streams

Platform & Metadata: channel, licensed status, official video, most played platform

🏗 Table Structure
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

🔍 Project Workflow
1️⃣ Data Exploration

Understanding columns and data types

Identifying key analytical attributes

Checking data distribution and quality

2️⃣ SQL Querying

Queries are divided into three difficulty levels to gradually build SQL expertise.

🟢 Easy Level

Retrieve tracks with more than 1 billion streams

List albums with their artists

Count total tracks per artist

Filter tracks by album type

🟡 Medium Level

Average danceability per album

Top 5 tracks by energy

Views and likes for official videos

Total views per album

Tracks streamed more on Spotify than YouTube

🔴 Advanced Level

Top 3 most-viewed tracks per artist (Window Functions)

Tracks with liveness above average

Energy difference per album using CTEs

Energy-to-liveness ratio greater than 1.2

Cumulative sum of likes ordered by views

3️⃣ Example Advanced Query (CTE)
WITH energy_stats AS (
    SELECT
        album,
        MAX(energy) AS highest_energy,
        MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY album
)
SELECT
    album,
    highest_energy - lowest_energy AS energy_difference
FROM energy_stats
ORDER BY energy_difference DESC;

⚡ Query Optimization
🔎 Performance Analysis

Used EXPLAIN ANALYZE to evaluate query performance

Initial query execution showed higher execution time

🚀 Optimization Strategy

Created an index on frequently queried columns

CREATE INDEX idx_artist ON spotify(artist);

📉 Results

Significant reduction in execution time

Improved query planning efficiency

Demonstrated the impact of indexing on large datasets

🛠 Technology Stack

Database: PostgreSQL

Query Language: SQL (DDL, DML, CTEs, Window Functions)

Tools: pgAdmin 4 / PostgreSQL CLI

▶️ How to Run the Project

Install PostgreSQL and pgAdmin

Create the database and table using the provided schema

Import the Spotify dataset

Execute SQL queries based on difficulty levels

Use EXPLAIN ANALYZE to test and optimize performance

📌 Key Learnings

Hands-on experience with Advanced SQL

Practical understanding of window functions and CTEs

Real-world application of query optimization

Improved analytical and problem-solving skills

📈 Future Enhancements

Normalize the dataset into multiple tables

Create views for commonly used queries

Integrate the database with a visualization tool (Power BI / Tableau)

👤 Author

Dev Charaya
MCA – Data Analytics
Interest: Data Analysis, SQL Optimization, Problem Solving
