-- Crear un keyspace ayoub_ievgen
CREATE KEYSPACE ayoub_ievgen  
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Mostrar els keyspaces disponibles
DESCRIBE KEYSPACES;

-- Utilitzar el keyspace creat
USE ayoub_ievgen;

-- Crear una taula asix
CREATE TABLE asix (  
    id UUID PRIMARY KEY,  
    nom TEXT,  
    edat INT  
);

-- Insertar un registre a la taula asix
INSERT INTO asix (id, nom, edat) VALUES (uuid(), 'Ievgen', 20);

-- Consultar tots els registres de la taula asix
SELECT * FROM asix;
