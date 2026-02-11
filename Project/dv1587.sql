CREATE DATABASE dv1587;

SHOW DATABASES;

USE dv1587;

CREATE TABLE Names (Name VARCHAR(20) NOT NULL);
select * FROM Names;
INSERT INTO Names (Name) values ('Testing Testing');
select * from Names;
drop table Names;