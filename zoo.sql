-- The example uses a WHERE clause to show the population of 'France'. Note that strings (pieces of text that are data) should be in 'single quotes';
-- Modify it to show the population of Germany
SELECT population FROM world WHERE name = 'Germany'

-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000



-- Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population FROM world

-- How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million
SELECT name FROM world WHERE population > 200000000

-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, (gdp/population) AS 'Per Capita GDP' from  world WHERE population > 200000000

-- Show the name and population in millions for the countries of the continent 'South America'
SELECT name, (population/1000000) AS 'Polulation' FROM world WHERE continent =  'South America'

-- Show the name and population for France, Germany, Italy
SELECT name,population from world WHERE name IN ('France','Germany','Italy')

-- Show the countries which have a name that includes the word 'United'
SELECT name FROM world WHERE name LIKE '%United%'

-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name,population,area FROM world WHERE area >3000000 OR population >250000000

-- Show the countries that are big by area or big by population but not both. Show name, population and area.
SELECT name, population,area FROM world where area >3000000 XOR population >250000000

-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
-- For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name ,Round((population/1000000),2) AS 'Population', Round((gdp/1000000000),2) AS 'GDP'  FROM world where continent = 'South America'

-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
SELECT name, Round((gdp/population),-3) AS 'per_capita' FROM world WHERE  gdp >= 1000000000000

-- Show the name and capital where the name and the capital have the same number of characters.
SELECT name,  capital FROM world WHERE LENGTH(name) = LENGTH(capital)

-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name,  capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital

-- Find the country that has all the vowels and no spaces in its name.
SELECT name FROM world WHERE name LIKE '%u%' 
  and name LIKE '%a%' 
  and name LIKE '%o%' 
  and name LIKE '%i%'
  and name LIKE '%e%'
  and name NOT LIKE '% %'



-- Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner FROM nobel WHERE yr = 1950

-- Show who won the 1962 prize for Literature.
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature'

-- Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'

-- Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner FROM nobel WHERE subject = 'peace' AND yr >= 2000

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT * FROM nobel WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

-- Show all details of the presidential winners:
-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama
SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama')

-- Show the winners with first name John
SELECT winner FROM nobel WHERE winner LIKE 'John%'

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr,subject,winner FROM  nobel WHERE subject ='Physics' AND yr = 1980  OR subject = 'Chemistry' AND yr = 1984

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT yr,subject,winner FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry','Medicine')

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT yr,subject,winner from nobel WHERE subject  = 'Medicine' AND yr < 1910 OR subject = 'Literature' AND yr >= 2004

-- Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel WHERE winner LIKE 'peter gr%nberg'


-- Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel WHERE winner = 'EUGENE O''NEILL'

-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner,yr,subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY -yr

-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject FROM nobel WHERE yr = 1984 ORDER BY CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END, subject, winner



-- List each country name where the population is larger than 'Russia'.
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world WHERE gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe'

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia')) ORDER BY name

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')

-- Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(100*population /(SELECT population FROM world WHERE name= 'Germany' )), '%') AS 'Population ' FROM world WHERE continent = 'Europe'

-- Which countries have a GDP greater than every country in Europe? 
SELECT name FROM world WHERE gdp > (SELECT MAX(gdp) from world WHERE continent = 'Europe' )

-- Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x WHERE area >= ALL (SELECT area FROM world y WHERE y.continent=x.continent AND area>0)

-- List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x WHERE name <= ALL(SELECT name FROM world y WHERE y.continent = x.continent)

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population FROM world x WHERE 25000000  > ALL(SELECT population FROM world y WHERE x.continent = y.continent AND y.population > 0)

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world x WHERE population > ALL(SELECT population*3 FROM world y WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)




-- Show the total population of the world.
SELECT SUM(population) FROM world

-- List all the continents - just once each.
SELECT DISTINCT continent FROM world

-- Give the total GDP of Africa
SELECT SUM(gdp) FROM world WHERE continent = 'Africa'

-- How many countries have an area of at least 1000000
SELECT COUNT(name) FROM world WHERE area >= 1000000 

-- What is the total population of ('Estonia', 'Latvia', 'Lithuania'
SELECT SUM(population) FROM world WHERE name IN ('Estonia','Latvia','Lithuania')

-- For each continent show the continent and number of countries.
SELECT continent, Count(name) FROM world GROUP BY continent

-- For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name) FROM world  WHERE population >= 10000000 GROUP BY continent

-- List the continents that have a total population of at least 100 million.
SELECT continent FROM world  GROUP BY continent HAVING SUM(population) > 100000000



