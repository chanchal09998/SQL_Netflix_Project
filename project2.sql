-- netflix projects
create database sql_project_2

create table netflix
(
show_id varchar(10) primary key,
type varchar(10),
title varchar(150),
director varchar(250),
casts varchar(1000),
country varchar(150),
date_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar(100),
description varchar(250)
);

select * from netflix

select count(*) from netflix

select distinct type from netflix

--Q.1 count the number of movies and tv shows.
select type,count(*) as no_of_shows from netflix
group by type

--Q.2 find the most common rating for movie and tv shows
select type,rating,count(*) as no_of_shows from netflix
group by 1,2
order by 1,3 desc

--Q.3 list all movies which are released in the year 2020
select title,release_year from netflix
where release_year=2020 and type='Movie'

--Q.4 find the top 5 countries with the most content on netflix.
select 
unnest(string_to_array(country,','))as new_country,
count(*) as no_of_shows from netflix
group by 1
order by 2 desc
limit 5

--Q.5 indentify the longest movie
select * from netflix
where type='Movie'
and duration=(select max(duration) from netflix)

--Q.6 find the content added in the last 5 years
select * from netflix
where
to_date(date_added,'Month DD,YYYY')>=current_date - interval '5 years'

--Q.7 find all the movies/tv shows by director 'rajiv chilaka'
select * from netflix
where director ilike '%Rajiv Chilaka%'

--Q.8 list all the tv shows with more than 5 seasons.
select * from netflix
where
type='TV Show'
and
duration not in('1 Season','2 Seasons','3 Seasons','4 Seasons','5 Seasons')

select 
*
from netflix
where
type='TV Show'
and
split_part(duration,' ',1)::numeric > 5

--Q.9 count the number content item in each genre

select
unnest(string_to_array(listed_in,',')) as genre,
count(show_id)
from netflix
group by 1

--Q.10 find each year and the average number of content released by India on Netflix,
--     return top five years with highest average content to release

select
extract(year from to_date(date_added,'Month DD,YYYY'))as year,
count(*),
count(*)::numeric/(select count(*) from netflix where country='India')::numeric * 100 as average_content_each_year
from netflix
where country='India'
group by 1
order by 3 desc
limit 5

--Q.11 list all movies that are documentries

select * from netflix
where listed_in ilike '%Documentaries%'
and type='Movie'

--Q.12 find all content without a director
select * from netflix
where director is null

--Q.13 Find how many movies actor Salman Khan appeared in last 10 years.

select
*
from netflix
where casts ilike '%salman khan%'
and 
release_year > extract(year from current_date) - 10

--Q.14 Find the top actors who have appeared in the highest number of movies produced in India.

select
unnest(string_to_array(casts,',')) as actor,
count(show_id)
from 
netflix
where country ilike '%india%'
group by 1
order by 2 desc


--Q.15 categorise the content based on the presence of the keywords
--kill and violence in the description field label content containing
--these keywords as bad and all other content as good count how many
--items fall into each category

with new_table
as
(
select
*,
case
  when description ilike '%kill%' then 'BAD'
  when description ilike '%violence%' then 'BAD'
  else 'GOOD'
end as category
from netflix
)


select category,count(show_id) from new_table
group by 1




select * from netflix