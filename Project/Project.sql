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
('Smaksat- & Fruktöl', 1),
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
('Smoke & Oak', 'Australien', 99, 1000, 14.5, 1, 1),
('Terre du Sud', 'Frankrike', 129, 750, 13.5, 1, 1),
('Grower´s Club', 'Sydafrika', 79, 750, 7.5, 1, 1),
('Casa de Cambres', 'Portugal', 129, 750, 13.5, 1, 1),
('La Molla', 'Italien', 149, 750, 15.0, 1, 1),
('Adega de Moncão', 'Portugal', 99, 750, 13.0, 1, 2),
('Montespina', 'Spanien', 99, 750, 13.0, 1, 2),
('Nittnaus', 'Österrike', 129, 375, 9.0, 1, 2),
('Tapiz', 'Argentina', 99, 750, 13.5, 1, 2),
('Sofia u Sebastian', 'USA', 99, 750, 14.0, 1, 2),
('Emily Blanc de Blancs', 'Spanien', 85, 750, 8.5, 1, 3),
('Sander', 'Tyskland', 179, 750, 11.5, 1, 3),
('Pirie', 'Australien', 249, 750, 12.5, 1, 3),
('B.R.O.T', 'Spanien', 99, 750, 11.5, 1, 3),
('La Belle', 'Argentina', 149, 750, 12.0, 1, 3),
('KWV', 'Sydafrika', 99, 750, 13.0, 1, 4),
('Black Tower', 'EU', 79, 750, 8.5, 1, 4),
('Spring Village', 'Frankrike', 35, 187, 12.0, 1, 4),
('Domaine de Collavery', 'Frankrike', 110, 750, 12.5, 1, 4),
('Trossen', 'Tyskland', 1578, 6*750, 11.0, 1, 5),
('The Taste of Bardolino', 'Italien', 1176, 6*750, 13.0, 1, 5),
('Fronseca', 'Portugal', 249, 750, 20.0, 1, 6),
('Florio', 'Italien', 89, 375, 18.0, 1, 6),
('Vintry´s Red Port', 'Portugal', 79, 375, 20.0, 1, 6),
('Bristol Cream', 'Spanien', 139, 750, 17.5, 1, 6),
('Real Tesoro', 'Spanien', 107, 750, 15.0, 1, 6),
('Caprice Kir', 'Finland', 89, 750, 13.0, 1, 7),
('JP Chenet', 'Frankrike', 39, 200, 10.0, 1, 7),
('Solbacka Körsbärsvin', 'Finland', 89, 750, 13.0, 1, 7),
('Varm & Kall', 'Sverige', 59, 750, 7.0, 1, 7),
('Aurora', 'Finland', 85, 750, 13.0, 1, 7),
('Blossa Vinglögg', 'Internationellt Märke', 99, 750, 10.0, 1, 8),
('Tegnér & Son', 'Sverige', 99, 750, 12.0, 1, 8),
('Blossa', 'Finland', 73, 375, 10.0, 1, 8),
('Hellström Glögg', 'Sverige', 285, 500, 15.0, 1, 8),
('Martini', 'Italien', 119, 750, 15.0, 1, 9),
('Perlino', 'Italien', 79, 750, 15.0, 1, 9),
('Moilly Prat', 'Frankrike', 165, 750, 18.0, 1, 9),
('Carpano', 'Italien', 215, 375, 16.5, 1, 9),
('Marezzo', 'Finland', 99, 750, 14.9, 1, 9),
('Aperol', 'Italien', 215, 700, 11.0, 1, 10),
('Campari Bitter', 'Italien', 289, 700, 25.0, 1, 10),
('Marinella', 'Finland', 89, 750, 15.0, 1, 10),
('Rosita', 'Finland', 123, 750, 19.0, 1, 10),
('Svensk Sommar', 'Sverige', 129, 500, 20.0, 1, 10),
