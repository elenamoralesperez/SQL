CREATE TABLE IF NOT EXISTS department (
    id BIGINT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_location VARCHAR(100) NOT NULL
)


CREATE TABLE IF NOT EXISTS project (
    id BIGINT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget INTEGER NOT NULL
)


CREATE TABLE IF NOT EXISTS empleados (
    id BIGINT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    salary INTEGER NOT NULL,
    department_id BIGINT NOT NULL REFERENCES department(id),
    project_id BIGINT NOT NULL REFERENCES project(id)
)


INSERT INTO department (id, department_name, department_location) VALUES 
(1, 'Ventas', 'Madrid'),
(2, 'IT', 'Barcelona'),
(3, 'RRHH', 'Madrid'),
(4, 'Contabilidad', 'Sevilla'),
(5, 'Marketing', 'Valencia');

INSERT INTO project (id, project_name, budget) VALUES 
(101, 'CRM Upgrade', 150),
(102, 'Expansión Global', 300),
(103, 'Reclutamiento Junior', 250),
(104, 'Auditoría Anual', 450),
(105, 'Campaña Digital Q4', 800);

INSERT INTO empleados (id, first_name, last_name, salary, department_id, project_id) VALUES 
(1, 'Ana', 'Gómez', 6500, 1, 102),
(2, 'Pablo', 'Ruiz', 7200, 2, 101),
(3, 'Elena', 'Torres', 4800, 3, 103),
(4, 'David', 'López', 8500, 2, 105),
(5, 'Laura', 'Martín', 5500, 1, 104),
(6, 'Carlos', 'Jiménez', 7800, 2, 104),
(7, 'Sofía', 'Díaz', 5200, 5, 105),
(8, 'Pedro', 'Sanz', 6000, 4, 104);



SELECT
    department.department_name,
    department.department_location,
    COUNT(empleados.id) AS Total_Empleados
FROM
    department 
LEFT JOIN
    empleados ON department.id = empleados.department_id
GROUP BY
    department.department_name, department.department_location
ORDER BY
    Total_Empleados DESC;



SELECT 
    department.department_name,
    COUNT(empleados.id) AS Total_Empleados,
    SUM(empleados.salary) AS Salario_Total_Departamento,
    AVG(empleados.salary) AS Salario_Promedio_Departamento
FROM
    empleados
INNER JOIN
    department ON empleados.department_id = department.id
GROUP BY
    department.department_name
ORDER BY    
    Salario_Total_Departamento DESC;



SELECT
    empleados.id AS id_empleado,
    first_name || ' ' || last_name AS nombre_completo,
    department.department_name,
    project.project_name
FROM
    empleados
INNER JOIN
    department ON empleados.department_id = department.id
INNER JOIN
    project ON empleados.project_id = project.id
ORDER BY 
department.department_name, empleados.last_name;



SELECT
    project.project_name,
    first_name || ' ' || last_name AS nombre_completo,
    SUM(CASE WHEN empleados.salary >= 7000 THEN 1 ELSE 0 END) AS Total_Salario_Alto,
    SUM(CASE WHEN empleados.salary <= 7000 THEN 1 ELSE 0 END) AS Total_Salario_Bajo
FROM
    empleados
INNER JOIN 
    project ON empleados.project_id = project.id
GROUP BY 
    project.project_name, empleados.first_name, empleados.last_name
ORDER BY
    Total_Salario_Alto DESC;










