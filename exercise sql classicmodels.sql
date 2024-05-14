/*************************
********** 01 **********
SELECT, OPERACIONES BÁSICAS Y FILTROS
Vamos a entender cómo funciona la SELECT a nivel básico.
El lenguaje SQL es case insensitive, por lo que puede escribirse tanto en mayúsculas como en minúsculas, incluidos los nombres de las columnas en MySQL (depende del motor de BBDD).

Lista el apellido y nombre de los empleados (formato Apellido, Nombre en un mismo campo), así como su email y cargo.
- Tabla Employees
**************************/
SELECT lastName, firstName, email, jobtitle as cargo, concat(lastname, ", ", firstname) as nombre_completo
from employees
;
# cometarios 

/*************************
********** 02 **********
Ordénalos por orden alfabético de apellido, nombre y el e-mail
**************************/
SELECT lastName, firstName, email, jobtitle as cargo, concat(lastname, ", ", firstname) as nombre_completo
from employees
order by lastname, firstname, email
;

/*************************
********** 03 **********
Lista los productos (código, nombre, línea, escala y cantidad) que corresponden a la escala 1:18
**************************/
SELECT productcode, productname, productline, productscale, quantityinstock
from products
where productscale = '1:18'
;

/*************************
********** 04 **********
Y de los que son escala 1:18, ahora busca los que pertenecen al proveedor "Classic Metal Creations"
**************************/
SELECT  productcode, productname, productline, productvendor, productscale, quantityinstock
from products
where productscale = '1:18' 
and productvendor = 'Classic Metal Creations'
;

/*************************
********** 06 **********
De los productos, lista únicamente aquellos que sabemos que son "Corvette" por su nombre y ordénalos por cantidad en stock ascendiente.
La cláusula LIKE permite realizar búsquedas por patrones (cuidado con la versión de MySQL que puede que algunos patrones no estén todavía habilitados).
- % significa cualquier carácter (p.e. n% cualquier palabra que empiece por n)
- _ significa que debe existir un carácter cualquiera (p.e. l__ sería los, las, les, lis...)
A partir de aquí se pueden combinar estas "wildcards".
Por otro lado, tenemos las búsquedas case sensitive/in-sensitive, es decir, búsquedas que deben respetar las mayúsculas o no. Puede ser que no queramos interpretar U como u. Los tipos de fuentes NO binarios, son no sensitivas, mientras que los tipos binarios sí que lo son. Si queremos que sea sensitiva, deberemos forzar el tipo de dato en la búsqueda a través del operador BINARY.
- Utilizar BINARY antes de la operación lógica (p.e. LIKE BINARY "maYúsCulas")
Eso sí, si un campo es susceptible de requerir búsquedas sensibles, lo mejor es alterar su definición para que sea del tipo binaria.
**************************/
SELECT *
from products
where upper(productname) like '%CORVETTE%' # cORvETTE, cORVETTE
;

/*************************
********** 07 **********
Listar los proveedores/fabricantes (vendors) únicos de los productos ordenados alfabéticamente
**************************/
SELECT distinct productVendor from products order by productVendor
;

/*************************
********** 08 **********
Listar los proveedores postales de los clientes (únicos)
**************************/
SELECT *
from customers
;
SELECT distinct postalcode
from customers
;
/*************************
********** 09 **********
Cuenta los códigos postales únicos de los clientes
**************************/
SELECT  count(distinct  postalCode) as Num 
from customers
;

/*************************
********** 10 **********
Cuenta el número total de clientes
**************************/
SELECT count(*) 
from customers
;
SELECT count(customerNumber) 
from customers
;
SELECT count(distinct customerNumber) 
from customers
;

/*************************
********** 11 **********
Cuenta el número de clientes con un límite de crédito entre 60.000 y 70.000
**************************/
SELECT count(*)
from customers
#where creditLimit>=60000 and creditLimit<=70000
where creditLimit between 60000 and 70000
;

/*************************
********** 12 **********
Lista las ciudades y países únicos en los que la empresa tiene clientes, por orden ascendente de país y ciudad
Concatena la ciudad y el país con una coma.
**************************/
SELECT distinct city, country, concat(country, ", ", city) as pais_ciudad
from customers
order by country, city
;

