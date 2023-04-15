#1. Display all drivers who earn less than $56,000 a year. The resulting list should be
ordered on driver status in ascending order and within each driver status in
descending order by salary. 

SELECT * dr_drvname AS name, dr_drvstatus AS status, dr_salary AS salary
FROM driver
WHERE dr_salary < '56000'
ORDER BY dr_drvstatus, dr_salary desc;

#2. Display the name and hiredate of all drivers who were hired between January 1,
1940 and December 12, 2005. Display the qualifying drivers in ascending order by
name. 

SELECT dr_drvname AS name, dr_hiredate AS "HIRE DATE"
FROM driver
WHERE dr_hiredate BETWEEN '1-JAN-1940' AND '12-DEC-2005'
ORDER BY dr_drvname;

#3 Display the maximum, the minimum and the average salary for all drivers in each
driver status. 

SELECT dr_drvstatus AS status, max(dr_salary) AS "MAX SALARY", min(dr_salary) AS "MIN SALARY", avg(dr_salary) AS "AVG SALARY"
FROM driver
GROUP BY dr_drvstatus;

#4 Display the names of those drivers who have never been assigned to drive a shift. 

SELECT dr_drvname AS name
FROM driver
WHERE dr_drvnum NOT IN(SELECT shift.sh_drvnum FROM SHIFT);

#5 Display all cabs with a cab number that begins with the digit zero (0). The results
should be displayed in order by the make of the cab and then by the date of purchase. 

SELECT ca_cabnum AS "CAB NUMBER", ca_make AS make, ca_purdate AS "PURCHASE DATE"
FROM cab 
WHERE ca_cabnum LIKE '0%'
ORDER BY ca_make, ca_purdate;

#6. Display the name, make, model and year for all cabs that have had some type of
"replacement". Be sure to account for the different cases that could be used to used to
represent words like “replace” and “replacement.”

SELECT ca_cabnum AS "CAB NUMBER", ca_make AS make, ca_model AS model, ca_year AS "CAB YEAR"
FROM cab JOIN maintain
ON cab.ca_cabnum = maintain.ma_cabnum
WHERE maintain.ma_maintype LIKE 'Replace%';

#7. Display all drivers whose name starts with the letter "S" and who live in Houston.
Order the results in ascending order by driver name.

SELECT dr_drvname AS "DRIVER NAME"
FROM driver
WHERE dr_drvname LIKE 'S%'
AND dr_drvcity = 'Houston'
ORDER BY dr_drvname;

#8. Display the names of those drivers not qualified to drive any cabs

SELECT dr_drvname AS name
FROM driver
WHERE dr_drvnum NOT IN(select qu_dr_drvnum from qualification);

#9. Display all drivers with a "Pay Before" status whose monthly salary is between $4000
and $4700. 

SELECT dr_drvname AS name
FROM driver
WHERE dr_drvstatus = 'Pay Before'
AND dr_salary/12 BETWEEN '4000' and '4700';

#10. Display the name, city and state of all drivers who live in a non-Houston zip code.
Incidentally, all Houston zip codes begin with 770. Order the result in ascending
order by zip code. 

SELECT dr_drvname AS name, dr_drvcity AS city, dr_drvstate AS state
FROM driver
WHERE dr_drvzip NOT LIKE '770%'
ORDER BY dr_drvzip;

#11. Display the cab number, make, and model of the cabs that have never been involved
in an incident.

SELECT ca_cabnum AS "CAB NUMBER", ca_make AS make, ca_model AS model
FROM cab
WHERE ca_cabnum NOT IN(SELECT ic_cabnum from incident);

#12. Display the number of maintenance activities performed on each day in ascending
order by maintenance date. 

SELECT ma_maindate AS date, count(ma_maintype) AS "# OF MAINTENANCE"
FROM maintain
GROUP BY ma_maindate
ORDER BY ma_maindate;

#13. Display the cab number, make, model and license number of all cabs with either a
Texas or Louisiana license number. The result should be displayed in ascending
order by license number. 

SELECT ca_cabnum AS "CAB NUMBER", ca_make AS make, ca_model AS model, ca_licnum AS "LICENSE NUMBER"
FROM cab
WHERE ca_lic_num LIKE 'TX%'
OR ca_licnum LIKE 'LA%'
ORDER BY ca_licnum;

#14. Display all shifts assigned to drivers who have a "DO NOT RESERVE" status.
Include in your results the name of the driver and the driver status.

SELECT sh_wkshift AS shift, dr_drvname AS name, dr_drvstatus AS status
FROM shift join driver
on shift.sh_drvnum = driver.dr_drvnum
WHERE dr_drvstatus = 'Do Not Reserve';

