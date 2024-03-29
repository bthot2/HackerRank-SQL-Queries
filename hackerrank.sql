--HACKERRANK SQL QUERIES

--1.BASIC SELECT
		--1.QUERY ALL COLUMNS FOR ALL AMERICAN CITIES IN CITY WITH POPULATIONS LARGER THAN 100000. THE COUNTRYCODE FOR AMERICA IS USA. 
			SELECT * FROM CITY WHERE COUNTRYCODE='USA' AND POPULATION>100000;
			
		--2.QUERY THE NAMES OF ALL AMERICAN CITIES IN CITY WITH POPULATIONS LARGER THAN 120000. THE COUNTRYCODE FOR AMERICA IS USA.
			SELECT NAME FROM CITY WHERE POPULATION>120000 AND COUNTRYCODE='USA';
			
		--3.QUERY ALL COLUMNS (ATTRIBUTES) FOR EVERY ROW IN THE CITY TABLE.
			SELECT * FROM CITY;
			
		--4.QUERY ALL COLUMNS FOR A CITY IN CITY WITH THE ID 1661.
			SELECT * FROM CITY WHERE ID=1661;
			
		--5.QUERY ALL ATTRIBUTES OF EVERY JAPANESE CITY IN THE CITY TABLE. THE COUNTRYCODE FOR JAPAN IS JPN.
			SELECT NAME FROM CITY WHERE COUNTRYCODE='JPN';
			
		--6.QUERY A LIST OF CITY AND STATE FROM THE STATION TABLE.
			SELECT CITY, STATE FROM STATION;
			
		--7.QUERY A LIST OF CITY NAMES FROM STATION WITH EVEN ID NUMBERS ONLY. YOU MAY PRINT THE RESULTS IN ANY ORDER, BUT MUST EXCLUDE DUPLICATES FROM YOUR ANSWER.
			SELECT DISTINCT CITY FROM STATION WHERE (ID % 2)=0 ORDER BY CITY;
			
		--8.LET N BE THE NUMBER OF CITY ENTRIES IN STATION, AND LET N1 BE THE NUMBER OF DISTINCT CITY NAMES IN STATION; QUERY THE VALUE OF N-N1 FROM STATION. 
		 --IN OTHER WORDS, FIND THE DIFFERENCE BETWEEN THE TOTAL NUMBER OF CITY ENTRIES IN THE TABLE AND THE NUMBER OF DISTINCT CITY ENTRIES IN THE TABLE.
			SELECT COUNT(CITY)-COUNT(DISTINCT CITY) FROM STATION;
			
		--9.QUERY THE TWO CITIES IN STATION WITH THE SHORTEST AND LONGEST CITY NAMES, AS WELL AS THEIR RESPECTIVE LENGTHS (I.E.: NUMBER OF CHARACTERS IN THE NAME). 
		 --IF THERE IS MORE THAN ONE SMALLEST OR LARGEST CITY, CHOOSE THE ONE THAT COMES FIRST WHEN ORDERED ALPHABETICALLY.
			SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) , CITY LIMIT 1;
			SELECT  CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY LIMIT 1;
			
		--10.QUERY THE LIST OF CITY NAMES STARTING WITH VOWELS (I.E., A, E, I, O, OR U) FROM STATION. YOUR RESULT CANNOT CONTAIN DUPLICATES.
			SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY), '^[AEIOU]');
			
		--11.QUERY THE LIST OF CITY NAMES ENDING WITH VOWELS (A, E, I, O, U) FROM STATION. YOUR RESULT CANNOT CONTAIN DUPLICATES.
			SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY),'[AEIOU]$');
			
		--12.QUERY THE LIST OF CITY NAMES FROM STATION WHICH HAVE VOWELS (I.E., A, E, I, O, AND U) AS BOTH THEIR FIRST AND LAST CHARACTERS. 
		 --YOUR RESULT CANNOT CONTAIN DUPLICATES
			SELECT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY),'^[AEIOU]')AND REGEXP_LIKE(LOWER(CITY),'[AEIOU]$');
			
		--13.QUERY THE LIST OF CITY NAMES FROM STATION THAT DO NOT START WITH VOWELS. YOUR RESULT CANNOT CONTAIN DUPLICATES.
			SELECT  DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY), '^[^AEIOU]');
			
		--14.QUERY THE LIST OF CITY NAMES FROM STATION THAT DO NOT END WITH VOWELS. YOUR RESULT CANNOT CONTAIN DUPLICATES.
			SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY),'[^AEIOU]$');
			
		--15.QUERY THE LIST OF CITY NAMES FROM STATION THAT EITHER DO NOT START WITH VOWELS OR DO NOT END WITH VOWELS. YOUR RESULT CANNOT CONTAIN DUPLICATES
			SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY),'^[^AEIOU]|[^AEIOU]$') ;
			
		--16.QUERY THE LIST OF CITY NAMES FROM STATION THAT DO NOT START WITH VOWELS AND DO NOT END WITH VOWELS. YOUR RESULT CANNOT CONTAIN DUPLICATES.
			SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY),'[^AEIOU]$') AND REGEXP_LIKE(LOWER(CITY),'^[^AEIOU]');
			
		--17.QUERY THE NAME OF ANY STUDENT IN STUDENTS WHO SCORED HIGHER THAN MARKS. ORDER YOUR OUTPUT BY THE LAST THREE CHARACTERS OF EACH NAME. 
		 --IF TWO OR MORE STUDENTS BOTH HAVE NAMES ENDING IN THE SAME LAST THREE CHARACTERS (I.E.: BOBBY, ROBBY, ETC.), SECONDARY SORT THEM BY ASCENDING ID.
			SELECT NAME FROM STUDENTS WHERE MARKS>75 ORDER BY SUBSTR(NAME, LENGTH(NAME)-2, LENGTH(NAME)), ID ASC;
			
		--18.WRITE A QUERY THAT PRINTS A LIST OF EMPLOYEE NAMES (I.E.: THE NAME ATTRIBUTE) FROM THE EMPLOYEE TABLE IN ALPHABETICAL ORDER.
			SELECT NAME FROM EMPLOYEE ORDER BY NAME ASC;
			
		--19.WRITE A QUERY THAT PRINTS A LIST OF EMPLOYEE NAMES (I.E.: THE NAME ATTRIBUTE) FOR EMPLOYEES IN EMPLOYEE HAVING A SALARY GREATER THAN 2000 
		 --PER MONTH WHO HAVE BEEN EMPLOYEES FOR LESS THAN MONTHS. SORT YOUR RESULT BY ASCENDING EMPLOYEE_ID.
			SELECT NAME FROM EMPLOYEE WHERE SALARY>2000 AND MONTHS<10;
			
			
