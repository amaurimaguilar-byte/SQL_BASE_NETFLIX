# ============================
# Ejercicio de entrevista 1
# ============================
# Consulta: Nombre y apellido de cada empleado,
# junto con el nombre del proyecto y las horas asignadas.
# Orden: primero por empleado, luego por horas asignadas DESC.

SELECT
    E.nombre AS 'Nombre Empleado', 
    E.apellido AS 'Apellido Empleado',
    P.nombre AS 'Nombre Proyecto',
    A.horas_asignadas AS 'Horas Asignadas'
FROM Empleados E
JOIN AsignacionesDeProyectos A ON E.empleado_id = A.empleado_id
JOIN Proyectos P ON A.proyecto_id = P.proyecto_id
ORDER BY 
    E.nombre,
    E.apellido,
    A.horas_asignadas DESC;


# ============================
# Ejercicio de entrevista 2
# ============================
# Consulta: Nombre del departamento y suma total de horas asignadas
# Agrupación: por departamento
# Orden: total de horas DESC

SELECT
    D.nombre AS 'Nombre Departamento',
    SUM(A.horas_asignadas) AS 'Total Horas Asignadas'
FROM Departamentos D
JOIN Empleados E ON D.depto_id = E.depto_id
JOIN AsignacionesDeProyectos A ON E.empleado_id = A.empleado_id
GROUP BY D.nombre
ORDER BY SUM(A.horas_asignadas) DESC;


# ============================
# Ejercicio de entrevista 3
# ============================
# Consulta: Nombre y apellido de cada empleado,
# total de horas trabajadas y ranking departamental.
# Función de ventana: RANK() sobre horas trabajadas por departamento.
# Orden: por departamento y ranking.

SELECT
    E.nombre AS 'Nombre',
    E.apellido AS 'Apellido',
    SUM(A.horas_asignadas) AS 'Total Horas Trabajadas',
    RANK() OVER(
        PARTITION BY E.depto_id 
        ORDER BY SUM(A.horas_asignadas) DESC
    ) AS 'Ranking Departamental'
FROM Empleados E
JOIN AsignacionesDeProyectos A ON E.empleado_id = A.empleado_id
GROUP BY E.nombre, E.apellido, E.depto_id
ORDER BY E.depto_id, `Ranking Departamental`;
