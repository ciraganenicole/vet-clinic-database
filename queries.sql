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
SELECT species from animals WHERE species='unspecified';
ROLLBACK;
SELECT * from animals

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species is NULL;
SELECT species from animals WHERE species='unspecified';
COMMIT;
ELECT * from animals

BEGIN;
DELETE * FROM animals;
ROLLBACK;
SELECT * from animals


BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022/01/01';

-- Create a savepoint for the transaction.
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg=(SELECT weight_kg FROM animals WHERE weight_kg < 0)*-1;
COMMIT;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) from animals WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;
SELECT name FROM animals WHERE escape_attempts=(SELECT MAX(escape_attempts) FROM animals);
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31';
SELECT name FROM animals as a INNER JOIN owners as o ON a.owner_id = o.id WHERE o.full_name ='Melody Pond';
SELECT a.name FROM animals as a INNER JOIN species as s ON species_id = s.id WHERE s.name ='Pokemon';
SELECT o.full_name, a.name FROM owners as o FULL JOIN animals as a ON o.id = a.owner_id;
SELECT s.name,COUNT(*) FROM animals as a INNER JOIN species as s ON a.species_id = s.id GROUP BY s.name;
SELECT a.name FROM animals as a INNER JOIN owners as o ON a.species_id = o.id WHERE o.full_name='Jennifer Orwell';
SELECT a.name FROM animals as a INNER JOIN owners as o ON a.owner_id = o.id WHERE o.full_name='Dean Winchester' AND a.escape_attempts=0;
SELECT o.full_name, COUNT(*) as c FROM owners as o INNER JOIN animals as a ON a.owner_id = o.id GROUP BY o.full_name ORDER by c DESC LIMIT 1;
SELECT name FROM animals WHERE id = (SELECT animals_id FROM visits WHERE vets_id = (SELECT id FROM vets WHERE name LIKE 'William Tatcher') ORDER BY visit_date DESC limit 1);

SELECT COUNT(name) FROM animals as a JOIN visits as v ON a.id = v.animals_id WHERE v.vets_id=(SELECT id FROM vets WHERE name='Stephanie Mendez');
SELECT v.name, sp.name FROM vets as v FULL JOIN specializations as s ON  v.id = s.vets_id FULL JOIN species as sp ON sp.id = s.species_id;
SELECT a.name,v.visit_date, ve.name  from animals as a JOIN visits as v ON a.id = v.animals_id JOIN vets as ve ON ve.id = v.vets_id WHERE v.vets_id= (SELECT id FROM vets WHERE name='Stephanie Mendez') AND (v.visit_date BETWEEN '2020/04/01' AND '2020/08/30');
SELECT a.name, COUNT(v.visit_date) as c FROM animals as a JOIN visits as v ON a.id = v.animals_id GROUP by a.name ORDER BY c DESC LIMIT 1;
SELECT a.name, ve.name, v.visit_date from animals as a JOIN visits as v on a.id = v.animals_id JOIN vets as ve on ve.id = v.vets_id WHERE ve.name='Maisy Smith' ORDER by v.visit_date asc LIMIT 1;
SELECT a.name, ve.name, v.visit_date from animals as a JOIN visits as v on a.id = v.animals_id JOIN vets as ve on ve.id = v.vets_id ORDER by v.visit_date asc LIMIT 1;
select count(*) from visits 
    left join animals on animals.id = visits.animals_id 
    left join vets on vets.id = visits.vets_id
    where animals.species_id not in (select animals.species_id from specializations where specializations.vets_id = vets.id);
select species.name, count(*) from visits left join animals on animals.id = visits.animals_id 
    left join species ON animals.species_id = species.id
    left join vets ON vets.id = visits.vets_id where vets.name = 'Maisy Smith' group by species.name;