--2.ADVANCED SELECT
		--1.WRITE A QUERY IDENTIFYING THE TYPE OF EACH RECORD IN THE TRIANGLES TABLE USING ITS THREE SIDE LENGTHS. 
			SELECT CASE 
					WHEN A+B>C AND A+C>B THEN 
					CASE
						WHEN A=B AND B=C THEN 'EQUILATERAL'
						WHEN A=B OR B=C OR C=A THEN 'ISOSCELES'
						WHEN A!=B AND B!=C AND C!=A THEN 'SCALENE'
					END
					ELSE 'NOT A TRIANGLE'
				   END FROM TRIANGLES;
				   
		--2.THE PADS
			SELECT CONCAT(CONCAT(NAME, '('), CONCAT(SUBSTR(OCCUPATION, 1,1), ')')) AS NAME FROM OCCUPATIONS ORDER BY NAME;
			SELECT CONCAT(CONCAT(CONCAT('THERE ARE TOTAL ', COUNT(OCCUPATION)), CONCAT(' ',LOWER(OCCUPATION))), CONCAT('S','.'))AS TOTAL 
			FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY TOTAL
			
		--3.OCCUPATIONS
			SET @DOC=0, @ACT=0, @PROF=0, @SING=0;
			SELECT MIN(DOCTOR), MIN(PROFESSOR), MIN(SINGER), MIN(ACTOR) FROM
			(SELECT CASE
						WHEN OCCUPATION='DOCTOR' THEN @DOC:=@DOC+1 
						WHEN OCCUPATION='PROFESSOR' THEN @PROF:=@PROF+1 
						WHEN OCCUPATION='SINGER' THEN @SING:=@SING+1 
						WHEN OCCUPATION='ACTOR' THEN @ACT:=@ACT+1 END AS ROWNUMBERS,
					CASE WHEN OCCUPATION='DOCTOR' THEN NAME END AS DOCTOR,
					CASE WHEN OCCUPATION='PROFESSOR' THEN NAME END AS PROFESSOR,
					CASE WHEN OCCUPATION='SINGER' THEN NAME END AS SINGER,
					CASE WHEN OCCUPATION='ACTOR' THEN NAME END AS ACTOR 
				  FROM OCCUPATIONS ORDER BY NAME) AS TEMP GROUP BY TEMP.ROWNUMBERS;
				  
		--4.BINARY TREE NODE
			SELECT O.N, CASE WHEN O.P IS NULL THEN 'ROOT'
							 WHEN EXISTS(SELECT * FROM BST WHERE P=O.N) THEN 'INNER'
							 ELSE 'LEAF' END 
					FROM BST O ORDER BY O.N;
					
		--5.NEW COMPANIES
			SELECT C.COMPANY_CODE, C.FOUNDER, 
				COUNT(DISTINCT L.LEAD_MANAGER_CODE), COUNT(DISTINCT S.SENIOR_MANAGER_CODE), 
				COUNT(DISTINCT M.MANAGER_CODE),COUNT(DISTINCT E.EMPLOYEE_CODE) 
			FROM COMPANY C, LEAD_MANAGER L, SENIOR_MANAGER S, MANAGER M, EMPLOYEE E 
			WHERE C.COMPANY_CODE = L.COMPANY_CODE 
				AND L.LEAD_MANAGER_CODE=S.LEAD_MANAGER_CODE 
				AND S.SENIOR_MANAGER_CODE=M.SENIOR_MANAGER_CODE 
				AND M.MANAGER_CODE=E.MANAGER_CODE 
			GROUP BY C.COMPANY_CODE, C.FOUNDER ORDER BY C.COMPANY_CODE;
			
