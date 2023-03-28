/* Queries based on project requirements */

SELECT * from animals WHERE name LIKE '%mon%';

SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name from animals WHERE neutered = true AND escape_attemps < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';

SELECT name , escape_attemps from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name not LIKE 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 and 17.3;

/* Update inside a transaction and rollback*/
Begin;

UPDATE animals
set species = 'unespecified';

Rollback;

/* Update inside a transaction and commit*/
Begin;

UPDATE animals
set species = 'digimon'
where name like '%mon';

SELECT * from animals;

UPDATE animals
set species = 'digimon'
where especies is null;

SELECT * from animals;

commit;


/* Delete inside a transaction and rollback*/
Begin;

DELETE from animals;

SELECT * from animals;

Rollback;

/* Update insde transaction with savepoint, rollback and commit*/
Begin;

Delete from animals
where date_of_birth > '2022-01-01';

SELECT * from animals;

savepoint SP1;

UPDATE animals
set weight_kg = weight_kg * -1;

SELECT * from animals;

Rollback to SP1;

SELECT * from animals;

UPDATE animals
set weight_kg = weight_kg * -1
where weight_kg < 0;

SELECT * from animals;

commit;


/*  Group by queries */

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
where escape_attemps = 0;

SELECT avg(weight_kg) FROM animals;

SELECT neutered, COUNT(escape_attemps) FROM animals
GROUP BY neutered;

SELECT  species, max(weight_kg), min(weight_kg) FROM animals
GROUP BY species;

SELECT  species, avg(escape_attemps) FROM animals
where date_of_birth between '1990-01-01' and '2000-12-31'
GROUP BY species;
