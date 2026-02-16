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

create table PriceHistory (
	price_history_id int auto_increment primary key,
    product_id int not null,
    old_price decimal(6, 2) not null,
    new_price decimal(6, 2) not null,
    change_date datetime not null,
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
('Must', 5),
('Rött Vin', 5),
('Vitt Vin', 5),
('Rosé Vin', 5),
('Aperitif & Bitter', 5),
('Avec', 5),
('Snaps', 5);

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
-- Rom & Lagrad Sockerrörssprit
('Planetery', 'Barbados', 309, 700, 40.0, 3, 23),
('Port Louiis', 'Mauritius', 119, 200, 40.0, 3, 23),
('Havana Club', 'Kuba', 262, 700, 37.5, 3, 23),
('Ron Zacapa', 'Guatemala', 599, 700, 40.0, 3, 23),
('Don Papa', 'Filippinerna', 499, 700, 40.0, 3, 23),
-- Vodka & Okryddat Brännvin
('Absolute Vodka', 'Sverige', 249, 700, 40.0, 3, 24),
('Dworek Vodka', 'Polen', 120, 350, 37.5, 3, 24),
('Koskenkorva Vodka', 'Finland', 131, 350, 37.5, 3, 24),
('Chum Churum', 'Sydkorea', 133, 350, 16.5, 3, 24),
('Nemiroff', 'Ukraina'm 239, 700, 37.5, 3, 24),
-- Grappa & Marc
('Villa Isa', 'Italien', 299, 500, 42.0, 3, 25),
('Montresor', 'Italien', 319, 700, 40.0, 3, 25),
('Rovero', 'Italien', 295, 500, 42.0, 3, 25),
('Marc de Bourgogne', 'Frankrike', 399, 700, 40.0, 3, 25),
-- Tequila & Mezcal
('Sierra', 'Mexiko', 229, 500, 38.0, 3, 26),
('Tosco', 'Mexiko', 139, 200, 40.0, 3, 26),
('1800 Añjeo', 'Mexiko', 459, 700, 38.0, 3, 26),
('Koch', 'Mexiko', 399, 700, 40.0, 3, 26),
-- Smaksatt Sprit
('Captain Morgan', 'Jamaica', 261, 700, 35.0, 3, 27),
('Bacardi Razz', 'Italien', 259, 700, 27.0, 3, 27),
('Absloute Vodka, Citron', 'Sverige', 264, 700, 40.0, 3, 27),
('Explorer Vodka, Röda Bär', 'Finland', 137, 350, 37.5, 3, 27),
('Absolute Vodka, Vanilia', 'Sverige', 264, 700, 38.0, 3, 27),
('Commander Jones', 'Nederländerna', 149, 350, 35.0, 3, 27),
('Bumbu', 'Barbados', 449, 700, 40.0, 3, 27),
('Absolute Vodka, Pear', 'Sverige', 264, 700, 38.0, 3, 27),
('Chum Churum, Peach', 'Sydkorea', 134, 350, 12.0, 3,  27),
('The Pirate Bay, Spiced', 'Dominikanska Republiken', 219, 700, 35.0, 3, 27),
-- Armagnac & Brandy
('Brandy Catedrático', 'Spanien', 95, 200, 36.0, 3, 28),
('St-Rémy', 'Frankrike', 259, 700, 36.0, 3, 28),
('Armagnac XO', 'Frankrike', 479, 700, 40.5, 3, 28),
('Tegnér & Son, Brandy', 'Frankrike', 169, 350, 38.0, 3, 28),
-- Drinkar & Cocktails
('Tapdance', 'Sverige', 159, 700, 15.0, 3, 29),
('Bacardi, Mojito Classic', 'Internationellt Märke', 155, 700, 14.9, 3, 29),
('Tr3 Apor, Päronglass Daiquiri', 'Sverige', 139, 700, 15.0, 3, 29),
('Hey Bae, Strawberry Daiquiri', 'Sverige', 169, 700, 15.0, 3, 29),
-- Bitter
('Gammel Dansk', 'Internationellt Märke', 318, 700, 38.0, 3, 30),
('Fernet-Branca', 'Italien', 254, 500, 39.0, 3, 30),
('Angostura', 'Trinidad och Tobago', 249, 200, 44.7, 3, 30),
-- Calvados
('Anée Fine Calvados Cuvée des Capucins', 'Frankrike', 236, 500, 40.0, 3, 31),
('Boular Calvados Grand Solage', 'Frankrike', 359, 700, 40.0, 3, 31),
('Château du Breuil', 'Frankrike', 369, 700, 40.0, 3, 31),
('Kiviks', 'Frankrike', 299, 500, 40.0, 3, 31),
-- Frukt & Druvsprit
('Eau de vie de Cidre', 'Frankrike', 399, 700, 40.0, 3, 32),
('Skånsk Åker av Dos Destiladores', 'Sverige', 299, 500, 41.5, 3, 32),
('Ljungbyholms', 'Sverige', 599, 500, 40.0, 3, 32),
('Kulla-D', 'Sverige', 538, 500, 40.0, 3, 32),
('Pomme de Vie', 'Sverige', 328, 350, 40.0, 3, 32),
-- Anissprit
('Pastis Nordique', 'Sverige', 129, 200, 40.0, 3, 33),
('Yeni Raki', 'Turkiet', 379, 700, 45.0, 3, 33),
('Pernod', 'Frankrike', 286, 700, 40.0, 3, 33),
('137:ans Arak', 'Sverige', 269, 500, 46.9, 3, 33),
-- Punsch
('Carlshamns Flaggpunsch', 'Finland', 199, 500, 26.0, 3, 34),
('Cederlunds', 'Finland', 199, 700, 26.0, 3, 34),
('Per Anderssons', 'Sverige', 189, 350, 22.0, 3, 34),
('Bestes Punsch', 'Sverige', 159, 350, 26.0, 3, 34),

-- Cider & Blanddrycker
-- Cider
('Briska Hallon', 'Sverige', 17.90, 330, 4.5, 4, 35),
('Somersby, Pear Cider', 'Internationellt Märke', 15.50, 330, 4.5, 4, 35),
('Kopparberg Pear Cider', 'Sverige', 20.90, 500, 7, 4, 35),
('Rekordling Skogsbär', 'Sverige', 500, 7, 4, 35),
('POMPOM Rosé', 'Sverige', 16.90, 330, 5.9, 4, 35),
('Strongbow', 'Storbritannien', 19.90, 330, 5, 4, 35),
('Liquid Industries, The Pina Colada Project', 'Sverige', 16.90, 330, 4.5, 4, 35),
('Briska, Passionfrukt & Persika', 'Sverige', 15.90, 330, 4.5, 4, 35),
('Liquid Industires, The Sour Project Grapefrukt, Lindblomma och Grönt Te', 'Sverige', 16.90, 330, 4.5, 4, 35),
('Rekordling Päron', 'Sverige', 14.90, 330, 4.5, 4, 35),
('Pistonhead, Hallon och Svarta Vinbär', 'Sverige', 14.90, 330, 4.5, 4, 35),
('Pistonhead, Hard Apple', 'Sverige', 16.90, 330, 6, 4, 35),
('Briska, Mango', 'Sverige', 15.90, 330, 4.5, 4, 35),
('Herrljunga, Smultron & Jordgubb Cider', 'Sverige', 15.40, 250, 4.5, 4, 35),
('Cidre Biologique', 'Frankrike', 66, 750, 4.5, 4, 35),
-- Blanddryck
('Lauder´s Whisky & Cola', 'Sverige', 23.90, 330, 4.5, 4, 36),
('Tapdance, Espresso Martini', 'Sverige', 24.90, 200, 5, 4, 36),
('POMPOM, Tropical', 'Sverige', 16.90, 330, 4.5, 4, 36),
('Liquid Industires, The Bellini Project', 'Sverige', 16.90, 330, 4.5, 4, 36),
('Doctor Cane, Mango Daiquiri', 'Sverige', 24.20, 250, 4, 4, 36),
('Original Long Drink, Grapefruit', 'Finland', 25.90, 330, 5.5, 4, 36),
('Smirnoff Ice', 'Internationellt Märke', 22.90, 275, 4, 4, 36),
('FORS Cocktails, Tom Collins Organic', 'Sverige', 25.90, 330, 5, 4, 36),
('Ginger Joe', 'Internationellt Märke', 21.90, 330, 4, 4, 36),
('Locla Hard Seltzer', 'Sverige', 21.90, 330, 4.5, 4, 36),

-- Alkoholfritt
-- Öl
('Oppigårds Winter Ale', 'Sverige', 11.90, 330, 0, 5, 37),
('Omnipollo', 'Belgien', 21.90, 330, 0, 5, 37),
('Vega, Easy IPA', 'Sverige', 19.90, 330, 0, 5, 37),
('Funky Fluid Ice Cream Sour', 'Polen', 39.80, 500, 0, 5, 37),
-- Mousserande
('Cognato Sparkling', 'Sydafrika', 79, 750, 0, 5, 38),
('Leitz', 'Tyskland', 32, 250, 0, 5, 38),
('Soolong Sparkling Tea', 'Tyskland', 149, 750, 0, 5, 38),
-- Cider & Blanddryck
('Apple Ice Tea Ekologisk', 'Sverige', 24.90, 250, 0, 5, 39),
('Björkad Cider', 'Sverige', 26.90, 250, 0, 5, 39),
('Galipette, Rosé', 'Frankrike', 19.90, 330, 5, 39),
('Kimino', 'Japan', 28.90, 250, 0, 5, 39),
-- Glögg & Andra Juldrycker
('Stockholms Bränneri, Winter Nogroni', 'Sverige', 79, 500, 0, 5, 40),
('Dufvenkrooks, Röd Glögg', 'Sverige', 45, 1000, 0, 5, 40),
('Duvenkrooks Saffrans Glögg', 'Sverige', 39, 375, 0, 5, 40),
('Blossa Sparkling & Spice, Classic Red', 'Tyskland', 61, 750, 0, 5, 40),
-- Drinkar & Martini
('ISH Lime Daiquiri', 'Österrike', 21.50, 250, 0, 5, 41),
('Stockholms Bränneri Spicy Pink Paloma', 'Sverige', 22.90, 250, 0, 5, 41),
('ISH, Espresso Cocktail Alcohol Free', 'Danmark', 19.90, 250, 0, 5, 41),
('Americano', 'Sverige', 22.80, 250, 0, 5, 41),
-- Must
('Gravensteiner', 'Sverige', 69, 500, 0, 5, 42),
('Grönsöömust', 'Sverige', 74, 750, 0, 5, 42),
-- Rött Vin
('The Flourishing', 'Belgien', 84, 750, 0, 5, 43),
('Sangre de Toro', 'Spanien', 42, 375, 0, 5, 43),
('Domaine de la Prade', 'Frankrike', 89, 750, 0, 5, 43),
-- Vitt Vin
('Edenvale', 'Australien', 99, 750, 0, 5, 44),
('Riesling Returns', 'Tyskland', 79, 750, 0, 5, 44),
('Edenvale Verdejo-Sauvignon Blanc', 'Spanien', 89, 750, 0, 5, 44),
-- Rosé Vin
('Periquita Rosé', 'Portugal', 65, 750, 0, 5, 45),
('Leitz', 'Tyskland', 74, 750, 0, 5, 45),
-- Aperitif & Bitter
('Hvonn Aperitif', 'Sverige', 169, 500, 0, 5, 46),
('Mionetto Aperitivo', 'Polen', 149, 500, 0, 5, 46),
('Stockholms Bränneri Apéro Soda', 'Sverige', 21.80, 250, 0, 5, 46),
-- Avec
('Glen Dochus, Highland Blend Alcohol Free', 'Storbritannien', 179, 700, 0, 5, 47),
('Lyre´s American Malt, Non Alcoholic', 'Nerderländerna', 189, 700, 0, 5, 47),
-- Snaps
('Skåne, Alkoholfri Snaps', 'Sverige', 69, 350, 0, 5, 48),
('O.P. Anderson, Alkoholfri Snaps Mixpack', 'Sverige', 109, 300, 0, 5, 48);


-- Aggregationsfunktioner
-- Updatera pris historiken
DELIMITER $$
create trigger update_price_history
before update on Product
for each row
begin
	if new.price != old.price then
		insert into PriceHistory (product_id, old_price, new_price, change_date)
        values (old.product_id, old.price, new.price, now());
	end if;
end $$
DELIMITER ;,

-- Totala intäkter per kategori
select c.name as category_name, sum(p.price * oi.quantity) as total_revenue
from Category c
join Subcategory sc on c.category_id = sc.category_id
join Product p on sc.subcategory_id = p.subcategory_id
join OrderItem oi on p.product_id = oi.product_id
group by c.name;

-- Mest sålda produkter
select p.name, sum(oi.quantity) as total_quantity_sold
from Product p
join OrderItem oi on p.product_id = oi.product_id
group by p.name
order by total_quantity_sold desc
limit 10;

-- Genomsnittligt pris per kategori
select c.name as category_name, avg(p.price) as average_price
from Category c
join Subcategory sc on c.category_id = sc_category_id
join Product p on sc.subcategory_id = p.subcategory_id
group by c.name;

-- Total försäljning per månad
select date_format(o.order_date, '%Y-%m') as month, sum(p.price * oi.quantity) as total_sales
from Orders o
join OrderItem oi on o.order_id = oi.order_id
join Product p on oi.product_id = p.product_id
group by month
order by month;

-- Procedur för att hämta prishistorik för en produkt
DELIMITER $$
create procedure GetPriceHistory(in product_id_param int)
begin
	select ph.change_date, ph.old_price, ph.new_price
    from PriceHistory ph
    where ph.product_id = product_id_param
    order by ph.change_date desc;
end $$
DELIMITER ;

-- Anropa proceduren
call GetPriceHistory(1);

-- Vyer (Views)
create view ProductSales as
select p.product_id, p.name, sum(oi.quantity) as total_quantity_sold, 
sum(p.price * oi.quantity) as total_revenue
from Product p
join OrderItem oi on p.product_id = oi.product_id
group by p.product_id, p.name;

-- Använd vyn
select * from ProductSales;