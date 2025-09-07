
# Netflix Data Analysis Project

## 📚 Project Overview

This project focuses on analyzing a dataset of Netflix content to extract meaningful insights using SQL. The dataset contains information about movies and TV shows available on Netflix across different countries, release years, ratings, genres, and other attributes. The analysis is aimed at answering various business and data exploration questions using SQL queries.

---

## 🎯 Objectives

- Understand the structure and contents of the Netflix dataset.
- Perform exploratory data analysis using SQL queries.
- Extract key insights such as top countries producing content, most popular ratings, and top actors in Indian content.
- Categorize content based on certain keywords in the description field.
- Generate useful reports like content added in the last 5 years, longest movies, and documentary films.

---

## 📊 Dataset Description

The dataset used in this project is named `netflix_titles.csv` and contains the following columns:

| Column Name    | Description |
|-------------- |------------|
| show_id       | Unique identifier for each show |
| type         | Type of content (Movie / TV Show) |
| title        | Title of the show |
| director     | Director of the show |
| casts        | List of main actors |
| country      | Country of production |
| date_added   | Date the content was added to Netflix |
| release_year | Year the content was released |
| rating      | Content rating (PG, R, etc.) |
| duration    | Length of movie or number of seasons |
| listed_in   | Genres associated with the content |
| description | Short description of the content |

---

## ⚡ Analysis Performed

1. **Count the number of Movies and TV Shows**
   ```sql
   SELECT type, COUNT(*) AS no_of_shows FROM netflix GROUP BY type;
   ```

2. **Most Common Rating for Movies and TV Shows**
   ```sql
   SELECT type, rating, COUNT(*) AS no_of_shows FROM netflix GROUP BY type, rating ORDER BY type, no_of_shows DESC;
   ```

3. **List All Movies Released in 2020**
   ```sql
   SELECT title, release_year FROM netflix WHERE release_year = 2020 AND type = 'Movie';
   ```

4. **Top 5 Countries with Most Content on Netflix**
   ```sql
   SELECT unnest(string_to_array(country, ',')) AS new_country, COUNT(*) AS no_of_shows FROM netflix GROUP BY new_country ORDER BY no_of_shows DESC LIMIT 5;
   ```

5. **Identify the Longest Movie**
   ```sql
   SELECT * FROM netflix WHERE type = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix);
   ```

6. **Content Added in the Last 5 Years**
   ```sql
   SELECT * FROM netflix WHERE to_date(date_added,'Month DD,YYYY') >= current_date - INTERVAL '5 years';
   ```

7. **All Content by Director 'Rajiv Chilaka'**
   ```sql
   SELECT * FROM netflix WHERE director ILIKE '%Rajiv Chilaka%';
   ```

8. **TV Shows with More Than 5 Seasons**
   ```sql
   SELECT * FROM netflix WHERE type = 'TV Show' AND split_part(duration, ' ', 1)::numeric > 5;
   ```

9. **Count Content Items in Each Genre**
   ```sql
   SELECT unnest(string_to_array(listed_in, ',')) AS genre, COUNT(show_id) FROM netflix GROUP BY genre;
   ```

10. **Top 5 Years with Highest Average Content Released in India**
    ```sql
    SELECT extract(year from to_date(date_added,'Month DD,YYYY')) AS year, COUNT(*) AS total, COUNT(*)::numeric / (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100 AS avg_per_year FROM netflix WHERE country = 'India' GROUP BY year ORDER BY avg_per_year DESC LIMIT 5;
    ```

11. **Documentary Movies**
    ```sql
    SELECT * FROM netflix WHERE listed_in ILIKE '%Documentaries%' AND type = 'Movie';
    ```

12. **Content Without a Director**
    ```sql
    SELECT * FROM netflix WHERE director IS NULL;
    ```

13. **Movies Featuring Salman Khan in Last 10 Years**
    ```sql
    SELECT * FROM netflix WHERE casts ILIKE '%salman khan%' AND release_year > EXTRACT(year from current_date) - 10;
    ```

14. **Top Actors in Indian Content**
    ```sql
    SELECT unnest(string_to_array(casts, ',')) AS actor, COUNT(show_id) FROM netflix WHERE country ILIKE '%India%' GROUP BY actor ORDER BY COUNT(show_id) DESC;
    ```

15. **Categorize Content as 'BAD' or 'GOOD' Based on Keywords**
    ```sql
    WITH categorized AS (
      SELECT *, CASE
        WHEN description ILIKE '%kill%' THEN 'BAD'
        WHEN description ILIKE '%violence%' THEN 'BAD'
        ELSE 'GOOD'
      END AS category FROM netflix
    )
    SELECT category, COUNT(show_id) FROM categorized GROUP BY category;
    ```

---

## ✅ Conclusion

This project demonstrates how SQL can be effectively used to extract insights and perform data analysis on a large dataset. It covers business questions like most active countries, top directors, popular genres, and content trends over time. Additionally, it shows how to clean and transform data for better results.

---

## 📁 Dataset Source

- Original dataset: `netflix_titles.csv`

---

## ⚡ Tools Used

- PostgreSQL
- SQL Queries

---

## 📫 Contact

For any questions or suggestions, feel free to contact me at:  
**Name:** Chanchal Kumar  
**Email:** [Your Email Here]

---

🔗 Happy Data Exploring!
