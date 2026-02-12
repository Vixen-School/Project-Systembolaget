create database if not exists dv1587_project;
use dv1587_project;

create table Category (
	category_id INT auto_increment primary key,
	name varchar(50) not null
);

create table Subcategory (
	subcategory_id int auto_increment primary key,
    name varchar(50) not null,
    category_id int,
    foreign key (category_id) references Category(category_id)
);

create table Product (
	product_id int auto_increment primary key,
    name varchar(100) not null,
    country varchar(100) not null,
    price decimal(6,2) not null,
    volume_ml int,
    alcohol_percent decimal(4,2),
    category_id int,
    subcategory_id int,
    foreign key (category_id) references Category(category_id),
    foreign key (subcategory_id) references Subcategory(subcategory_id)
);

create table Customer (
	customer_id int auto_increment primary key,
    name varchar(100),
    age int,
    address varchar(200)
);

create table Orders (
	order_id int auto_increment primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references Customer(customer_id)
);

create table OrderItem (
	order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Product(product_id)
);

insert into Category (name) Values
('Vin'),
('Öl'),
('Sprit'),
('Cider & Blanddrycker'),
('Alkoholfritt');

insert into Subcategory (name, category_id) values
('Rött', 1),
('Vitt', 1),
('Mousserande', 1),
('Rosé', 1),
('Vinlåda', 1),
('Starkvin', 1),
('Smaksat- & Fruktvin', 1),
('Glögg', 1),
('Vermouth', 1),
('Aperitifer' ,1),
('Sake', 1),
('Ale', 2),
('Ljus Lager', 2),
('Syrlig', 2),
('Porter & Stout', 2),
('Mellanmörk & Mörk Lager', 2),
('Vete', 2),
('Annan', 2),
('Whisky', 3),
('Likör', 3),
('Gin & Genever', 3),
('Akvavit & Kryddat Brännvin', 3),
('Cognac', 3),
('Rom & Lagrad Sockerrörssprit', 3),
('Vodka & Okryddat Brännvin', 3),
('Grappa & Marc', 3),
('Tequila & Mezcal', 3),
('Smaksatt Sprit', 3),
('Armagnac & Brandy', 3),
('Drinkar & Cocktails', 3),
('Bitter', 3),
('Calvados', 3),
('Frukt & Druvsprit', 3),
('Anissprit', 3),
('Punsch', 3),
('Cider', 4),
('Blanddrycker', 4),
('Öl', 5),
('Mousserande', 5),
('Cider & Blanddrycker', 5),
('Glögg & Andra Juldrycker', 5),
('Drinkar & Cocktail', 5),
('Must', 5);

