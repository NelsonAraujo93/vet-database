/* Create Database */

CREATE DATABASE vet_clinic;

/* Create Table Animals */

CREATE TABLE animals (
  id int,
  name varchar(50),
  date_of_birth date,
	escape_attemps int,
	neutered bool,
	weight_kg decimal
);

ALTER TABLE animals
ADD species varchar(50);


/* Create TABLE owners */

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name varchar(50),
	age int
);

/* Create TABLE species */

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name varchar(50)
);

/* ALTER TABLE species */

ALTER TABLE animals
DROP id;

ALTER TABLE animals
ADD id SERIAL
ADD PRIMARY KEY (id);


ALTER TABLE animals
add species_id int;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals
add owner_id int;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners (id);