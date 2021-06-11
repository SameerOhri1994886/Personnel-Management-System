-- Choosing and using the database whose privileges will be granted to the diffrent types of users --

use CegepCollege;

-- Creating the different users --

CREATE USER 'Admin' IDENTIFIED BY 'Password';
CREATE USER 'Mollie Blouin' IDENTIFIED BY 'pw';
CREATE USER 'Andrew Simmons' IDENTIFIED BY 'pw1';
CREATE USER 'David Watson' IDENTIFIED BY 'pw2';

-- Distributing the different types of privileges to different users --

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,INDEX,DROP,ALTER
ON CegepCollege.* TO 'Admin';
GRANT SELECT,CREATE,INSERT
ON CegepCollege.* TO 'Mollie Blouin';
GRANT SELECT,CREATE,INSERT
ON CegepCollege.* TO 'Andrew Simmons';
GRANT SELECT,CREATE,INSERT
ON CegepCollege.* TO 'David Watson';

-- Reloading the grant tables in the database --

FLUSH PRIVILEGES;

-- To see all the databases to which the user is having access --

SHOW DATABASES;