CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

CREATE TABLE vets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE visits(animal_id INTEGER,
  vet_id INTEGER, 
  PRIMARY KEY(animal_id, vet_id),
  visit_date Date,
  FOREIGN KEY (animal_id) REFERENCES animals (id)
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);

CREATE TABLE specializations(vet_id INTEGER,
  species_id INTEGER,
  PRIMARY KEY(vet_id, species_id), 
  FOREIGN KEY(vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX index_visits_animal_id ON visits(animal_id);
CREATE INDEX idx_visits_vet_id ON visits(vet_id);
CREATE INDEX idx_owners_email ON owners(email);