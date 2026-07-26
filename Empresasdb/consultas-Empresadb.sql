# ============================
# Configuración inicial
# ============================
USE empresadb;

#agregar columna a tabla de referencia
ALTER TABLE tabla_referencia 
ADD COLUMN propiedad_ejemplo VARCHAR(255);

# Eliminar tabla si existe
DROP TABLE IF EXISTS tabla_referencia_2;


# ============================
# Actualizaciones y borrados
# ============================
# Actualizar ubicación del departamento Marketing
UPDATE departamentos 
SET ubicacion = 'Edificio central' 
WHERE nombre = 'Marketing';

# Eliminar departamento Marketing (ejemplo)
DELETE FROM departamentos 
WHERE nombre = 'Marketing';


# ============================
# Procedimiento almacenado: Insertar empleado
# ============================
DELIMITER //
CREATE PROCEDURE AgregarEmpleado(
    IN _nombre VARCHAR(255), 
    IN _apellido VARCHAR(255), 
    IN _email VARCHAR(255),
    IN _depto_id INT
)
BEGIN
    INSERT INTO Empleados(nombre, apellido, email, depto_id) 
    VALUES (_nombre, _apellido, _email, _depto_id);
END //
DELIMITER ;

# Llamada de ejemplo
CALL AgregarEmpleado('Empleado','Ejemplo','ejemplo@onepiece.com',3);

SELECT * FROM Empleados;


# ============================
# Transacciones con Savepoints
# ============================
BEGIN; 
    SAVEPOINT PreValidacion;

    INSERT INTO AsignacionesDeProyectos(proyecto_id, empleado_id, horas_asignadas) 
    VALUES (5,1,10);

    INSERT INTO AsignacionesDeProyectos(proyecto_id, empleado_id, horas_asignadas) 
    VALUES (5,1,100);

    # Aquí iría validación de reglas de negocio
    # Si excede, revertimos al savepoint
    ROLLBACK TO PreValidacion;
END; 


# ============================
# Procedimientos adicionales
# ============================
CALL AsignarHorasAProyecto(1,1,5);

SELECT * 
FROM AsignacionesDeProyectos 
WHERE proyecto_id = 1 AND empleado_id = 1;

CALL AsignarHorasAProyecto(1,1,500);


# ============================
# Vistas
# ============================
# Vista normal
CREATE VIEW VistaEmpleadosTecnologia AS 
SELECT nombre, apellido, email
FROM Empleados
WHERE depto_id = 1;

SELECT * FROM VistaEmpleadosTecnologia;

# Nota: MySQL Workbench NO soporta vistas materializadas
# (solo se documenta como referencia)
-- CREATE MATERIALIZED VIEW VistaEmpleadosTecnologia AS 
-- SELECT nombre, apellido, email
-- FROM Empleados
-- WHERE depto_id = 1;


# ============================
# Trigger: registrar nuevo empleado
# ============================
DELIMITER $$
CREATE TRIGGER RegistrarNuevoEmpleado
AFTER INSERT ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO LogEmpleados(empleado_id, fecha_registro) 
    VALUES (NEW.empleado_id, NOW());
END $$
DELIMITER ;

# Ejemplo de inserción que dispara el trigger
INSERT INTO Empleados(nombre, apellido, email) 
VALUES ('Zorro','Roronoa','onepiece@onepiece');

SELECT * FROM LogEmpleados;