/*************************
********** 13 **********
Cuenta el número de clientes que han realizado un pedido o más
¿Cuántas formas hay de hacerlo?
**************************/
SELECT COUNT(DISTINCT customerNumber) 
FROM orders
;
select COUNT(DISTINCT customerNumber)
from customers 
where customerNumber in (
select customerNumber
from orders
)
;

/*************************
********** 14 **********
Lista los clientes que NO han realizado ningún pedido y que NO son de USA.
- ¿se puede hacer con las mismas opciones que antes?
- ¿hay alguna otra manera de hacerlo más allá que con el IN?
**************************/
select *
from customers 
where customerNumber not in (
select customerNumber
from orders
)
and country != 'USA'
;

/*************************
********** 15 **********
Listar los pedidos que se han hecho en el 2005 y que ya han sido enviados

1. Investigar qué status existen y ver si pueden sernos útiles
2. Por curiosidad, miremos el mínimo y máximo de fechas de los pedidos
3. Veamos si existen otros campos que puedan sernos de utilidad
4. Decidamos cómo hacer la búsqueda solicitada
**************************/
SELECT distinct status
from orders
;
select min(orderdate), max(orderdate)
from orders
;
select *
from orders 
where status = 'Shipped'
and year(orderdate)=2005
;

/*************** GROUP BY *******************/

/*************************
********** 16 **********
Calcular el número de empleados por cargo
- Ordenado ascendente por nombre del cargo
**************************/
SELECT jobTitle, count(employeeNumber) as num_cargo, sum(1)
from employees
group by jobtitle
order by jobtitle
;

SELECT reportsTo, count(employeeNumber) as num_cargo, sum(1)
from employees
group by reportsTo
;

/*************************
********** 17 **********
Número de empleados por cargo ordenados de más a menos número
**************************/
SELECT jobTitle as job, count(employeeNumber) as num_cargo
from employees
group by jobtitle
order by num_cargo desc
;

/*************************
********** 18 **********
Listar el número de proveedores (vendors) que tenemos, así como el número de productos distintos y el stock total para cada proveedor, 
ordenador por nombre del proveedor.
- Formatear la cantidad para que aparezca el punto de miles y con céntimos de euro vía coma (FORMAT(num,numDec,locale) 'es_ES'
**************************/
SELECT *
from products
;
SELECT productVendor, count(distinct productName), sum(quantityinstock),
	format(sum(quantityinstock),2,'es_ES') as numero_formateado
from products
group by productVendor
;

/*************************
********** 19 **********
Lista de proveedores (vendors) con más de 35000 unidades en stock ordenados por nombre de proveedor
**************************/
SELECT productVendor, sum(quantityinstock)
from products
group by productVendor
having sum(quantityinstock) >= 35000
order by productVendor
;

select productVendor,quantityinstock
from products
order by productVendor
;

/*************************
********** 20 **********
Listar el número de pedidos por año y status que NO han sido enviados
**************************/
SELECT year(orderDate), status, count(ordernumber) 
from orders
where status!='Shipped'
group by year(orderDate), status
;

select year(orderDate), status, count(ordernumber) 
from orders
where shippedDate is null
group by year(orderDate), status
;

select *
from orders
where status!='Shipped'
and shippedDate is not null
;

/*************************
********** 21 **********
Número de clientes por país para países con más de 5 clientes, de más cantidad a menos
**************************/
SELECT country, count(customerNumber) as num_clientes
from customers
group by country
having count(customerNumber) > 5
order by num_clientes desc
;

/*************************
********** 22 **********
Promedio de límite de crédito por país del cliente para los clientes que tienen límite > 0
- Tabla customers
- Hacer que el promedio sea un número entero
- Ordenar de menor a mayor crédito promedio
- Incluir el número de clientes que forman parte de ese promedio

En función de la versión de MySQL, el casting tiene tipos de datos distintos (en Google Colaboratory trabajamos con 5.7, donde no existe INT y se utiliza SIGNED).
**************************/
SELECT country, round(avg(creditLimit),0) as avg_limit,truncate(avg(creditLimit),0) as avg_limit2, count(customerName) as num_clientes
from customers
where creditLimit > 0 
group by country
order by avg_limit
;

