/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL,date_of_birth DATE NOT NULL,escape_attempts INT NOT NULL,neutered 
BOOL NOT NULL,weight_kg DECIMAL(50,2) NOT NULL
);

ALTER TABLE animals ADD species VARCHAR(50);
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,full_name VARCHAR NOT NULL,age INT NOT NULL);
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL);
ALTER TABLE animals DROP species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);
CREATE TABLE vets(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR NOT NULL, age INT NOT NULL, date_of_graduation DATE);

CREATE TABLE specializations(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, vets_id INT,species_id INT);

ALTER TABLE specializations ADD FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE specializations ADD FOREIGN KEY(vets_id) REFERENCES vets(id);
CREATE TABLE visits(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, animals_id INT,vets_id INT, visit_date DATE);

ALTER TABLE visits ADD FOREIGN KEY(animals_id) REFERENCES animals(id);
ALTER TABLE visits ADD FOREIGN KEY(vets_id) REFERENCES vets(id);

