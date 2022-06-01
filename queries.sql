/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered=TRUE;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * from animals WHERE weight_kg >=10.4 and weight_kg <= 17.3;
BEGIN;
update animals set species='unspecified' where species is null;
ROLLBACK;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species is NULL;
COMMIT;

BEGIN;
DELETE * FROM animals
ROLLBACK;


BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022/01/01';

-- Create a savepoint for the transaction.
SAVEPOINT sp1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1;

-- Rollback to the savepoint
ROLLBACK TO sp1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg=(SELECT weight_kg FROM animals WHERE weight_kg < 0)*-1;

-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) from animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name FROM animals WHERE escape_attempts=(SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31';