/************************* JOIN ***************************/

/*************************
********** 23 **********
Lista cada empleado (nombre, apellido), con la ciudad y código postal de su oficina.
**************************/
SELECT firstname, lastname, city, postalcode
from employees as t1
	left join offices t2
		on t1.officeCode = t2.officeCode
;

/*************************
********** 24 **********
De los anteriores, selecciona sólo los que están en la oficina de San Francisco.
**************************/
SELECT firstname, lastname, city, postalcode
from employees as t1
	left join offices t2
		on t1.officeCode = t2.officeCode
where city = 'San Francisco'
;

/*************************
********** 25 **********
Lista los clientes y su país, que no han hecho ningún pedido
- Ahora con la unión correspondiente
- Ordena por país
**************************/
SELECT *
from customers t1 
	left join orders t2
		on t1.customerNumber = t2.customerNumber
where t2.customerNumber is null
;

/*************************
********** 26 **********
Ranking de productos más vendidos por año y por país
- Incluir el nombre de la familia de cada producto
**************************/
SELECT YEAR(orderDate) AS año, country, productName, productLine, SUM(quantityOrdered) AS ventas
FROM products AS p
INNER JOIN orderdetails AS od
	ON p.productCode = od.productCode
INNER JOIN orders AS o
	on o.orderNumber = od.orderNumber
INNER JOIN customers AS c
	on c.customerNumber = o.customerNumber
WHERE o.status NOT IN ("Cancelled", "Disputed")
GROUP BY YEAR(orderDate), country, productName, productLine
ORDER BY ventas DESC
;


/*************************
********** 27 **********
Calcula el número promedio de productos, de unidades y el gasto medio por pedido de los clientes de USA.
**************************/
select country, avg(num_products) as avg_num_products,avg(unidades) as avg_unidades, avg(precio_pedido) as precio_pedido
from
(
SELECT cust.country, orddet.orderNumber, count(distinct productCode) as num_products, 
		sum(orddet.quantityOrdered) as unidades,
        sum(quantityOrdered * priceEach) as precio_pedido
from customers as cust
    inner join orders as ord
		on ord.customerNumber=cust.customerNumber
	inner join orderdetails as orddet
		on orddet.orderNumber=ord.orderNumber
#where cust.country='USA'
group by cust.country, orddet.orderNumber
) as t
group by country
;


/*************************
********** 28 **********
Qué clientes nos deben dinero y cuánto
- Tenemos que saber cuánto hemos facturado a cada cliente
- Tenemos que saber cuánto ha pagado cada cliente
**************************/
select 
	f.customerNumber,
    f.facturado_cliente,
    p.pago_cliente, 
    f.facturado_cliente - p.pago_cliente as deuda
from
(
SELECT 
	c.customerNumber, 
    sum(od.quantityOrdered*od.priceEach) as facturado_cliente
from customers c 
	inner join orders o 
		on c.customerNumber = o.customerNumber
	inner join orderdetails od
		on o.ordernumber = od.ordernumber
group by c.customerNumber
) f
left join
(
select c.customerNumber, sum(amount) as pago_cliente
from customers c
	left join payments p 
		on c.customerNumber = p.customerNumber
group by c.customerNumber
) p
on f.customernumber = p.customernumber
where (f.facturado_cliente - p.pago_cliente) > 0
order by deuda desc
;



/*************************
********** 29 **********
Y ahora con la cláusula WITH si tenemos versión 8.0 de MySQL
**************************/
with t1 as 
(
SELECT cust.country, orddet.orderNumber, count(distinct productCode) as num_products, 
		sum(orddet.quantityOrdered) as unidades,
        sum(quantityOrdered * priceEach) as precio_pedido
from customers as cust
    inner join orders as ord
		on ord.customerNumber=cust.customerNumber
	inner join orderdetails as orddet
		on orddet.orderNumber=ord.orderNumber
#where cust.country='USA'
group by cust.country, orddet.orderNumber
)
select country, avg(num_products) as avg_num_products,avg(unidades) as avg_unidades, avg(precio_pedido) as precio_pedido
from t1 
group by country
;
