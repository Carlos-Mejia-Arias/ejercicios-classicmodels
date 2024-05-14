/*************************
********** 01 **********
SELECT, OPERACIONES BÁSICAS Y FILTROS
Vamos a entender cómo funciona la SELECT a nivel básico.
El lenguaje SQL es case insensitive, por lo que puede escribirse tanto en mayúsculas como en minúsculas, incluidos los nombres de las columnas en MySQL (depende del motor de BBDD).

Lista el apellido y nombre de los empleados (formato Apellido, Nombre en un mismo campo), así como su email y cargo.
- Tabla Employees
**************************/



/*************************
********** 02 **********
Ordénalos por orden alfabético de apellido, nombre y el e-mail
**************************/



/*************************
********** 03 **********
Lista los productos (código, nombre, línea, escala y cantidad) que corresponden a la escala 1:18
**************************/



/*************************
********** 04 **********
Y de los que son escala 1:18, ahora busca los que pertenecen al proveedor "Classic Metal Creations"
**************************/



/*************************
********** 05 **********
De los productos, lista únicamente aquellos que sabemos que son "Corvette" por su nombre y ordénalos por cantidad en stock ascendiente.
La cláusula LIKE permite realizar búsquedas por patrones (cuidado con la versión de MySQL que puede que algunos patrones no estén todavía habilitados).
- % significa cualquier carácter (p.e. n% cualquier palabra que empiece por n)
- _ significa que debe existir un carácter cualquiera (p.e. l__ sería los, las, les, lis...)
A partir de aquí se pueden combinar estas "wildcards".
Por otro lado, tenemos las búsquedas case sensitive/in-sensitive, es decir, búsquedas que deben respetar las mayúsculas o no. Puede ser que no queramos interpretar U como u. Los tipos de fuentes NO binarios, son no sensitivas, mientras que los tipos binarios sí que lo son. Si queremos que sea sensitiva, deberemos forzar el tipo de dato en la búsqueda a través del operador BINARY.
- Utilizar BINARY antes de la operación lógica (p.e. LIKE BINARY "maYúsCulas")
Eso sí, si un campo es susceptible de requerir búsquedas sensibles, lo mejor es alterar su definición para que sea del tipo binaria.
**************************/



/*************************
********** 06 **********
Listar los proveedores/fabricantes (vendors) únicos de los productos ordenados alfabéticamente
**************************/



/*************************
********** 07 **********
Listar los proveedores postales de los clientes (únicos)
**************************/



/*************************
********** 08 **********
Cuenta los códigos postales únicos de los clientes
**************************/



/*************************
********** 09 **********
Cuenta el número total de clientes
**************************/



/*************************
********** 10 **********
Cuenta el número de clientes con un límite de crédito entre 60.000 y 70.000
**************************/



/*************************
********** 11 **********
Lista las ciudades y países únicos en los que la empresa tiene clientes, por orden ascendente de país y ciudad
Concatena la ciudad y el país con una coma.
**************************/



/*************************
********** 12 **********
Cuenta el número de clientes que han realizado un pedido o más
¿Cuántas formas hay de hacerlo?
**************************/



/*************************
********** 13 **********
Lista los clientes que NO han realizado ningún pedido y que NO son de USA.
- ¿se puede hacer con las mismas opciones que antes?
- ¿hay alguna otra manera de hacerlo más allá que con el IN?
**************************/



/*************************
********** 14 **********
Listar los pedidos que se han hecho en el 2005 y que ya han sido enviados

1. Investigar qué status existen y ver si pueden sernos útiles
2. Por curiosidad, miremos el mínimo y máximo de fechas de los pedidos
3. Veamos si existen otros campos que puedan sernos de utilidad
4. Decidamos cómo hacer la búsqueda solicitada
**************************/



/*************** GROUP BY *******************/

/*************************
********** 15 **********
Calcular el número de empleados por cargo
- Ordenado ascendente por nombre del cargo
**************************/



/*************************
********** 16 **********
Número de empleados por cargo ordenados de más a menos número
**************************/



/*************************
********** 17 **********
Listar el número de proveedores (vendors) que tenemos, así como el número de productos distintos y el stock total para cada proveedor, 
ordenador por nombre del proveedor.
- Formatear la cantidad para que aparezca el punto de miles y con céntimos de euro vía coma (FORMAT(num,numDec,locale) 'es_ES'
**************************/



/*************************
********** 18 **********
Lista de proveedores (vendors) con más de 35000 unidades en stock ordenados por nombre de proveedor
**************************/



/*************************
********** 19 **********
Listar el número de pedidos por año y status que NO han sido enviados
**************************/



/*************************
********** 20 **********
Número de clientes por país para países con más de 5 clientes, de más cantidad a menos
**************************/



/*************************
********** 21 **********
Promedio de límite de crédito por país del cliente para los clientes que tienen límite > 0
- Tabla customers
- Hacer que el promedio sea un número entero
- Ordenar de menor a mayor crédito promedio
- Incluir el número de clientes que forman parte de ese promedio

En función de la versión de MySQL, el casting tiene tipos de datos distintos (en Google Colaboratory trabajamos con 5.7, donde no existe INT y se utiliza SIGNED).
**************************/



/************************* JOIN ***************************/

/*************************
********** 22 **********
Lista cada empleado (nombre, apellido), con la ciudad y código postal de su oficina.
**************************/



/*************************
********** 23 **********
De los anteriores, selecciona sólo los que están en la oficina de San Francisco.
**************************/



/*************************
********** 24 **********
Lista los clientes y su país, que no han hecho ningún pedido
- Ahora con la unión correspondiente
- Ordena por país
**************************/



/*************************
********** 25 **********
Ranking de productos más vendidos por año y por país
- Incluir el nombre de la familia de cada producto
**************************/



/*************************
********** 26 **********
Calcula el número promedio de productos, de unidades y el gasto medio por pedido de los clientes de USA.
**************************/



/*************************
********** 27 **********
Qué clientes nos deben dinero y cuánto
- Tenemos que saber cuánto hemos facturado a cada cliente
- Tenemos que saber cuánto ha pagado cada cliente
**************************/




/*************************
********** 28 **********
Y ahora con la cláusula WITH si tenemos versión 8.0 de MySQL
**************************/
