from bs4 import BeautifulSoup
import requests
import datetime
import pymysql

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



query = "SELECT url FROM libros where Categoria is null"
cursor.execute(query)


# Obtener todos los resultados como una lista de diccionarios
resultados = cursor.fetchall()
print(resultados)

categorias=[]
resultados_limpio=[]
for row in resultados:
    valor_columna = row[0]
    print(valor_columna)
    if valor_columna == None:
        pass
    else:
        resultados_limpio.append(valor_columna)
        busco = buscar_seccion(valor_columna,'nav','woocommerce-breadcrumb breadcrumbs')
        for i in busco:
            cate = i.find_all('a')
            categorias.append(cate[1].text)
print(categorias)
print(resultados_limpio)
lista=[(i,x) for i,x in zip(resultados_limpio, categorias)]

for i in lista:
    print(i[1])

print(lista)

#creo la columna categoria
#instruccion_1= 'ALTER TABLE libros DROP Categoria;'
#cursor.execute(instruccion_1) 
instruccion2='ALTER TABLE `libros` ADD `Categoria`  VARCHAR(100) AFTER `titulo`;'
cursor.execute(instruccion2)


# Suponiendo que 'lista' contiene pares URL-Categoría
for i in lista:
    query = "UPDATE libros SET Categoria = %s WHERE url = %s and Categoria is null"
    cursor.execute(query, (i[1], i[0]))



################################################################################################
#    AUTORES



query = "SELECT DISTINCT url FROM libros;"
cursor.execute(query)


# Obtener todos los resultados como una lista de diccionarios
resultados = cursor.fetchall()
print(resultados)
print(type(resultados))

#resultados_= resultados[150::]
#print(resultados)

autores=[]
resultados_limpio=[]
for row in resultados:
    valor_columna = row[0]
    #print(valor_columna)
    if valor_columna == None:
        pass
    else:
        resultados_limpio.append(valor_columna)
        
        busco = buscar_seccion(valor_columna,'tr','woocommerce-product-attributes-item woocommerce-product-attributes-item--attribute_pa_autor')
       
        if not busco:  # Si no se encontró ningún autor
                    autores.append('None')  # Agregar 'None' a la lista de autores directamente
                
        else:
            for i in busco:
                aut = i.find('a').text if i.find('a') else None
                #print(aut)
                if aut:
                    autores.append(aut)
                else:
                    autores.append('None')
            
                
print(len(autores))
print(len(resultados_limpio))
lista_autores=[(i,x) for i,x in zip(resultados_limpio, autores)]
print(lista_autores)

#creo la columna autor
#instruccion_1= 'ALTER TABLE libros DROP Categoria;'
#cursor.execute(instruccion_1) 
instruccion3='ALTER TABLE `libros` ADD `Autor`  VARCHAR(100) AFTER `titulo`;'
cursor.execute(instruccion3)


# Suponiendo que 'lista' contiene pares URL-Categoría
for i in lista_autores:
    query = "UPDATE libros SET Autor = %s WHERE url = %s and Autor = 'None'"
    cursor.execute(query, (i[1], i[0]))


connection.commit()

cursor.close() #CIERRA EL CURSOR
connection.close() #CIERRA LA CONEXION A MYSQL
