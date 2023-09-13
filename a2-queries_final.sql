.echo on

/*The crime was a robbery that occured sometime on April 10 2018 and
it took place in Vancouver.*/

/*Let's starts with the crime scene report from Police Department's
Database.*/

--Query #1:
SELECT *
FROM crime_scene_report c
WHERE c.city = 'Vancouver'
AND c.type = 'robbery'
AND c.date = '20180410';

/*The above query prints out the details of a crime from table 
crime_scene_report where city is Vancouver, type of crime is 
robbery and took place on April 10 2018.*/

--Query #2:
SELECT p.id, p.name, p.license_id, p.ssn, p.address_number
FROM person p, drivers_license d
WHERE p.address_street_name = 'Northwestern Dr'
AND d.gender = 'male'
AND d.plate_number LIKE 'O4%'
AND p.license_id = d.id;

/*From the details we got from the crime_scene_report table we try
to find out the witness from tables person and drivers_license who
meet the descriptions we got before.*/

--Query #3
SELECT *
FROM interview i
WHERE i.person_id = '18811';

/*Now that we know the details of the witness, we find out the
testament given by this witness through the table interview.
From the witness' testament we got to know that crime took place 
in SQL Theatre and suggested us to talk to someone who likes to watch
movies a lot. He knows a person who went to watch movies at least 
3 times in 2018.*/

--Query #4
SELECT f.person_id, i.transcript
FROM facebook_event_checkin f, interview i
WHERE f.date = 20180410
AND f.event_name LIKE '%SQL Theatre%'
AND 3 <=
(SELECT COUNT (f1.person_id)
FROM facebook_event_checkin f1
WHERE f1.event_name LIKE '%SQL Theatre%'
AND f.date >= 20180101 AND f.date <= 20181231
AND f1.person_id = f.person_id)
AND f.person_id = i.person_id;

/*After going through statement of the witness, we try to find the 
person suggested by the witness who loves watching movies and was at 
the crime scene. We start looking for the person in table 
facebook_event_checkin who was at SQL Theatre on April 10, 2018 
and has gone to SQL Theatre at least 3 times in 2018. 
After finding that person, we get the statement given by that person
from the table interview.*/  

--Query #5:
SELECT p.id, p.name, f.event_name, f.date
FROM person p, drivers_license d, facebook_event_checkin f
WHERE d.gender = 'female'
AND f.event_name LIKE '%SQL Theatre%'
AND f.date >= 20180201 AND f.date <= 20180331
AND p.license_id = d.id
AND p.id = f.person_id;

/*According to the statement we got from previous query, crime was 
committed by a woman who went to SQL Theatre in March but not once
in February. So we get the details of all women from table driver_
license and person and facebook_event_checkin. Then we get a list
of all the women who went to SQL Theatre between February 1,2018 and 
March 31, 2018. We eliminate all the women who went to SQL Theatre in
February as well as in March and we get the result of a woman named
Caroline Navia.*/