--3.AGGREGATIONS
		--1.QUERY A COUNT OF THE NUMBER OF CITIES IN CITY HAVING A POPULATION LARGER THAN 10000
			SELECT COUNT(ID) FROM CITY WHERE POPULATION>100000;
			
		--2.QUERY THE TOTAL POPULATION OF ALL CITIES IN CITY WHERE DISTRICT IS CALIFORNIA. 
			SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT='CALIFORNIA';
			
		--3.QUERY THE AVERAGE POPULATION OF ALL CITIES IN CITY WHERE DISTRICT IS CALIFORNIA. 
			SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT='CALIFORNIA';
			
		--4.QUERY THE AVERAGE POPULATION FOR ALL CITIES IN CITY, ROUNDED DOWN TO THE NEAREST INTEGER.
			SELECT FLOOR(AVG(POPULATION)) FROM CITY;
			
		--5.QUERY THE DIFFERENCE BETWEEN THE MAXIMUM AND MINIMUM POPULATIONS IN CITY.
			SELECT MAX(POPULATION)-MIN(POPULATION) FROM CITY;
			
		--6.WRITE A QUERY CALCULATING THE AMOUNT OF ERROR AND ROUND IT UP TO THE NEXT INTEGER
			SELECT CEIL(AVG(SALARY)-AVG(REPLACE(SALARY, 0, ''))) FROM EMPLOYEES;
			
		--7.WRITE A QUERY TO FIND THE MAXIMUM TOTAL EARNINGS FOR ALL EMPLOYEES AS WELL AS THE TOTAL NUMBER OF EMPLOYEES 
		 --WHO HAVE MAXIMUM TOTAL EARNINGS. THEN PRINT THESE VALUES AS 2 SPACE-SEPARATED INTEGERS.
			SELECT SALARY*MONTHS, COUNT(*) FROM EMPLOYEE WHERE SALARY*MONTHS=(SELECT MAX(SALARY*MONTHS) FROM EMPLOYEE) GROUP BY SALARY* MONTHS;
			
		--8.WEATHER OBSERVATION STATION 2
			SELECT ROUND(SUM(LAT_N),2), ROUND(SUM(LONG_W),2) FROM STATION;
			
		--9.WEATHER OBSERVATION STATION 13
			SELECT ROUND(SUM(LAT_N),4) FROM STATION WHERE LAT_N BETWEEN 38.7880 AND 137.2345;
			
		--10.WEATHER OBSERVATION STATION 14
			SELECT ROUND(MAX(LAT_N),4) FROM STATION WHERE LAT_N<137.2345;
			
		--11.WEATHER OBSERVATION STATION 15
			SELECT ROUND(LONG_W,4) FROM STATION WHERE LAT_N=(SELECT MAX(LAT_N) FROM STATION WHERE LAT_N<137.2345);
			
		--12.WEATHER OBSERVATION STATION 16
			SELECT ROUND(MIN(LAT_N),4) FROM STATION WHERE LAT_N>38.7880;
			
		--13.WEATHER OBSERVATION STATION 17
			SELECT ROUND(LONG_W,4) FROM STATION WHERE LAT_N=(SELECT MIN(LAT_N) FROM STATION WHERE LAT_N>38.7880);
			
		--14.WEATHER OBSERVATION STATION 18
			SELECT ROUND(ABS((MAX(LAT_N) - MIN(LAT_N)))+ABS((MAX(LONG_W)-MIN(LONG_W))),4) FROM STATION;
			
		--15.WEATHER OBSERVATION STATION 19
			SELECT ROUND(SQRT(((MIN(LAT_N)-MIN(LONG_W))^2)+((MAX(LAT_N)-MAX(LONG_W))^2)),4) FROM STATION;
			
		--16.WEATHER OBSERVATION STATION 20
			SET @CT := (SELECT COUNT(*) FROM STATION);
			SET @ROW_ID := 0;
			SELECT ROUND(AVG(LAT_N),4) AS MEDIAN
			FROM (SELECT * FROM STATION ORDER BY LAT_N) AS ORDERED
			WHERE (SELECT @ROW_ID := @ROW_ID + 1)
			BETWEEN @CT/2.0 AND @CT/2.0 + 1
		
