-- write the commands for creating the tabel

drop table if exists spotify;
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

-- chekcking the data is imported
select * from spotify;
-- total tracks
select count(*) from spotify;
-- how many artist
select count(distinct artist) from spotify;
-- No of album in the data
select distinct(album) from spotify;
--max of durnation
select max(duration_min) from spotify;
-- minimum if 0 is there than we will remove that data
select min(duration_min) from spotify;
-- drop that data
select * from spotify where duration_min = 0;
delete from spotify where duration_min = 0;
select * from spotify where duration_min = 0;



-- Solve the business probelem


-----------------------------------------
-- easy data analysis --
-----------------------------------------

/*

Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.

*/

--Retrieve the names of all tracks that have more than 1 billion streams.
select distinct track , stream from spotify where stream  > 1000000000 order by stream desc ;


--List all albums along with their respective artists.
select distinct album , artist from spotify group by album,artist;


--Get the total number of comments for tracks where licensed = TRUE.
select sum(comments) as total_comments from
spotify where licensed = true;

--Find all tracks that belong to the album type single.
select * from spotify where album_type='single';


--Count the total number of tracks by each artist.
select artist , count(*) from spotify group by artist order by count(*) desc;

-----------------------------------------
--  Medium data analysis --
-----------------------------------------

/*
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

--Calculate the average danceability of tracks in each album.
select album , avg(danceability) as avg_of_album from spotify group by album
order by avg_of_album desc;


--Find the top 5 tracks with the highest energy values.
select distinct track, energy from spotify order by energy desc limit 5;


--List all tracks along with their views and likes where official_video = TRUE.
select track , sum(views), sum(likes) from spotify where official_video='true' group by track order by sum(views) desc;

--For each album, calculate the total views of all associated tracks.
select album , track  ,sum(views)  as total_album_views from spotify group by album , track 
order by total_album_views desc;

--Retrieve the track names that have been streamed on Spotify more than YouTube.
select * from 
(select track,
coalesce(sum(case when most_played_on='Youtube' then stream end),0) as  streamed_on_youtube, 
coalesce(sum(case when most_played_on='Spotify' then stream end),0) as  streamed_on_spotify
from spotify
group by track)
where streamed_on_spotify > streamed_on_youtube
and streamed_on_youtube <> 0 ;


-----------------------------------------
--  advance data analysis --
-----------------------------------------

/*
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
*/

--Find the top 3 most-viewed tracks for each artist using window functions.

-- each artist total view 
-- track the song with higest view and we need top
-- save 1 in cte so that we can use it
with artist_song_rank as(select artist,track, sum(views),
dense_rank() over(partition by artist order by sum(views) desc) as rank
from spotify
group by artist,track order by 
artist, sum(views) desc)
select
* from artist_song_rank 
where rank < 4;


--Write a query to find tracks where the liveness score is above the average.
SELECT TRACK, ARTIST, LIVENESS FROM SPOTIFY WHERE LIVENESS > (SELECT AVG(LIVENESS) FROM SPOTIFY);


--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with enegery_level as(select 
album,
max(energy) as highest_energy, 
min(energy) lowest_energy
from spotify 
group by album)

select album, highest_energy-lowest_energy as differnece_enegery from 
enegery_level order by differnece_enegery desc;




--Find tracks where the energy-to-liveness ratio is greater than 1.2.


select track, energy, liveness, energy/liveness as energy_liveness_ratio 
from spotify where liveness <> 0 and (energy/liveness) > 1.2
order by 3 desc;



--Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

select track, views,
sum(likes) over(partition by track order by views desc) as sum_of_likes from spotify

-- project by dev charaya.























































