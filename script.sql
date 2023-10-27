USE success_mindset;

# En primera instancia, crear las tablas con el script db_creation.sql

# *-*-*-*- Parte de insercion de datos en la base de datos -*-*-*-*

-- En primer lugar, importar mediante el interprete de importacion para tabla USUARIO el archivo table_usuario.csv
-- A posteriori, ejecutar este script

-- Datos para LIBRO_GENERO
INSERT INTO libro_genero 
VALUES (1, 'Riqueza'),
	   (2, 'Desarrollo Personal'),
       (3, 'Liderazgo'),
       (4, 'Emprendimiento'),
       (5, 'Habitos'),
       (6, 'Analisis tecnico & Trading');
       
-- Datos para LIBRO_AUTOR
INSERT INTO libro_autor
VALUES (1, 'Eric Ries'),
	   (2, 'James Clear'),
       (3, 'John Murphy'),
       (4, 'Brian Tracy'),
       (5, 'Napoleon Hill'),
       (6, 'John Maxwell');

-- Datos para LIBRO_EDITORIAL
INSERT INTO libro_editorial
VALUES (1, 'Planeta'),
	   (2, 'Debolsillo'),
       (3, 'Galerna'),
       (4, 'Aguilar');

-- Datos para FICHA_LIBRO
INSERT INTO ficha_libro
VALUES (NULL, 1, 4, 4, 097895074, 'Un gran libro para comenzar un empredimiento', 'El Metodo Learn Startup'),
       (NULL, 2, 1, 1, 097826352, 'El mejor libro para crear riquezas desde cero', 'Piense y hagase rico'),
       (NULL, 3, 2, 2, 097823166, 'La joyita del desarrollo personal', 'Traguese ese sapo'),
       (NULL, 4, 3, 3, 097826491, 'Sea el mejor lider de su generacion', 'Las 21 leyes irrefutables del liderazgo'),
       (NULL, 1, 5, 5, 097816231, 'Construya habitos saludables', 'Habitos atomicos'),
       (NULL, 2, 6, 6, 097811111, 'Aprenda a analizar los mercados como un profesional', 'Analisis tecnico de los Mercados Financieros');

-- Datos para PUBLICACION
INSERT INTO publicacion
VALUES (1, 6, 1, 4899.99, 10, 'Nuevo. Viene sellado. Local a la calle en la zona de Caballito', CURRENT_TIMESTAMP(), 'https://i.imgur.com/ESSkOdv.jpeg'),
	   (2, 5, 2, 2600.00, 1, 'Esta usado en perfecto estado.', CURRENT_TIMESTAMP(),'https://i.imgur.com/ngExKHr.jpeg'),
       (3, 4, 3, 9120.00, 3, NULL, CURRENT_TIMESTAMP(), 'https://i.imgur.com/ngExKHr.jpeg' ),
       (4, 2, 4, 899.90, 28, 'Nos encontramos en la zona de Lomas de Zamora', CURRENT_TIMESTAMP(), 'https://i.imgur.com/1jD7zfq.jpeg'),
       (5, 3, 5, 14500.50, 90, 'Con tu compra de 5 libros, te llevas 1 de regalo!', CURRENT_TIMESTAMP(), 'https://i.imgur.com/G9uU13g.png'),
       (6, 1, 6, 3999.99, 10, NULL, current_timestamp(), 'https://i.imgur.com/LpS6tOd.jpeg');

-- Datos para MENSAJE
INSERT INTO mensaje
VALUES (NULL, 1, 1, 'Hola. Buen dia. Haces envios a Santiago del Estero?', 'Si hacemos', CURRENT_TIMESTAMP()),
       (NULL, 2, 2, 'Por que zona te encontras?', NULL, CURRENT_TIMESTAMP()),
       (NULL, 3, 3, 'Hola. Envias a capital federal?', 'Hola. Por el momento no tenemos envios a capital federal', CURRENT_TIMESTAMP()),
       (NULL, 4, 4, 'Buenas noches. Lo tenes en la 5ta edicion?', 'Entran la semana que viene', CURRENT_TIMESTAMP());