-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal WHERE teamid = 'GER'

-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2 FROM game WHERE id = 1012

-- The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say 
-- ON (game.id=goal.matchid)
-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid,stadium,mdate FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER'

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player FROM game JOIN goal ON (id=matchid AND player LIKE 'Mario%')

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON (teamid=id AND gtime<=10)

-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id AND coach LIKE '%Santos')

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player FROM goal JOIN game ON id=matchid WHERE stadium = 'National Stadium, Warsaw' 

-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player FROM game JOIN goal ON matchid = id WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER')

-- Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player) FROM eteam JOIN goal ON id=teamid GROUP BY teamname

-- Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) AS goals FROM game JOIN goal ON (id=matchid) GROUP BY stadium

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(player) AS goals FROM game JOIN goal ON (matchid=id AND (team1 = 'POL' OR team2 = 'POL')) GROUP BY matchid, mdate

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT id, mdate, COUNT(player) FROM game JOIN goal ON (id=matchid AND (team1 = 'GER' OR team2 = 'GER') AND teamid='GER') GROUP BY id, mdate

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
-- You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2



--  List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie WHERE yr=1962   

-- Give year of 'Citizen Kane'
SELECT yr FROM movie WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title,yr FROM movie WHERE title LIKE '%Star Trek%'

-- What id number does the actor 'Glenn Close' have?
SELECT id FROM actor WHERE name = 'Glenn Close'

-- What is the id of the film 'Casablanca'
SELECT id FROM movie WHERE title = 'Casablanca'

-- Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- The cast list is the names of the actors who were in the movie.
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT name FROM actor Join casting On actor.id = casting.actorid WHERE movieid = 11768

-- Obtain the cast list for the film 'Alien'
SELECT name FROM actor Join casting On actor.id = casting.actorid JOIN movie ON casting.movieid = movie.id WHERE movie.title =  'Alien'

-- List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie JOIN casting On movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id WHERE actor.name = 'Harrison Ford'

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie JOIN casting ON (id=movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1)

-- List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie JOIN casting ON movie.id= casting.movieid JOIN actor ON actor.id = casting.actorid WHERE ord=1 AND  yr = 1962

-- Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews')

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name FROM actor JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=30)
GROUP BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) as cast FROM movie JOIN casting on id=movieid WHERE yr = 1978 GROUP BY title ORDER BY cast DESC,title

-- List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name FROM actor JOIN casting ON id=actorid WHERE movieid IN (SELECT movieid FROM casting JOIN actor
 ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel' GROUP BY name



-- List the teachers who have NULL for their department.
SELECT name FROM  teacher WHERE dept IS NULL

-- Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)

-- Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)

-- Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher

-- Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT teacher.name , COALESCE(dept.name,'None') FROM teacher LEFT JOIN dept ON teacher.dept = dept.id

-- Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(name), COUNT(mobile) FROM teacher

-- Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id) GROUP BY dept.name

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT teacher.name,CASE WHEN dept.id = 1 THEN 'Sci' WHEN dept.id = 2 THEN 'Sci' ELSE 'Art' END 
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 
-- 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT teacher.name,
CASE
WHEN dept.id = 1 THEN 'Sci'
WHEN dept.id = 2 THEN 'Sci'
WHEN dept.id = 3 THEN 'Art'
ELSE 'None' END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept)


-- How many stops are in the database.
SELECT COUNT(*) FROM stops

-- Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops WHERE name = 'Craiglockhart'

-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name FROM stops JOIN route ON id=stop WHERE company = 'LRT' AND num=4

-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
--  Run the query and notice the two services
--  that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*) AS visits FROM route WHERE stop=149 OR stop=53
GROUP BY company, num HAVING visits=2

-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart,
--  without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num) WHERE a.stop=53 AND b.stop=149

-- The query shown is similar to the previous one, however by joining two copies of the stops
--  table we can refer to stops by name rather than by number. 
-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
-- If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'AND stopb.name = 'London Road'

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

-- Give a distinct list of the stops which may be reached from 'Craiglockhart'
--  by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. 
--  Include the company and bus no. of the relevant services.

SELECT stopa.name, a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopb.name = 'Craiglockhart'


-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
SELECT a.num, a.company, stopb.name , c.num, c.company
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN route c
  JOIN route d ON (c.company = d.company AND c.num= d.num)
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
  JOIN stops stopc ON c.stop = stopc.id
  JOIN stops stopd ON d.stop = stopd.id
WHERE  stopa.name = 'Craiglockhart'
  AND stopd.name = 'Lochend'
  AND stopb.name = stopc.name;


