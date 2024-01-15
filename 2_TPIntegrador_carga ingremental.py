from bs4 import BeautifulSoup
import requests
import datetime
import pymysql


def obtener_info (url):
    #Pasando como parametro la url de donde queremos extrer informacion, Usa la libreria bs4 y 
    #pharsea la url
    URL_BASE = url
    pedido_obtenido = requests.get(URL_BASE)
    html_obtenido = pedido_obtenido.text
    soup = BeautifulSoup(html_obtenido, "html.parser")
    return soup


def buscar_seccion(pagina, param1, clase):
    #pasando como parámetro la url, y la ubicacion de lo que queremos extraer, 
    #usa la funcion 'obtener_info' para extraer solo lo que estamos buscando
    info= obtener_info(pagina).find_all(param1, class_=clase)
    return info

pagina='https://cuspide.com/100-mas-vendidos/'

libros= buscar_seccion(pagina, 'div',"col small-6 large-2 max-w-large" )
print(libros)



#separo la info obtenida en diferentes listas
ranking_ = []
nombre = []
autor= []
url=[]
precio= []
autores=[]
for i in libros:
    puesto= i.find('p').text
    ranking_.append(puesto)
    titulo = i.find('h3').text
    nombre.append(titulo)
    a_tag=i.find('a')
    url.append(a_tag['href'])
    costo=i.find('bdi').text
    precio.append(costo)
    autor_element = i.find('p', class_='author-product-loop')
    #print(autor_element.text)
    if autor_element.text == '':
        autores.append('Sin Datos')
    else:
        autor_nombre = autor_element.text
        autores.append(autor_nombre)
    



#Convierto cada ranking en numero entero
ranking_nuevo=[]
for i in ranking_:
    i =i.replace('#', '')
    i=i.replace('ranking en venta', '')
    i = int(i)
    ranking_nuevo.append(i)
print(ranking_nuevo)


#limpio los precios y los paso a decimales
precios_numeros = []
for precio_str in precio:
    # Limpiar la cadena de caracteres no numéricos y luego convertir a punto flotante
    precio_limpio = precio_str.replace('$', '').replace('\xa0', '').replace(',00', '').replace('.','').strip(' \n€')
    precio_numero = float(precio_limpio)
    precios_numeros.append(precio_numero)



#junto las listas en una lista de tuplas

lista_completa = [( y, z, i, a, e) for  y, z , i, a, e in zip( ranking_nuevo, nombre, autores, url, precios_numeros)]
print(lista_completa)


# Crear una lista de rangos desde 1 hasta 100
rangos = list(range(1, 101))

# Crear un diccionario con los valores de ranking como clave y las tuplas correspondientes como valor
diccionario_libros = dict(zip(ranking_nuevo, lista_completa))

# Completar las tuplas faltantes con valores None
lista_completa_actualizada = [diccionario_libros.get(r, (r, None, None, None)) for r in rangos]

# Imprimir la lista completa actualizada
print(lista_completa_actualizada)




#Extraigo el precio del dolar.
pagina2= 'https://dolarhoy.com/'


dolar = buscar_seccion(pagina2, 'div', 'val')
print(dolar)

dolar_blue = dolar[1].text
dolar_oficial= dolar[5].text
print(dolar_oficial)

def limpiar_precio2(precio):
    precios_numeros = []
    for precio_str in precio:
        # Limpiar la cadena de caracteres no numéricos y luego convertir a punto flotante
        precio_limpio = precio_str.replace('$', '')
        precio_numero = float(precio_limpio)
        precios_numeros.append(precio_numero)
    return precios_numeros

precio=[dolar_blue, dolar_oficial]
dolares= limpiar_precio2(precio)

dolar_oficial = dolares[1]
dolar_blue=dolares[0]
print(dolares, dolar_blue, dolar_oficial)   
print(dolar_oficial)



# Obtener la fecha de hoy
fecha_actual = datetime.date.today()
print(fecha_actual)
###-------------------------------

# Parámetros de conexión a MySQL
host = 'localhost'
usuario = 'root'
contraseña = 'root1234'
base_de_datos= 'los_mas_vendidos'

# Crea la conexión a MySQL
connection = pymysql.connect(
    host=host,
    user=usuario,
    password=contraseña,
    database= base_de_datos
)


#crea un cursor
cursor = connection.cursor()



# Itera a través de lista_completa e inserta cada elemento en la base de datos
for ranking, titulo, autores, url, precio in lista_completa_actualizada:
    #creo la variable fecha_actual
    fecha_actual = datetime.date.today()
    # Prepara la consulta SQL
    insert_query = "INSERT INTO libros (ranking, titulo, autor, url, precio, fecha_ingreso) VALUES (%s, %s, %s, %s, %s, %s)"
    # Ejecuta la consulta SQL con los valores correspondientes
    cursor.execute(insert_query, (ranking, titulo, autores, url, precio, fecha_actual))



instruccion6= 'UPDATE `libros` SET precio_dolar = precio_tipo_dolar(%s,precio) where fecha_ingreso = curdate();'
cursor.execute(instruccion6, (dolar_oficial,))

instruccion7= 'UPDATE `libros` SET precio_dolar_blue = precio_tipo_dolar(%s,precio) where fecha_ingreso = curdate();'
cursor.execute(instruccion7, (dolar_blue,))

instruccion9= '''INSERT INTO errores (idError, fecha)
SELECT id,  fecha_ingreso
FROM libros
WHERE titulo IS NULL and fecha_ingreso = curdate();'''
cursor.execute(instruccion9)





connection.commit()

cursor.close() #CIERRA EL CURSOR
connection.close() #CIERRA LA CONEXION A MYSQL
