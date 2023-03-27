/* Create Database */

CREATE DATABASE vet_clinic;

/* Create Table Animals */

CREATE TABLE animals (
  id int,
  name varchar(50),
  date_of_birth date,
	scape_attemps int,
	neutered bool,
	weight_kg decimal
);
