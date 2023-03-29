/* Queries based on project requirements */

SELECT * from animals WHERE name LIKE '%mon';

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
WHERE name like '%mon';

SELECT * from animals;

UPDATE animals
set species = 'digimon'
WHERE especies is null;

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
WHERE date_of_birth > '2022-01-01';

SELECT * from animals;

savepoint SP1;

UPDATE animals
set weight_kg = weight_kg * -1;

SELECT * from animals;

Rollback to SP1;

SELECT * from animals;

UPDATE animals
set weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * from animals;

commit;


/*  Group by queries */

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attemps = 0;

SELECT avg(weight_kg) FROM animals;

SELECT neutered, COUNT(escape_attemps) FROM animals
GROUP BY neutered;

SELECT  species, max(weight_kg), min(weight_kg) FROM animals
GROUP BY species;

SELECT  species, avg(escape_attemps) FROM animals
WHERE date_of_birth between '1990-01-01' and '2000-12-31'
GROUP BY species;


/*  JOIN queries */

SELECT O.full_name as owner_name, A.name as animal_name
FROM owners O
JOIN animals A ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT S.name as type, A.name as animal_name
FROM species S
JOIN animals A ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT O.full_name as owner_name, A.name as animal_name
FROM owners O
FULL JOIN animals A ON A.owner_id = O.id;

SELECT S.name, COUNT(A.*) 
FROM species S
JOIN animals A ON A.species_id = S.id
Group by S.name;

SELECT O.full_name as owner_name, A.name as animal_name
FROM owners O
JOIN animals A ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell'
AND A.species_id = 2;

SELECT O.full_name as owner_name, A.name as animal_name
FROM owners O
JOIN animals A ON A.owner_id = O.id
where O.full_name = 'Dean Winchester'
AND A.escape_attemps = 0;

SELECT O.full_name as owner_name, COUNT(A.*) as animal_quantity
FROM owners O
FULL JOIN animals A ON A.owner_id = O.id
GROUP BY owner_name
ORDER BY animal_quantity DESC;