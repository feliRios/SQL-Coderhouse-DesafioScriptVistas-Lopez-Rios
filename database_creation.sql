CREATE SCHEMA `success_mindset` ;

USE success_mindset;

-- Tabla USUARIO

CREATE Table usuario (
	id_user INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    username VARCHAR(30) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(60) NOT NULL,
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_password VARCHAR(255) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    is_staff BOOL DEFAULT 0 NOT NULL
);

-- Tabla LIBRO_GENERO

CREATE Table libro_genero (
	id_genre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    genre VARCHAR(30) UNIQUE NOT NULL
);

-- Tabla LIBRO_AUTOR

CREATE Table libro_autor (
	id_author INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    author VARCHAR(60) UNIQUE NOT NULL
);

-- Tabla LIBRO_EDITORIAL

CREATE Table libro_editorial (
	id_publisher INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    publisher VARCHAR(30) UNIQUE NOT NULL
);

-- Tabla FICHA_LIBRO

CREATE Table ficha_libro (
	id_book INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    publisher INT NOT NULL,
    genre INT NOT NULL,
    author INT NOT NULL,
    sku INT,  -- Numero ISBN del libro
    book_description TEXT,
    title VARCHAR(80) NOT NULL,
    CONSTRAINT fk_genre FOREIGN KEY(genre) REFERENCES libro_genero(id_genre) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_author FOREIGN KEY(author) REFERENCES libro_autor(id_author) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_publisher FOREIGN KEY(publisher) REFERENCES libro_editorial(id_publisher) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla PUBLICACION

CREATE Table publicacion (
	id_publication INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_user INT NOT NULL,
    book INT NOT NULL,
    price FLOAT NOT NULL,
    stock INT NOT NULL,
    publication_description TEXT,
    date_publication DATETIME DEFAULT CURRENT_TIMESTAMP,
    img VARCHAR(255) DEFAULT 'https://i.imgur.com/tOj1c0U.jpg',
    CONSTRAINT fk_user FOREIGN KEY(id_user) REFERENCES usuario(id_user) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_book FOREIGN KEY(book) REFERENCES ficha_libro(id_book) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla MENSAJE

CREATE Table mensaje (
	id_message INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_user INT NOT NULL,
    id_publication INT NOT NULL,
    content TEXT NOT NULL,
    reply TEXT,
    date_of_message DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender_user FOREIGN KEY(id_user) REFERENCES usuario(id_user) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_publication FOREIGN KEY(id_publication) REFERENCES publicacion(id_publication) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla ENVIO

CREATE Table envio (
	id_shipping INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    price FLOAT NOT NULL,
    shipping_address VARCHAR(120) NOT NULL,
    date_of_shipping DATETIME NOT NULL
);

-- Tabla COMPRA_METODO

CREATE Table compra_metodo (
	id_payment_method INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    payment_method VARCHAR(15) UNIQUE NOT NULL
);

-- Tabla COMPRA

CREATE Table compra (
	id_purchase INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_publication INT NOT NULL,
    id_user INT NOT NULL,
    id_shipping INT NOT NULL,
    date_of_purchase DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method INT NOT NULL,
    quantity INT NOT NULL,
    subtotal FLOAT NOT NULL,
    CONSTRAINT fk_purchase_publication FOREIGN KEY(id_publication) REFERENCES publicacion(id_publication) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_buyer FOREIGN KEY(id_user) REFERENCES usuario(id_user) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_shipping FOREIGN KEY(id_shipping) REFERENCES envio(id_shipping) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_payment_method FOREIGN KEY(payment_method) REFERENCES compra_metodo(id_payment_method) ON UPDATE CASCADE ON DELETE CASCADE
);