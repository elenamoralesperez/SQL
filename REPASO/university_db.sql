-- 1. Creación de base de datos y tabla
-- Creamos base de datos; borramos con DROP DATABASE
CREATE DATABASE university_db;

CREATE TABLE IF NOT EXISTS students_db (
    -- Con BIGSERIAL cada vez que añades una fila, la base de datos mete el siguiente número automáticamente.
    student_id BIGSERIAL PRIMARY KEY, 
    first_name VARCHAR(100) NOT NULL,        
    last_name VARCHAR(100) NOT NULL,
    enrollment_date DATE NOT NULL,
    grade NUMERIC(4,2)
);

-- 2. Modificación de tabla
-- Añade una columna city de tipo VARCHAR(100).
ALTER TABLE students_db ADD COLUMN city VARCHAR(100);


-- Modifica grade para que sea tipo INTEGER.
ALTER TABLE students_db ALTER COLUMN grade TYPE INTEGER;

-- Elimina la columna city.
ALTER TABLE students_db DROP COLUMN city;




-- 3. Inserción de datos
INSERT INTO students_db (first_name, last_name, enrollment_date, grade)
VALUES ('Ana', 'Lopez', '2019-03-12', 85),
('Ana', 'Martinez', '2021-10-05', 90),
('Carlos', 'Perez', '2020-06-18', 72),
('Lucia', 'Gomez', '2022-02-25', 95),
('Mario', 'Sanchez', '2018-11-30', 88),
('Elena', 'Morales', '2024-01-14', 100),
('David', 'Ruiz', '2019-07-09', 60),
('Sara', 'Navarro', '2023-04-21', 78),
('Jorge', 'Torres', '2018-09-02', 55),
('Laura', 'Diaz', '2021-12-03', 93);




-- 4. Consultas básicas
-- Muestra todos los estudiantes.
SELECT * FROM students_db;

-- Muestra solo los first_name y grade de los estudiantes con nota superior a 80.
SELECT first_name, grade FROM students_db WHERE grade > 80;

-- Muestra los estudiantes inscritos antes de 2021.
-- Comillas obligatorias, y formato DATE 
SELECT * FROM students_db WHERE enrollment_date < '2021-01-01';


-- Muestra el estudiante cuyo id sea 4.
SELECT * FROM students_db WHERE student_id = 4;




-- 5. Actualizar y eliminar
-- Actualiza la nota (grade) del estudiante con id 3 a 95.
UPDATE students_db SET grade = 95 WHERE student_id = 3;


-- Elimina el estudiante cuyo id sea 7.
DELETE FROM students_db WHERE student_id = 7;


-- Elimina todos los estudiantes con nota inferior a 70.
DELETE FROM students_db WHERE grade < 70;




-- 6. Orden y rangos
-- Muestra todos los estudiantes ordenados por enrollment_date de más reciente a más antiguo.
SELECT * FROM students_db ORDER BY enrollment_date DESC;

-- Muestra los estudiantes con grade entre 70 y 90.
SELECT * FROM students_db WHERE grade BETWEEN 70 AND 90;




-- 7. DISTINCT y concatenación
-- Muestra los nombres (first_name) sin repetir.
SELECT DISTINCT first_name FROM students_db;

-- Muestra el nombre completo concatenando first_name y last_name como alias nombre_completo.
SELECT first_name || ' ' || last_name AS nombre_completo FROM students_db;




-- 8. LIKE y NOT LIKE
-- Muestra los estudiantes cuyo apellido contenga la letra “e”.
SELECT * FROM students_db WHERE last_name LIKE '%e%';

-- Muestra los estudiantes cuyo nombre termine en “a”.
SELECT * FROM students_db WHERE first_name LIKE '%a';

-- Muestra los estudiantes cuyo nombre no contenga la letra “o”.
SELECT * FROM students_db WHERE first_name NOT LIKE '%o%';




-- 9. Funciones agregadas y GROUP BY
-- Muestra el número total de estudiantes.
SELECT COUNT(student_id) AS total_estudiantes FROM students_db;

-- Muestra la nota media (AVG) de todos los estudiantes.
SELECT AVG(grade) FROM students_db;

-- Muestra la nota más alta y la más baja.
SELECT MIN(grade) AS nota_minima, MAX(grade) AS nota_maxima FROM students_db;

-- Agrupa por grade y muestra cuántos estudiantes tienen cada nota.
SELECT grade, COUNT(*) AS cantidad FROM students_db
GROUP BY grade
ORDER BY grade ASC;



-- 10. Cálculos con columnas y ROUND()

-- Añade una columna scholarship (NUMERIC(10,2)).(BECA)
ALTER TABLE students_db ADD COLUMN scolarship NUMERIC(10,2);

-- Actualiza esta columna con un valor calculado: el 10% del grade (por ejemplo: grade * 0.10).
UPDATE students_db SET scolarship = grade * 0.10; 

-- Haz una consulta que muestre:
-- first_name, grade,
-- una columna calculada bonus que sea grade * 0.05
-- una columna total_grade que sea grade + bonus, redondeada a 2 decimales.
-- Usa alias claros: bonus y total_grade.

SELECT 
    first_name, 
    grade,
    ROUND(grade * 0.05, 2) AS bonus,
    ROUND(grade + (grade * 0.05), 2) AS total_grade
FROM students_db;