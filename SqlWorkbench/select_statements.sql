/* Basic select */

Select * from users where username = 'Jake';

/* Select the user and their emails. Filter on userId. */

Select users.userId, firstname, lastname, userEmail
from users
join userEmail
on  userEmail.userId = users.userId;

/* Select the new user and their phone numbers with the phone type. Filter on userId. */

Select users.userId, firstname, lastname, userPhone, userPhoneType
from users
join userPhone
on  userPhone.userId = users.userId
join userPhoneType
on  userPhone.userPhoneTypeId = userPhoneType.userPhoneTypeId;

/* Display the users' full name as a single field. */

select concat(firstname,' ',lastname) as fullname
from 	users
where lastname = 'Steady';

/* Affected rows: 0  Found rows: 3  Warnings: 0  Duration for 1 query: 0.406 sec. */

/* Loop from 1 to 100 to return the count of DVD within that price range.
   Example Data: 	
	DVDs less that $1, 	
	DVDs between $1.01 and $2.00
	DVDs between $2.01 and $3.00
*/

select n,
(select count(*) countDVD
from 	dvd
where price > n -1 and price <= n
) as countDVD
from 	numbers

/* Loop from 0 to 16 to use inline views and retrieve the number of vehicles  with the matching number of cylinders. */

select n,
CASE when vehicleCount.cylinders is not null THEN vehicleCount.cylinders else 0 end as counter
from 	numbers
left join (
select cylinders, count(*) from vehicle
where vehicle.year = 1990
group by cylinders
) as vehicleCount on vehicleCount.cylinders = numbers.n
where numbers.n <= 16;
