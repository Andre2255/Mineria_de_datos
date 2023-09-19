# Clase 02

## En esta clase creamos el tablespace de northwind y de jardineria. Se ejecutaron los siguientes scripts.

### De esta clase nos llevo de tarea personal descargar y instalar los programas con el que vamos a trabajos durante el curso.

## scritps del tablespace de northwind.

### [ northwind.bak.txt ](archivos/northwind.txt)


## scritps del tablespace de jardineria.

### [ jardineria.bak.txt ](archivos/jardineria.txt)


## Luego en clases tambien intente hacer algunas consultas

```sql
select *  from (
select pr.nombre producto,p.estado,dp.cantidad,dp.precio_unidad  from pedido p
inner join detalle_pedido dp
on p.codigo_pedido=dp.codigo_pedido
inner join producto pr
on dp.codigo_producto=pr.codigo_producto
) pivot (sum(cantidad) cantidad, sum(precio_unidad)  precio 
for estado in ('Entregado' entregado,'Rechazado' rechazado,'Pendiente' pendiente ) )

```

```sql
select c.nombre_cliente,v.monto ,e.nombre representante from cliente c
inner join 
(select p.codigo_cliente, sum(dp.cantidad)*sum(dp.precio_unidad) monto   from pedido p
inner join detalle_pedido dp
on p.codigo_pedido=dp.codigo_pedido
group by p.codigo_cliente) v
on c.codigo_cliente=v.codigo_cliente
left join empleado e
on c.codigo_empleado_rep_ventas=e.codigo_empleado

```

```sql
SELECT CODIGO_OFICINA, CIUDAD FROM oficina;

UPDATE CLIENTE SET LIMITE_CREDITO = LIMITE_CREDITO + (LIMITE_CREDITO*0.25) WHERE LIMITE_CREDITO>=12000 AND LOWER (CIUDAD) LIKE '%miami%';

SELECT NOMBRE || ' ' || APELLIDO1 || ' ' || APELLIDO2 AS "Nombre Completo", 
       EMAIL 
FROM EMPLEADO 
WHERE codigo_jefe = 7;

```