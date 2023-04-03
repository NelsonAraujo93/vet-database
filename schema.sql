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

/* Create TABLE vets */

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name varchar(50),
  age int,
  date_of_graduation date
);

/* Create TABLE specializations */

CREATE TABLE specializations (
  vets_id int,
  species_id int,
  CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id),
  CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id),
  PRIMARY KEY (vets_id, species_id)
);

/* Create TABLE visits */

CREATE TABLE visits (
  vets_id int,
  animals_id int,
  date_of_visit date,
  CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id),
  CONSTRAINT fk_animals FOREIGN KEY (animals_id) REFERENCES animals (id),
);

/* Alter Table on owners */
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


/*INDEXES CREATED*/
CREATE INDEX animals_id_desc_index ON visits(animals_id DESC);
CREATE INDEX vets_id_index ON visits(vets_id DESC);
CREATE INDEX owners_email_index ON owners(email DESC);