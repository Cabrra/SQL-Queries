/* Basic insertion into a existing table */

insert into users
(firstname ,lastname, username, password, DOB, userTypeId, userStatusId
) values (
'Awesome', 'Name', 'Jake', '1234', 'DOB', 1, 1
);

/* Insert new email  address to an existing user */

insert into userEmail
(userId ,userEmail, userEmailTypeId
) values (
1, 'email@email.com', 1
);

/* Example of populating a table [vehicleNormal] by joining the vehicle, vehicleMake, vehicleModel, vehicleDrive and vehicleFuelType tables. */

insert into vehicleNormal (vehicleId , makeId, modelId, Year, cylinders, driveID, mpgHighway, mpgCity, fuelTypeId)(
select vehicleId, vehicleMakeID, vehiclemodelId, Year, cylinders, vehicledriveId, mpgHighway, mpgCity, vehiclefuelTypeId
from vehicle
join vehiclemake on vehicle.make = vehiclemake.make
join vehicleModel on vehicle.model = vehicleModel.model
join vehicleDrive  on vehicle.drive = vehicleDrive.drive
join vehicleFuelType  on vehicle.fuelType = vehicleFuelType.fuelType
);


