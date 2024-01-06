create database ecommerce;

use ecommerce;

create table Image_Table(
image_ID int primary key auto_increment not null,
path varchar(255),
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);

create table TablesFormate_Table(
tableFormateId int primary key auto_increment not null,
headerName text ,
description text,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);
create table ListFormate_Table(
listFormateId int primary key auto_increment not null,
description text,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);

create table Description_Table(
description_ID int primary key auto_increment not null,
tableFormateId int not null,
listFormateId int not null,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp,
foreign key (tableFormateId) references TablesFormate_Table(tableFormateId) ,
foreign key (listFormateId) references ListFormate_Table(listFormateId)
);

create table Price_compare_table(
price_compare_ID int primary key auto_increment not null,
fixedPrice float not null,
fackPrice int not null,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);
create table Product_Inventory(
inventory_ID int primary key auto_increment not null,
quantity int not null,
warranty int ,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);

create table discount_table(
discount_ID int primary key auto_increment not null,
name varchar(255) not null,
discount_percentage decimal not null,
active boolean not null,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
 );
create table Product_Category(
category_id int primary key auto_increment not null,
name varchar(255) not null,
description text ,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp
);

create table Product_table(
product_ID int primary key auto_increment not null,
name varchar(255) not null,
description_ID int not null,
category_id int not null,
inventory_ID int not null,
price_compare_ID int not null ,
discount_ID int not null,
image_ID int not null,
created_at timestamp,
modified_at timestamp,
deleted_at timestamp,
foreign key (description_ID) references Description_Table(description_ID),
foreign key (category_id) references Product_Category(category_id) ,
foreign key (inventory_ID) references Product_Inventory(inventory_ID),
foreign key (price_compare_ID) references Price_compare_table(price_compare_ID),
foreign key (discount_ID) references discount_table(discount_ID),
foreign key (image_ID) references Image_Table(image_ID)
);

create table RelativeProductTable(
relativeProductId int primary key auto_increment not null,
product_ID int not null,
relative_Product_id int not null,
foreign key (product_ID) references Product_table(product_ID)
); 

create table user(
user_ID int primary key auto_increment not null,
username varchar(255) not null,
password text not null,
first_name varchar(255) not null,
last_name varchar (255),
telephone varchar(15) not null,
whatsapp_no varchar(15),
created_at timestamp,
modified_at timestamp
);

create table user_address(
user_address_id int not null primary key auto_increment,
user_ID int not null,
address_line1 varchar(255),
address_line2 varchar(255),
city varchar(50),
postal_code varchar(25),
country varchar(15),
foreign key(user_ID) references user(user_ID)
);

create table Order_details(
order_details_Id int primary key auto_increment not null,
user_ID int not null,
total decimal not null,
payment_ID int not null,
created_at timestamp,
modified_at timestamp,
foreign key(user_ID) references user(user_ID)
);

create table Order_items(
order_items_Id int primary key auto_increment not null,
product_ID int not null,
order_details_Id int not null,
quantity int not null,
created_at timestamp,
modified_at timestamp,
foreign key (product_ID) references Product_table(product_ID),
foreign key (order_details_Id) references Order_details(order_details_Id)
);

create table cart_item(
cart_item_id int primary key auto_increment not null,
product_ID int not null,
quantity int ,
created_at timestamp,
modified_at timestamp,
foreign key (product_ID) references Product_table(product_ID)
);

create table user_payment(
user_payment_ID  int primary key auto_increment not null,
 user_ID int not null,
payment_type varchar(35),
foreign key (user_ID) references user(user_ID)
);
create table payment_details(
payment_details_id  int primary key auto_increment not null,
order_details_Id int not null,
amount int not null,
provider varchar(255),
status varchar(35) not null,
created_at timestamp,
modified_at timestamp,
foreign key (order_details_Id) references Order_details(order_details_Id)
);


-- Dummy data for Image_Table
INSERT INTO Image_Table (path, created_at, modified_at, deleted_at) VALUES
('/images/product1.jpg', NOW(), NOW(), NULL),
('/images/product2.jpg', NOW(), NOW(), NULL),
('/images/product3.jpg', NOW(), NOW(), NULL),
('/images/product4.jpg', NOW(), NOW(), NULL),
('/images/product5.jpg', NOW(), NOW(), NULL);

-- Dummy data for TablesFormate_Table
INSERT INTO TablesFormate_Table (headerName, description, created_at, modified_at, deleted_at) VALUES
('Product Specs', 'Detailed specifications for each product', NOW(), NOW(), NULL),
('Product Features', 'Key features of each product', NOW(), NOW(), NULL),
('Warranty Info', 'Warranty information for each product', NOW(), NOW(), NULL);

-- Dummy data for ListFormate_Table
INSERT INTO ListFormate_Table (description, created_at, modified_at, deleted_at) VALUES
('Package includes: router, power adapter, user manual', NOW(), NOW(), NULL),
('Compatibility: Windows, Mac, Linux', NOW(), NOW(), NULL),
('Additional Accessories: Ethernet cable', NOW(), NOW(), NULL);


