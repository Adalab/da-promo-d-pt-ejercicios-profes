
CREATE SCHEMA bbdd_empleadas;

CREATE TABLE bbdd_empleadas.empleadas (
    id SERIAL PRIMARY KEY,      
    salario FLOAT,      
    nombre VARCHAR(50) NOT NULL,          
    apellido VARCHAR(50),        
    email VARCHAR(100) UNIQUE,  
    teléfono INT,        
    ciudad VARCHAR(50),         
    país VARCHAR(50)             
);


INSERT INTO bbdd_empleadas.empleadas (salario, nombre, apellido, email, teléfono, ciudad, país)
VALUES (2500, 'Ana', 'González', 'ana@adalab.es', '654785214', 'Madrid', 'España');


SELECT * FROM bbdd_empleadas.empleadas;