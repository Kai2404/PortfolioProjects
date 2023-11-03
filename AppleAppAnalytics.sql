-- Check the number of unique apps in both tables

select count(distinct id) as UniqueApp
from AppleStore


select count(distinct id) as UniqueApp
from appleStore_description

--Check for any missing values in key fields

select count(*) as MissingValues
from AppleStore
where track_name is null or user_rating is null or prime_genre is null

select count(*) as MissingValues
from appleStore_description
where app_desc is null 

--Find out the number of apps per genreAppleStore

select prime_genre, count(distinct id) as Total_Apps
from AppleStore
group by prime_genre
order by Total_Apps desc

--Get an overview of the app's ratings

select min(user_rating) as MinRating, max(user_rating) as MaxRating, AVG(user_rating) as AvgRating
from AppleStore

--Determine whether paid apps have higher ratings than free apps
SELECT
    CASE
        WHEN price > 0 THEN 'Paid'
        ELSE 'Free'
    END as app_type,
    AVG(user_rating) as AvgRating
FROM AppleStore
GROUP BY CASE
        WHEN price > 0 THEN 'Paid'
        ELSE 'Free'
    END

--Check if apps with more supported languages have higher ratings

select case
when lang_num <10 then '<10 languages'
when lang_num between 10 and 30 then '10-30 languages'
else '>30 languages'
end as language_bucket,
avg(user_rating) as AvgRating
from AppleStore
group by case
when lang_num <10 then '<10 languages'
when lang_num between 10 and 30 then '10-30 languages'
else '>30 languages'
end
order by AvgRating desc

--Check genres with low ratings
select top 10 cast(avg(user_rating) as decimal (10,2)) as Avg_Rating, prime_genre
from AppleStore
group by prime_genre
order by Avg_Rating asc

--Check if there is correlation between the lenght of the app description and the user rating
select case
when len(descr.app_desc) <500 then 'short'
when len(descr.app_desc) between 500 and 1000 then 'Medium'
else 'Long'
end as descr_length,
avg(store.user_rating) as Avg_rating
from AppleStore as store
inner join appleStore_description as descr
on store.id=descr.id
group by case
when len(descr.app_desc) <500 then 'short'
when len(descr.app_desc) between 500 and 1000 then 'Medium'
else 'Long'
end
order by Avg_rating desc

--Check the top rated apps for each genre
select prime_genre, track_name, user_rating
from(
select prime_genre, track_name, user_rating, RANK() over(partition by prime_genre order by user_rating desc, rating_count_tot desc) as rank
from AppleStore) as a
where 
a.rank=1