-- Dummy data for Description_Table
INSERT INTO Description_Table (tableFormateId, listFormateId, created_at, modified_at, deleted_at) VALUES
(1, 2, NOW(), NOW(), NULL),
(2, 3, NOW(), NOW(), NULL),
(1, 1, NOW(), NOW(), NULL),
(2, 2, NOW(), NOW(), NULL),
(1, 3, NOW(), NOW(), NULL);

-- Dummy data for Price_compare_table
INSERT INTO Price_compare_table (fixedPrice, fackPrice, created_at, modified_at, deleted_at) VALUES
(149.99, 129.99, NOW(), NOW(), NULL),
(199.99, 189.99, NOW(), NOW(), NULL),
(99.99, 79.99, NOW(), NOW(), NULL),
(149.99, 139.99, NOW(), NOW(), NULL),
(69.99, 59.99, NOW(), NOW(), NULL);

-- Dummy data for Product_Inventory
INSERT INTO Product_Inventory (quantity, warranty, created_at, modified_at, deleted_at) VALUES
(100, 12, NOW(), NOW(), NULL),
(50, 6, NOW(), NOW(), NULL),
(200, 24, NOW(), NOW(), NULL),
(75, 12, NOW(), NOW(), NULL),
(150, 18, NOW(), NOW(), NULL);

-- Dummy data for discount_table
INSERT INTO discount_table (name, discount_percentage, active, created_at, modified_at, deleted_at) VALUES
('Summer Sale', 15.00, true, NOW(), NOW(), NULL),
('Back-to-School', 10.00, true, NOW(), NOW(), NULL),
('Holiday Special', 20.00, true, NOW(), NOW(), NULL),
('Clearance', 30.00, true, NOW(), NOW(), NULL),
('New Customer Discount', 5.00, true, NOW(), NOW(), NULL);

-- Dummy data for Product_Category
INSERT INTO Product_Category (name, description, created_at, modified_at, deleted_at) VALUES
('Routers', 'Various types of routers for home and office use', NOW(), NOW(), NULL),
('Networking Accessories', 'Accessories like patch cords and adapters', NOW(), NOW(), NULL);

-- Dummy data for Product_table
INSERT INTO Product_table (name, description_ID, category_id, inventory_ID, price_compare_ID, discount_ID, image_ID, created_at, modified_at, deleted_at) VALUES
('Syrotech Singleband Router', 1, 1, 1, 1, 1, 1, NOW(), NOW(), NULL),
('Syrotech Dualband Router', 2, 1, 2, 2, 2, 2, NOW(), NOW(), NULL),
('Tenda N301 Router', 3, 1, 3, 3, 3, 3, NOW(), NOW(), NULL),
('Tenda Ac5 Router', 4, 1, 4, 4, 4, 4, NOW(), NOW(), NULL),
('Cisco Patchcord', 5, 2, 5, 5, 5, 5, NOW(), NOW(), NULL),
('RMG Adapter', 4, 2, 1, 1, 1, 1, NOW(), NOW(), NULL);

-- Dummy data for RelativeProductTable
INSERT INTO RelativeProductTable (product_ID, relative_Product_id) VALUES
(1, 2),
(3, 4),
(1, 3),
(2, 6);

-- Dummy data for user
INSERT INTO user (username, password, first_name, last_name, telephone, whatsapp_no, created_at, modified_at) VALUES
('john_doe', 'password123', 'John', 'Doe', '123456789', '987654321', NOW(), NOW()),
('jane_smith', 'pass456', 'Jane', 'Smith', '987654321', NULL, NOW(), NOW());

-- Dummy data for user_address
INSERT INTO user_address (user_ID, address_line1, address_line2, city, postal_code, country) VALUES
(1, '123 Main St', 'Apt 4B', 'Cityville', '12345', 'USA'),
(2, '456 Oak St', NULL, 'Townsville', '54321', 'USA');

-- Dummy data for Order_details
INSERT INTO Order_details (user_ID, total, payment_ID, created_at, modified_at) VALUES
(1, 249.99, 1, NOW(), NOW()),
(2, 169.99, 2, NOW(), NOW());

-- Dummy data for Order_items
INSERT INTO Order_items (product_ID, order_details_Id, quantity, created_at, modified_at) VALUES
(1, 1, 1, NOW(), NOW()),
(2, 1, 2, NOW(), NOW()),
(3, 2, 1, NOW(), NOW());

-- Dummy data for cart_item 
INSERT INTO cart_item (product_ID, quantity, created_at, modified_at) VALUES
(1, 1, NOW(), NOW()),
(4, 3, NOW(), NOW()),
(6, 2, NOW(), NOW());

-- Dummy data for user_payment
INSERT INTO user_payment (user_ID, payment_type) VALUES
(1, 'Credit Card'),
(2, 'PayPal');

-- Dummy data for payment_details
INSERT INTO payment_details (order_details_Id, amount, provider, status, created_at, modified_at) VALUES
(1, 249.99, 'Stripe', 'Completed', NOW(), NOW()),
(2, 169.99, 'PayPal', 'Pending', NOW(), NOW());


