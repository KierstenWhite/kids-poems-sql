--Query the PoKi database using SQL SELECT statements to answer the following questions.

--What grades are stored in the database?
--Select * from Grade

--What emotions may be associated with a poem?
--Select * from Emotion

--How many poems are in the database?
--Select Count(p.Id) AS '# of poems'
--FROM Poem p

--Sort authors alphabetically by name. What are the names of the top 76 authors?
--Select TOP 76 a.Id, a.Name, COUNT(p.ID) As NumberOfPoems
--From Author a
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--Group by a.Id, a.Name
--Order By NumberOfPoems DESC

--Starting with the above query, add the grade of each of the authors.
--Select TOP 76 a.Id, a.Name, g.Name AS Grade, COUNT(p.ID) As NumberOfPoems
--From Author a
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--LEFT JOIN Grade g ON a.GradeId = g.Id
--Group by a.Id, a.Name, g.Name
--Order By NumberOfPoems DESC

--Starting with the above query, add the recorded gender of each of the authors.
--Select TOP 76 a.Id, a.Name, g.Name AS Grade, j.Name AS Gender, COUNT(p.ID) As NumberOfPoems
--From Author a
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--LEFT JOIN Grade g ON a.GradeId = g.Id
--LEFT JOIN Gender j ON a.GenderId = j.Id
--Group by a.Id, a.Name, g.Name, j.Name
--Order By NumberOfPoems DESC

--What is the total number of words in all poems in the database?
--Select Sum(p.WordCount) AS '# of words in all poems'
--From Poem p

--Which poem has the fewest characters?
--Select Top 1 Title, CharCount
--From Poem
--Order By CharCount ASC

--How many authors are in the third grade?
--Select COUNT(*) AS '# of 3rd Grade Authors'
--From Author
--Where GradeId = 3

--How many total authors are in the first through third grades?
--Select COUNT(*) AS '# of 1st-3rd Grade Authors'
--From Author
--Where GradeId = 1 OR GradeID = 2 OR GradeId = 3


--What is the total number of poems written by fourth graders?
--Select Count(*) AS '# of Poems Written by 4th Graders'
--FROM Poem
--Where AuthorId IN (
--Select Id
--From Author
--Where GradeId = 4)

--How many poems are there per grade?
--Select g.Name AS Grade, Count(p.Id) AS '# of Poems Per Grade'
--From Grade g
--LEFT JOIN Author a ON g.Id = a.GradeId
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--Group By g.Name

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
--Select g.Name AS Grade, Count(a.Id) AS '# of Authors in Each Grade'
--From Grade g
--LEFT JOIN Author a ON g.Id = a.GradeId
--Group By g.Name

--What is the title of the poem that has the most words?
--Select Top 1 Title, WordCount
--From Poem
--Order By WordCount DESC

--Which author(s) have the most poems? (Remember authors can have the same name.)
--SELECT a.Id, a.Name, COUNT(p.Id) AS NumberOfPoems
--FROM Author a
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--GROUP BY a.Id, a.Name
--HAVING COUNT(p.Id) = (
--    SELECT MAX(NumPoems)
--    FROM (
--        SELECT AuthorId, COUNT(Id) AS NumPoems
--        FROM Poem
--        GROUP BY AuthorId
--    ) AS PoemCount
--)

--How many poems have an emotion of sadness?
--Select COUNT(*) AS '# of Sad Poems'
--From PoemEmotion
--Where EmotionId = 3

--How many poems are not associated with any emotion?
--Select COUNT(*) AS '# of Emotionless Poems'
--From PoemEmotion
--Where EmotionId = null

--I guess this is the right way?
--SELECT COUNT(*) AS NumberOfPoems
--FROM Poem
--WHERE Id NOT IN (
--  SELECT DISTINCT PoemId
--  FROM PoemEmotion
--);

--Which emotion is associated with the least number of poems?
--SELECT e.Name, COUNT(pe.PoemId) AS NumberOfPoems
--FROM Emotion e
--LEFT JOIN PoemEmotion pe ON e.Id = pe.EmotionId
--GROUP BY e.Id, e.Name
--HAVING COUNT(pe.PoemId) = (
--    SELECT MIN(NumPoems)
--    FROM (
--        SELECT EmotionId, COUNT(PoemId) AS NumPoems
--        FROM PoemEmotion
--        GROUP BY EmotionId
--    ) AS EmotionCount
--);

--Which grade has the largest number of poems with an emotion of joy?
-- We need info from Grade, Poem, PoemEmotion, Author
--Select g.Name, Count(p.Id) As NumberOfJoyPoems
--From Grade g
--LEFT JOIN Author a ON g.Id = a.GradeId
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--LEFT JOIN PoemEmotion pe on p.Id = pe.PoemId
--Left Join Emotion e on pe.EmotionId = e.Id
--Where e.Name = 'Joy'
--Group by g.Id, g.Name
--Having Count(p.Id) = (
--Select MAX(NumberOfPoems)
--From (
--Select GradeId, Count(p.Id) as NumberOfPoems
--From Grade g
--Left Join Author a on g.Id = a.GradeId
--Left Join Poem p on a.Id = p.AuthorId
--Left Join PoemEmotion pe On p.Id = pe.PoemId
--Left Join Emotion e on pe.EmotionId = e.Id
--Where e.Name = 'Joy'
--Group by GradeId) As PoemCount)

--Which gender has the least number of poems with an emotion of fear?
--SELECT g.Name AS Gender, COUNT(p.Id) AS NumberOfPoems
--FROM Gender g
--LEFT JOIN Author a ON g.Id = a.GenderId
--LEFT JOIN Poem p ON a.Id = p.AuthorId
--LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
--LEFT JOIN Emotion e ON pe.EmotionId = e.Id
--WHERE e.Name = 'fear'
--GROUP BY g.Id, g.Name
--HAVING COUNT(p.Id) = (
--    SELECT MIN(NumPoems)
--    FROM (
--        SELECT GenderId, COUNT(p.Id) AS NumPoems
--        FROM Gender g
--        LEFT JOIN Author a ON g.Id = a.GenderId
--        LEFT JOIN Poem p ON a.Id = p.AuthorId
--        LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
--        LEFT JOIN Emotion e ON pe.EmotionId = e.Id
--        WHERE e.Name = 'fear'
--        GROUP BY GenderId
--    ) AS PoemCount
--);

