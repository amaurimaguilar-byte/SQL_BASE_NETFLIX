# Proyecto SQL: NetflixDB y EmpresaDB

Este repositorio contiene dos bases de datos diseñadas para practicar y demostrar habilidades en **SQL**, incluyendo consultas de búsqueda, filtrado, agrupación, funciones de ventana, procedimientos almacenados, transacciones y triggers.

---

##  Bases de datos incluidas

### 1. NetflixDB
Base de datos orientada a series y episodios.  
En ella se aplican consultas para:
- Ranking de series por calificación IMDb.
- Ranking por duración usando `DENSE_RANK`.
- Series con promedio IMDb mayor a 8.
- Antigüedad de series.
- Clasificación por género.
- Redondeo de ratings.
- Número de episodios y promedio IMDb por serie.
- Series de los 3 géneros más frecuentes con promedio IMDb.

Ejemplos visuales y consultas documentadas en:  
[NetflixDB](https://github.com/amaurimaguilar-byte/SQL_BASE_NETFLIX/blob/main/README-Netflixdb.md)

---

### 2. EmpresaDB
Base de datos orientada a la gestión empresarial.  
Incluye ejemplos prácticos de:
- **Actualizaciones y borrados** en tablas de departamentos.
- **Procedimientos almacenados** para automatizar inserciones de empleados.
- **Transacciones con savepoints** para control de validaciones.
- **Vistas** para filtrar empleados por departamento.
- **Triggers** para registrar automáticamente nuevos empleados.
- **Ejercicios de entrevista** con consultas de:
  - Asignación de proyectos por empleado.
  - Total de horas por departamento.
  - Ranking departamental con funciones de ventana (`RANK()`).
Ejemplos visuales y consultas documentadas en:  
[EmpresaDB](https://github.com/amaurimaguilar-byte/SQL_BASE_NETFLIX/blob/main/README-Empresadb.md)
---

## Objetivo del repositorio
Este proyecto sirve como portafolio de prácticas SQL, mostrando:
- Uso de **consultas complejas** con `JOIN`, `GROUP BY`, `ORDER BY`, `LIMIT`.
- Aplicación de **funciones de ventana** (`RANK`, `DENSE_RANK`).
- Implementación de **procedimientos almacenados** y **triggers**.
- Ejemplos de **transacciones** y control de datos.
- Documentación visual y organizada para entrevistas técnicas y proyectos.
---