insert into Product (name, country, price, volume_ml, alcohol_percent, category_id, subcategory_id) values
-- Vin
-- Rött
('Smoke & Oak', 'Australien', 99, 1000, 14.5, 1, 1),
('Terre du Sud', 'Frankrike', 129, 750, 13.5, 1, 1),
('Grower´s Club', 'Sydafrika', 79, 750, 7.5, 1, 1),
('Casa de Cambres', 'Portugal', 129, 750, 13.5, 1, 1),
('La Molla', 'Italien', 149, 750, 15.0, 1, 1),
-- Vitt
('Adega de Moncão', 'Portugal', 99, 750, 13.0, 1, 2),
('Montespina', 'Spanien', 99, 750, 13.0, 1, 2),
('Nittnaus', 'Österrike', 129, 375, 9.0, 1, 2),
('Tapiz', 'Argentina', 99, 750, 13.5, 1, 2),
('Sofia u Sebastian', 'USA', 99, 750, 14.0, 1, 2),
-- Mousserat
('Emily Blanc de Blancs', 'Spanien', 85, 750, 8.5, 1, 3),
('Sander', 'Tyskland', 179, 750, 11.5, 1, 3),
('Pirie', 'Australien', 249, 750, 12.5, 1, 3),
('B.R.O.T', 'Spanien', 99, 750, 11.5, 1, 3),
('La Belle', 'Argentina', 149, 750, 12.0, 1, 3),
-- Rosé
('KWV', 'Sydafrika', 99, 750, 13.0, 1, 4),
('Black Tower', 'EU', 79, 750, 8.5, 1, 4),
('Spring Village', 'Frankrike', 35, 187, 12.0, 1, 4),
('Domaine de Collavery', 'Frankrike', 110, 750, 12.5, 1, 4),
-- Vinlåda
('Trossen', 'Tyskland', 1578, 4500, 11.0, 1, 5),
('The Taste of Bardolino', 'Italien', 1176, 4500, 13.0, 1, 5),
-- Starkvin
('Fronseca', 'Portugal', 249, 750, 20.0, 1, 6),
('Florio', 'Italien', 89, 375, 18.0, 1, 6),
('Vintry´s Red Port', 'Portugal', 79, 375, 20.0, 1, 6),
('Bristol Cream', 'Spanien', 139, 750, 17.5, 1, 6),
('Real Tesoro', 'Spanien', 107, 750, 15.0, 1, 6),
-- Smaksatt- & Fruktvin
('Caprice Kir', 'Finland', 89, 750, 13.0, 1, 7),
('JP Chenet', 'Frankrike', 39, 200, 10.0, 1, 7),
('Solbacka Körsbärsvin', 'Finland', 89, 750, 13.0, 1, 7),
('Varm & Kall', 'Sverige', 59, 750, 7.0, 1, 7),
('Aurora', 'Finland', 85, 750, 13.0, 1, 7),
-- Glögg
('Blossa Vinglögg', 'Internationellt Märke', 99, 750, 10.0, 1, 8),
('Tegnér & Son', 'Sverige', 99, 750, 12.0, 1, 8),
('Blossa', 'Finland', 73, 375, 10.0, 1, 8),
('Hellström Glögg', 'Sverige', 285, 500, 15.0, 1, 8),
-- Vermouth
('Martini', 'Italien', 119, 750, 15.0, 1, 9),
('Perlino', 'Italien', 79, 750, 15.0, 1, 9),
('Moilly Prat', 'Frankrike', 165, 750, 18.0, 1, 9),
('Carpano', 'Italien', 215, 375, 16.5, 1, 9),
('Marezzo', 'Finland', 99, 750, 14.9, 1, 9),
-- Aperitifer
('Aperol', 'Italien', 215, 700, 11.0, 1, 10),
('Campari Bitter', 'Italien', 289, 700, 25.0, 1, 10),
('Marinella', 'Finland', 89, 750, 15.0, 1, 10),
('Rosita', 'Finland', 123, 750, 19.0, 1, 10),
('Svensk Sommar', 'Sverige', 129, 500, 20.0, 1, 10),
-- Sake
('Mikadomatsu', 'Japan', 179, 720, 15.0, 1, 11), 
('Akita Fuji Nigori', 'Japan', 129, 300, 14.5, 1, 11),
('Ile Four Yuzu', 'Japan', 209, 500, 10.5, 1, 11),
('Kyohime Takumi', 'Japan', 219, 720, 15.0, 1, 11),

-- Öl
-- Ale
('Slottskällan', 'Sverige', 16, 330, 5.6, 2, 12),
('Buxton Brewery', 'Storbritannien', 22, 330, 6.0, 2, 12),
('Nästgårds', 'Sverige', 20, 500, 5.9, 2, 12),
('Brooklyn', 'Internationellt Märke', 18, 330, 6.9, 2, 12),
('La Trappe Blond', 'Nederländerna', 34, 330, 6.5, 2, 12),
-- Ljus Lager
('Casello Lager', 'Italien', 18, 500, 4.8, 2, 13),
('Cruzcampo', 'Spanien', 18, 330, 6.4, 2, 13),
('Ey´Bro', 'Sverige', 10, 330, 5.0, 2, 13),
('Mariestads Export', 'Sverige', 18, 500, 5.3, 2, 13),
('Staropramen', 'Tjeckien', 15, 330, 5.0, 2, 13),
-- Syrlig 
('Timmermans', 'Belgien', 26, 250, 4.0, 2, 14),
('Duggers Stillwater Artisanal', 'Sverige', 37, 330, 4.5, 2, 14),
('3 Fonteinen', 'Belgien', 99, 375, 6.7, 2, 14),
('Vault City', 'Storbritannien', 35, 440, 4.1, 2, 14),
('Tankbusters', 'Polen', 62, 500,  5.0, 2, 14),
-- Porter & Stout
('Mad Cow', 'Ungern', 25, 330, 5.0, 2, 15),
('Guinness', 'Irland', 29, 440, 4.2, 2, 15),
('Innis & Gunn', 'Storbritannien', 25, 330, 6.1, 2, 15),
('Carnegie', 'Sverige', 21, 330, 5.5, 2, 15),
('Finn', 'Sverige', 25, 330, 5.5, 2, 15),
-- Mellanmörk & Mörk Lager
('Eschenbacher', 'Tyskland', 29, 500, 5.5, 2, 16),
('Primator', 'Tjeckien', 23, 500, 4.5, 2, 16),
('Zlatopramen', 'Tjeckien', 14, 330, 4.8, 2, 16),
('Bernard', 'Tjeckien', 23, 330, 5.0, 2, 16),
('Eriksberg', 'Sverige', 14, 330, 5.4, 2, 16),
-- Veteöl
('Schöfferhofer', 'Tyskland', 15, 330, 5.0, 2, 17),
('Franziskaner', 'Tyskland', 24, 500, 5.0, 2, 17),
('Gotlands Bryggeri', 'Sverige', 26, 500, 5.2, 2, 17),
('Erdinger', 'Tyskland', 26, 500, 5.3, 2, 17),
('Maristads', 'Sverige', 20, 500, 5.5, 2, 17),

