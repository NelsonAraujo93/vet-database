/* Queries based on project requirements */

SELECT * from animals WHERE name LIKE '%mon%';

SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name from animals WHERE neutered = true AND escape_attemps < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';

SELECT name , escape_attemps from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name not LIKE 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 and 17.3;