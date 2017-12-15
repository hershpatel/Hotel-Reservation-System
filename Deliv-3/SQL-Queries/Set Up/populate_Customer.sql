#clear and populate Customer DB

DELETE FROM `customer`
WHERE `CID` >=1;

ALTER TABLE `customer` AUTO_INCREMENT = 1 ;

INSERT into customer (`username`, `password`, `name`, `email`, `address`, `PHONE_NUM`) 
VALUES ('tanviparikh', '$5$rounds=535000$Qz0XvJE8ANPjDgHS$7n2eKORfMtvxuOc6ghI13rKTpJpYTiUAkhtmWesd7G/', 'Tanvi', 'tanvi', 'boi', '1234567890'),
('hershpatel', '$5$rounds=535000$pATprEP/pcwTAZKO$CXGD8gBoNMNkI3eXZBVKS5iVMzmK6iKQj1MO4Viil.B', 'Hersh', 'hersh', 'yoyo', '1234567890'),
('saakethkrosuri', '$5$rounds=535000$e0FGSezaaidJF3w.$IjS6FKTVVt6zcG11yV8NcpPQZcqeEuwWD7Rz8xwzI3/', 'Saaketh', 'saaketh', '345', '1234567890'),
('madisonling', '$5$rounds=535000$D5QxFikU4BQMH0jp$ffRJoGp03haGV.SXgcLKiYbMsidUPLqXe6pkP2zLzs4', 'Madison Ling', 'mady', 'ergaerg', '1234567890'),
('admin', '$5$rounds=535000$xfS/wbqA4kMTOzj3$Cehq1Z3pGFVxkhSOuHxtnerRZVXFABe6bHVJ4OJOXt7', 'admin', 'admin', 'admin', '1234567890');