-- Datos para ENVIO
INSERT INTO envio
VALUES (NULL, 899, 'Avenida Juan B. Alberdi 2932', CURRENT_TIMESTAMP()),
       (NULL, 340, 'Espinosa 432', CURRENT_TIMESTAMP()),
       (NULL, 1099, 'San Justo 9090', CURRENT_TIMESTAMP()),
       (NULL, 888, 'Paysando 8900', CURRENT_TIMESTAMP()),
       (NULL, 1000, 'N. Oronio 2000', CURRENT_TIMESTAMP()),
       (NULL, 188, '9 de Julio 23', CURRENT_TIMESTAMP());

-- Datos para COMPRA_METODO
INSERT INTO compra_metodo
VALUES (1, 'Efectivo'),
       (2, 'Transferencia'),
       (3, 'Debito'),
       (4, 'Credito');

-- Datos para COMPRA
INSERT INTO compra
VALUES (NULL, 1, 14, 6, CURRENT_TIMESTAMP(), 1, 1, 5087.99),
	   (NULL, 2, 15, 5, CURRENT_TIMESTAMP(), 3, 1, 3600),
       (NULL, 3, 16, 4, CURRENT_TIMESTAMP(), 2, 1, 10008),
       (NULL, 4, 19, 3, CURRENT_TIMESTAMP(), 2, 1, 1998.9),
       (NULL, 5, 11, 2, CURRENT_TIMESTAMP(), 1, 1, 14840.5),
       (NULL, 6, 12, 1, CURRENT_TIMESTAMP(), 4, 1, 4898.99);

# Parte de creacion de las vistas (consigna)

-- Vista USUARIO_COMPRAS (permite visualizar los usuarios y sus compras: compras particulares)
CREATE VIEW usuario_compras AS
	SELECT u.id_user, u.username, u.first_name, u.last_name, c.id_purchase, f.title, c.date_of_purchase, c.quantity, c.subtotal
    FROM usuario u
    JOIN compra c ON u.id_user = c.id_user
    JOIN publicacion p ON c.id_publication = p.id_publication
    JOIN ficha_libro f ON p.book = f.id_book;
;

-- Vista INFO_LIBRO (permite visualizar los libros y su informacion de publicacion)
CREATE VIEW info_libro AS
	SELECT f.id_book, f.title, f.sku, f.book_description, g.genre, a.author, e.publisher
	FROM ficha_libro f
	JOIN libro_genero g ON f.genre = g.id_genre
	JOIN libro_autor a ON f.author = a.id_author
	JOIN libro_editorial e ON f.publisher = e.id_publisher;
    
-- Vista PUBLICACION_MENSAJES (permite visualizar todos los mensajes de cada publicacion)
CREATE VIEW publicacion_mensaje AS
	SELECT p.id_publication, u.id_user, u.first_name, m.content, m.date_of_message, m.reply
    FROM publicacion p
    JOIN mensaje m ON p.id_publication = m.id_publication
    JOIN usuario u ON m.id_user = u.id_user;
    
-- Vista USUARIO_COMPRAS_TOTALES (permite visualizar EL TOTAL de las compras realizadas por usuario: precio total)
CREATE VIEW usuario_compras_totales AS
	SELECT u.id_user, u.username, u.first_name, u.last_name, SUM(c.subtotal) AS total_sales
    FROM usuario u
    JOIN compra c ON u.id_user = c.id_user
    GROUP BY u.username;
    
-- Vista USUARIO_CANTIDAD_COMPRAS (permite visualizar la cantidad de compras realizadas por un usuario: cantidad de compras)
CREATE VIEW usuario_cantidad_compras AS
	SELECT u.id_user, u.username, u.email, COUNT(c.id_purchase) AS purchase_count
	FROM usuario u
	LEFT JOIN compra c ON u.id_user = c.id_user
	GROUP BY u.id_user;