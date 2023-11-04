SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT FROM animals

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals
COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_animals_after_2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_animals_after_2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) AS animal_count FROM animals;

SELECT COUNT(*) AS animal_count FROM animals;
SELECT COUNT(*) AS animal_never_escape FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT neutered, COUNT(*) AS escape_most FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01' GROUP BY species;

SELECT name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name AS owner_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;
SELECT species.name AS species_name, COUNT(species.name) AS count FROM species JOIN animals ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name AS animal_name, owners.full_name AS owner_name
FROM animals
JOIN owners ON owners.id = animals.owner_id 
JOIN species ON species.id = animals.species_id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name AS animal_name, owners.full_name AS owner_name
FROM animals
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owner_name
ORDER BY animal_count DESC LIMIT 1;

SELECT vets.name, animals.name,  visits.visit_date
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visit_date DESC LIMIT 1;

SELECT vets.name AS vet_name,  COUNT(vets.name) animals_visited
  FROM vets
  JOIN visits ON visits.vet_id = vets.id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name;

SELECT vets.name AS vet_name, species.name
  FROM vets 
  LEFT JOIN specializations ON specializations.vet_id = vets.id 
  LEFT JOIN species On species.id = specializations.species_id;

SELECT animals.name AS animals_name, visits.visit_date
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-1' AND '2020-08-30';

SELECT animals.name AS animal_name, COUNT(animals.name) AS visit_number
  FROM animals
  JOIN visits ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY visit_number DESC LIMIT 1

SELECT vets.name AS vet_name, animals.name AS animal_name, visits.visit_date
  FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name  = 'Maisy Smith'
  ORDER BY visit_date
  LIMIT 1;

SELECT * FROM animals
  JOIN visits ON visits.animal_id = animals.id
  JOIN vets ON vets.id = visits.vet_id
  ORDER BY visits.visit_date
  LIMIT 1;

SELECT COUNT(*) AS num_visits
  FROM visits
  JOIN animals ON animals.id = visits.animal_id
  JOIN vets ON vets.id = visits.vet_id
  LEFT JOIN specializations ON specializations.vet_id = vets.id AND specializations.species_id = animals.species_id
  WHERE specializations.vet_id IS NULL;

SELECT species.name AS species_name
  FROM species
  JOIN specializations ON specializations.species_id = species.id
  JOIN vets ON vets.id = specializations.vet_id
  WHERE vets.name = 'Maisy Smith' GROUP BY species.name
  ORDER BY COUNT(*) DESC LIMIT 1;