--BASIC JOIN
	--1.ASIAN POPULATION
		SELECT SUM(CITY.POPULATION) FROM CITY INNER JOIN COUNTRY ON CITY.COUNTRYCODE=COUNTRY.CODE WHERE COUNTRY.CONTINENT='ASIA';
		
	--2.AFRICAN CITIES
		SELECT CITY.NAME FROM CITY INNER JOIN COUNTRY ON CITY.COUNTRYCODE=COUNTRY.CODE WHERE COUNTRY.CONTINENT='AFRICA';
		
	--3.AVERAGE POPULATION OF EACH CONTINENT
		SELECT CITY.NAME, FLOOR(AVG(CITY.POPULATION)) FROM CITY INNER JOIN COUNTRY ON CITY.COUNTRYCODE=COUNTRY.CODE;
		
	--4.THE REPORT
		SELECT CASE 
					WHEN G.GRADE<8 THEN 'NULL'
					ELSE S.NAME 
			  END AS NAME, G.GRADE, S.MARKS FROM STUDENTS S, GRADES G 
			  WHERE S.MARKS BETWEEN G.MIN_MARK AND G.MAX_MARK ORDER BY G.GRADE DESC, NAME;
			  
	--5.TOP COMPETITORS
		SELECT H.HACKER_ID, H.NAME
		FROM SUBMISSIONS S
		INNER JOIN CHALLENGES C
		ON S.CHALLENGE_ID = C.CHALLENGE_ID
		INNER JOIN DIFFICULTY D
		ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL 
		INNER JOIN HACKERS H
		ON S.HACKER_ID = H.HACKER_ID
		WHERE S.SCORE = D.SCORE
		GROUP BY H.HACKER_ID, H.NAME
		HAVING COUNT(S.HACKER_ID) > 1
		ORDER BY COUNT(S.HACKER_ID) DESC, H.HACKER_ID ASC;
		
	--6.OLLIVANDER'S INVENTORY
		SELECT WANDS.ID, WANDS_PROPERTY.AGE, WANDS.COINS_NEEDED, WANDS.POWER FROM WANDS JOIN WANDS_PROPERTY 
		ON WANDS.CODE=WANDS_PROPERTY.CODE WHERE WANDS_PROPERTY.IS_EVIL=0
		GROUP BY WANDS.ID, WANDS_PROPERTY.AGE, WANDS.POWER, WANDS.COINS_NEEDED
		HAVING MIN(WANDS.COINS_NEEDED)
		ORDER BY WANDS.POWER DESC, WANDS_PROPERTY.AGE DESC;
		
	--7.CHALLENGES
		SELECT H.HACKER_ID, H.NAME, COUNT(C.CHALLENGE_ID) AS CNT FROM HACKERS H INNER JOIN CHALLENGES C ON H.HACKER_ID=C.HACKER_ID
		GROUP BY H.HACKER_ID,H.NAME
		HAVING CNT= (SELECT COUNT(CHALLENGE_ID) FROM CHALLENGES GROUP BY HACKER_ID ORDER BY COUNT(CHALLENGE_ID) DESC LIMIT 1)
		OR CNT IN (SELECT T.CT FROM (SELECT COUNT(CHALLENGE_ID) AS CT FROM CHALLENGES GROUP BY HACKER_ID) AS T GROUP BY T.CT HAVING COUNT(T.CT)=1)
		ORDER BY CNT DESC, H.HACKER_ID;
		
	--8.CONTEST LEADERBOARD
		SELECT H.HACKER_ID, H.NAME, SUM(SCR) AS TOTAL FROM HACKERS H, (SELECT S1.HACKER_ID AS HAC, S1.CHALLENGE_ID, MAX(S1.SCORE) AS SCR 
		FROM SUBMISSIONS S1 GROUP BY S1.HACKER_ID, S1.CHALLENGE_ID HAVING SCR >0) OTHER
		WHERE H.HACKER_ID=OTHER.HAC
		GROUP BY H.HACKER_ID, H.NAME
		ORDER BY TOTAL DESC, H.HACKER_ID;
		
