/* Trigger on a the [orderItem] to update the field, ‘quantityInStock’  from the item table whenever an insert occurs. */

delimiter $$

create trigger QuantityInStock
after insert on orderItem

for each row begin
update item
set item.quantityInStock = item.quantityInStock - new.quantity
where item.itemId = new.itemId;
end;
$$

delimiter ;

/* Performing math & CRUD statements: if the field ‘userStatusId’ is updated, and the value is different from the value currently in the table, the trigger will insert into the activityLog table. */

delimiter $$

create trigger ’UserStatusChange’
after update on users
for each row begin
if NOT old.userStatusId = new.userStatusId then
insert into activityLog (activityDate, activityText, userId)
values (now(), "userStatusId updated", new.userid);
end if;

end;
$$

delimiter ;

/* Function that accepts an item Id as input and returns the number of items in stock. */

delimiter $$

CREATE FUNCTION GetItemStock(givenId int(11))
RETURNS INT(11)
BEGIN
RETURN (  select quantityInStock
from item where item.itemId = givenId);
END$$

delimiter ;

/* Function that accepts an order Id as input and returns the sum total price of all items on that order multiplied by the quantity ordered. */

delimiter $$

DROP FUNCTION IF EXISTS ItemQuantitySum $$
CREATE FUNCTION ItemQuantitySum(givenId int(11))
RETURNS decimal(12, 4)
BEGIN
declare final decimal(12, 4);
select sum(quantity *item.itemPrice) into final from orderItem
join item on orderitem.itemId = item.itemId
where orderId = givenId;

return final;
END$$
delimiter ;

/* Stored procedure that accepts a user Id and returns the user’s full name, occupation, the count to all orders they placed, the number of DVDs they own, and the number of vehicles they own. */

delimiter $$
DROP PROCEDURE IF EXISTS UserData $$

CREATE procedure  UserData(IN givenID int(11), OUT fullname VARCHAR(300),
OUT occupa VARCHAR(250), OUT ordercount int, OUT dvdCount int, OUT vehicleCount int)

BEGIN

select concat(users.firstname,' ', users.middleName,' ', users.lastname) into fullname
from users
where users.userid like givenID;

select occupation.occupation into occupa
from occupation
join users on occupation.occupationId = users.occupationId
where users.userid like givenID;

select count(orders.orderId) into ordercount
from users
join orders on orders.userid = users.userid
where users.userid like givenID;

select count(dvd.dvdId) into dvdCount
from users
join userDVD on userDVD.userid = users.userid
where users.userid like givenID;

select count(dvd.dvdId) into vehicleCount
from users
join userVehicle on userVehicle.userid = users.userid
where users.userid like givenID;

END$$

delimiter ;
