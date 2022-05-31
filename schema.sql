/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR NOT NULL,date_of_birth DATE NOT NULL,escape_attempts INT NOT NULL,neutered 
BOOL NOT NULL,weight_kg DECIMAL(50,2) NOT NULL
);