--ADVANCED JOIN:
	--1.PROJECTS
		SELECT START_DATE, MIN(END_DATE)
		FROM 
			(SELECT START_DATE FROM PROJECTS WHERE START_DATE NOT IN (SELECT END_DATE FROM PROJECTS)) A,
			(SELECT END_DATE FROM PROJECTS WHERE END_DATE NOT IN (SELECT START_DATE FROM PROJECTS)) B
		WHERE START_DATE < END_DATE
		GROUP BY START_DATE
		ORDER BY DATEDIFF(START_DATE, MIN(END_DATE)), START_DATE;
		
	--2.PLACEMENTS
		SELECT S.NAME FROM STUDENTS S JOIN FRIENDS F ON (S.ID = F.ID) 
		JOIN PACKAGES P ON (S.ID = P.ID) JOIN PACKAGES P2 ON (F.FRIEND_ID = P2.ID) WHERE P.SALARY < P2.SALARY ORDER BY P2.SALARY;
		
	--3.SYMMETRIC PAIRS
		SELECT F1.X, F1.Y FROM FUNCTIONS F1 INNER JOIN FUNCTIONS F2 ON F1.Y=F2.X WHERE F1.X=F2.Y AND F2.X=F1.Y AND F1.X<=F1.Y
		GROUP BY F1.X, F1.Y 
		HAVING COUNT(*)>1 OR (COUNT(*)=1 AND F1.X!=F1.Y)
		
	--4.INTERVIEWS
		SELECT CN.CONTEST_ID, CN.HACKER_ID, CN.NAME, SUM(SUM_SUBMI), SUM(SUM_ACCEPT), SUM(SUM_VIEWS), SUM(SUM_UNIQUE) 
		FROM  CONTESTS CN 
		INNER JOIN COLLEGES CL ON CN.CONTEST_ID=CL.CONTEST_ID 
		INNER JOIN CHALLENGES CH ON CL.COLLEGE_ID=CH.COLLEGE_ID
		LEFT OUTER JOIN (SELECT CHALLENGE_ID, SUM(TOTAL_SUBMISSIONS) 
		AS SUM_SUBMI, SUM(TOTAL_ACCEPTED_SUBMISSIONS) AS SUM_ACCEPT FROM SUBMISSION_STATS GROUP BY CHALLENGE_ID) S
		ON S.CHALLENGE_ID=CH.CHALLENGE_ID
		LEFT OUTER JOIN (SELECT CHALLENGE_ID, SUM(TOTAL_VIEWS) AS SUM_VIEWS, SUM(TOTAL_UNIQUE_VIEWS) 
		AS SUM_UNIQUE FROM VIEW_STATS GROUP BY CHALLENGE_ID) V ON CH.CHALLENGE_ID=V.CHALLENGE_ID
		GROUP BY CN.CONTEST_ID, CN.HACKER_ID, CN.NAME
		ORDER BY CN.CONTEST_ID;

--ALTERNATE QUERIES
	--1.DRAWING TRAINGLE 1
		SELECT RPAD('*', 2*LEVEL, ' *') FROM DUAL CONNECT BY LEVEL<=20 ORDER BY RPAD('*', LEVEL, ' *') DESC;
		
	--2.DRAWING TRIANGLE 2.
		SELECT RPAD('*', 2*LEVEL, ' *') FROM DUAL CONNECT BY LEVEL<=20;
		
	--3.EVEN NUMBERS
		SELECT L1 FROM (SELECT LEVEL L1 FROM DUAL CONNECT BY LEVEL<=10) LEV WHERE MOD(L1,2)=0;
	--4.ODD NUMBERS
		SELECT L1 FROM (SELECT LEVEL L1 FROM DUAL CONNECT BY LEVEL<=10) LEV WHERE MOD(L1,2)<>0;
