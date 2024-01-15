# ConsultorBI_Proyecto_integrador
Proyecto integrador del curso de Consultor BI - Henry - 2023


# Proyecto: "Libros & Datos"  
  



### Introducción:  
Una biblioteca tiene la intención de informar a sus clientes acerca de las novedades en publicaciones para poder atraerlos según su interés. Actualmente este proceso lo hace una persona de manera manual, buscando información en la página de internet de la editorial con la que más trabaja esta librería que es Cúspide (www.cuspide.com), y es donde se publica, por ejemplo, cuáles son los 100 más vendidos en la semana o cuáles son las novedades.   
  

Como científico de datos, la biblioteca me consulta si sería posible mejorar ese proceso, teniendo la posibilidad por ejemplo, de extraer, procesar y guardar esos datos con Python y MySQL.   
  



### Propuesta técnica  
1. Realizar un Scraping de la página web de cúspide libros, y de allí obtener el listado de los 100 libros más vendidos de la semana.
2. Los datos deben ser: **título del libro**, **url del libro**, **precio en pesos**, **precio en dólares**, y **precio en dólares** considerando la cotización del dólar blue en Argentina, y **fecha**. 
3. La cotización del dólar blue de Argentina debe ser obtenida también utilizando scraping de cualquier página web a elección.
4. Asimismo estos datos deben ser ingresados en una tabla de mySQL, y debe crearse otra tabla de auditoría de errores, si algún título no se puede scrapear por alguna razón.  
  



### Entrega final: Desafío Analítica de datos  
1. Generar un tablero que muestre la evolución en el tiempo de las publicaciones, ayudando a resolver las siguientes preguntas de negocio:

  
  

- ¿Cuál es la categoría más solicitada?
¿Cuántos libros de categoría más solicitada, están dentro de los top 100?
¿Cuál es el autor más leído?
¿Cuál es el promedio de precios de los libros más leídos?
  
  

2. Realizar segmentación por fechas, agregar un logo y utilizar una paleta de colores adecuada para la visualización. También se sugiere utilizar el patrón Z.   
  

<br/>  