-- Sprit
-- Whisky
('Peated Sheep Dip', 'Storbritannien', 299, 700, 45.0, 3, 18),
('Lord Calvert', 'Kanada', 237, 700, 40.0, 3, 18),
('The Famous Grouse', 'Storbritannien', 289, 700, 40.0, 3, 18),
('Tullamore Dew', 'Irland', 169, 350, 40.0, 3, 18),
('Jack Daniel´s', 'USA', 349, 700, 40.0, 3, 18),
-- Likör
('Tr3 Apor', 'Italien', 129, 500, 15.0, 3, 19),
('Disaronno', 'Italien', 225, 500, 28.0, 3, 19),
('Baileys', 'Irland', 239, 700, 17.0, 3, 19),
('Jägermeister', 'Tyskland', 309, 700, 35.0, 3, 19),
('Cointreau', 'Frankrike', 205, 350, 40.0, 3, 19),
('Minttu', 'Finland', 199, 500, 32.0, 3, 19),
('Amarula Cream', 'Sydafrika', 129, 17.0, 3, 19),
('Kahlúa', 'Mexiko', 209, 500, 16.0, 3, 19),
('Limoncello Dicapri', 'Italien', 229, 500, 30.0, 3, 19),
('Galliano', 'Italien', 219, 500, 30.0, 3, 19),
('Rock Shotz', 'Danmark', 119, 120, 30.0, 3, 19),
('Passoã', 'Frankrike', 145, 350, 17.0, 3, 19),
('Sheridan´s Original', 'Irland', 200, 500, 15.5, 3, 19),
('Tequila Rose', 'Internatiollt Märke', 179, 500, 15.0, 3, 19),
('Midori', 'USA', 225, 700, 20.0, 3, 19),
('Dooley´s', 'Tyskland', 209, 700, 17.0, 3, 19),
-- Gin & Genever
('Mälardalens Destilleri', 'Sverige', 209, 700, 37.5, 3, 20),
('All About Gin', 'Sverige', 99, 200, 45.0, 3, 20),
('Bombay Sapphire', 'Storbritannien', 299, 700, 40.0, 3, 20),
('Hernö', 'Sverige', 337, 500, 40.5, 3, 20),
-- Akvavit & Kryddat Brännvin
('Skåne Akvavit', 'Sverige', 274, 700, 38.0, 3, 21),
('Hallands Fläder', 'Sverige', 169, 350, 38.0, 3, 21),
('Lysholm Linie Aquavit', 'Norge', 329, 700, 41.5, 3, 21),
('Bäska Droppar', 'Sverige', 245, 500, 40.0, 3, 21),
-- Cognac
('Meukow Deluxe', 'Frankrike', 349, 700, 40.0, 3, 22),
('Braastad', 'Frankrike', 399, 700, 40.0, 3, 22),
('Hennessy VS', 'Frankrike', 499, 700, 40.0, 3, 22),
-- Rom % Lagrad Sockerrörssprit
