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

/* SESSION 4 QUERIES*/

SELECT V.name as vets_name, A.name as animal_name, B.date_of_visit
FROM vets V
JOIN visits B ON B.vets_id = V.id
JOIN animals A ON B.animals_id = A.id
WHERE V.id = 1
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT V.name, COUNT(DISTINCT A.name) as diferent_animals
FROM vets V
JOIN visits B ON B.vets_id = V.id
JOIN animals A ON B.animals_id = A.id
WHERE V.id = 3
GROUP BY V.name;

SELECT V.name as vets_name, Z.name as specialization_name
FROM vets V
FUll JOIN specializations S ON S.vets_id = V.id
FULL JOIN species Z ON S.species_id = Z.id;

SELECT V.name as vets_name, A.name as animals_name, S.date_of_visit
FROM vets V
FUll JOIN visits S ON S.vets_id = V.id
FULL JOIN animals A ON S.animals_id = A.id
where V.id = 3 AND S.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT A.name as animals_name, COUNT(V.*) as visits
FROM visits V
JOIN animals A ON V.animals_id = A.id
GROUP BY animals_name
ORDER BY visits DESC
LIMIT 1;

SELECT V.name, A.name as animal_name, B.date_of_visit
FROM vets V
JOIN visits B ON B.vets_id = V.id
JOIN animals A ON B.animals_id = A.id
WHERE V.id = 2
ORDER BY B.date_of_visit ASC
LIMIT 1;

SELECT B.date_of_visit, V.name as vet_name, V.age,V.date_of_graduation, Z.name as specialization, A.name as animal_name, A.date_of_birth, A.escape_attemps, A.weight_kg
FROM vets V
JOIN visits B ON B.vets_id = V.id
JOIN animals A ON B.animals_id = A.id
JOIN specializations S ON S.vets_id = V.id
JOIN species Z ON S.species_id = Z.id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT A.name as animal_name, Z.name,  V.name, V.age, S.species_id
FROM animals A
FULL JOIN visits B ON B.animals_id = A.id
FULL JOIN species Z ON A.species_id = Z.id
FULL JOIN vets V ON V.id = B.vets_id
FUll JOIN specializations S ON S.vets_id = V.id
WHERE S.species_id is null
or S.species_id != A.species_id AND V.id != 3;

SELECT Z.name as species, COUNT(A.*) as animal_frec
FROM animals A
FULL JOIN visits B ON B.animals_id = A.id
FULL JOIN species Z ON A.species_id = Z.id
FULL JOIN vets V ON V.id = B.vets_id
FUll JOIN specializations S ON S.vets_id = V.id
WHERE V.name = 'Maisy Smith'
GROUP BY species
ORDER BY animal_frec DESC
LIMIT 1;