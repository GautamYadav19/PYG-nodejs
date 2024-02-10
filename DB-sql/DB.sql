create database ecommerce;
-- drop database ecommerce;

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
CREATE TABLE shipping_details (
    shipping_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_details_Id INT NOT NULL,
    user_ID  INT NOT NULL,
    shipping_method VARCHAR(255) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL,
    shipping_date TIMESTAMP,
    FOREIGN KEY (order_details_Id) REFERENCES Order_details(order_details_Id),
    FOREIGN KEY (user_ID ) REFERENCES user(user_ID)
);

-- Create a table to manage user wishlists and favorites
CREATE TABLE user_wishlists (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_ID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);

-- Create a table to track user sessions
CREATE TABLE user_sessions (
    session_id INT AUTO_INCREMENT primary KEY,
    user_ID INT NOT NULL,
    session_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    session_end TIMESTAMP,
    FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);

-- Create a table to store customer reviews and feedback
CREATE TABLE customer_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_ID INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (product_ID) REFERENCES Product_table(product_ID)
);

-- Create a table to store return requests
CREATE TABLE return_requests (
    return_request_id INT AUTO_INCREMENT PRIMARY KEY,
   order_details_Id INT NOT NULL,
    user_ID INT NOT NULL,
    reason TEXT NOT NULL,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_Id) REFERENCES Order_details(order_details_Id),
  FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);
-- Create a table to store order statuses
CREATE TABLE order_statuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL
);

-- Create a table to store order status history
CREATE TABLE order_status_history (
    status_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_details_Id INT NOT NULL,
    status_id INT NOT NULL,
    status_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_Id) REFERENCES Order_details(order_details_Id),
    FOREIGN KEY (status_id) REFERENCES order_statuses(status_id)
);

-- Create a table to track user interactions for predictive analytics ++
CREATE TABLE user_interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_ID INT NOT NULL,
    product_id INT NOT NULL,
    interaction_type ENUM('view', 'add_to_cart', 'purchase', 'like', 'dislike') NOT NULL,
    interaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (product_ID) REFERENCES Product_table(product_ID)
);

-- Create a table to store product recommendations
CREATE TABLE product_recommendations (			
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_ID INT NOT NULL,
    recommended_product_id INT NOT NULL,
   FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (recommended_product_id) REFERENCES Product_table(product_ID)
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

-- Insert dummy data into the shipping_details table
INSERT INTO shipping_details (order_details_Id, user_ID, shipping_method, shipping_cost, shipping_date)
VALUES
    (1, 1, 'Standard Shipping', 5.99, '2023-01-01 12:00:00'),
    (2, 2, 'Express Shipping', 10.99, '2023-01-02 14:30:00');
   

-- Insert dummy data into the user_wishlists table
INSERT INTO user_wishlists (user_ID, name)
VALUES
    (1, 'My Wishlist'),
    (2, 'Favorites'),
    (1, 'Tech Gadgets');

-- Insert dummy data into the user_sessions table
INSERT INTO user_sessions (user_ID, session_end)
VALUES
    (1, '2023-01-01 15:00:00'),
    (2, '2023-01-02 18:45:00'),
    (1, '2023-01-03 12:30:00');

-- Insert dummy data into the customer_reviews table
INSERT INTO customer_reviews (user_ID, product_id, rating, review_text, review_date)
VALUES
    (1, 1, 4, 'Great product, fast delivery!', '2023-01-01 08:00:00'),
    (2, 2, 5, 'Excellent quality and service!', '2023-01-02 10:30:00'),
    (1, 3, 3, 'Not as expected, but decent.', '2023-01-03 14:15:00');

-- Insert dummy data into the return_requests table
INSERT INTO return_requests (order_details_Id, user_ID, reason, request_date)
VALUES
    (1, 1, 'Product damaged upon arrival', '2023-01-01 16:30:00'),
    (2, 2, 'Changed my mind, want a refund', '2023-01-02 20:45:00');
    

-- Insert dummy data into the order_statuses table
INSERT INTO order_statuses (status_name)
VALUES
    ('Processing'),
    ('Shipped'),
    ('Delivered');

-- Insert dummy data into the order_status_history table
INSERT INTO order_status_history (order_details_Id, status_id, status_date)
VALUES
    (1, 1, '2023-01-01 09:00:00'),
    (2, 2, '2023-01-02 11:30:00');
    

-- Insert dummy data into the user_interactions table
INSERT INTO user_interactions (user_ID, product_id, interaction_type, interaction_date)
VALUES
    (1, 1, 'view', '2023-01-01 10:00:00'),
    (2, 2, 'add_to_cart', '2023-01-02 12:15:00'),
    (1, 3, 'purchase', '2023-01-03 14:30:00');

-- Insert dummy data into the product_recommendations table
INSERT INTO product_recommendations (user_ID, recommended_product_id)
VALUES
    (1, 2),
    (2, 1),
    (1, 3);

dfdfssssssssssssssssssssssssssssssssssssssssssssssssssssssss
-- Create the E-commerce Database
CREATE DATABASE IF NOT EXISTS ecommerce;

-- Switch to the E-commerce Database
USE ecommerce;

-- Image Table
CREATE TABLE IF NOT EXISTS Image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Table Format Table
CREATE TABLE IF NOT EXISTS TableFormat (
    table_format_id INT PRIMARY KEY AUTO_INCREMENT,
    header_name TEXT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- List Format Table
CREATE TABLE IF NOT EXISTS ListFormat (
    list_format_id INT PRIMARY KEY AUTO_INCREMENT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Description Table
CREATE TABLE IF NOT EXISTS Description (
    description_id INT PRIMARY KEY AUTO_INCREMENT,
    table_format_id INT NOT NULL,
    list_format_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (table_format_id) REFERENCES TableFormat(table_format_id),
    FOREIGN KEY (list_format_id) REFERENCES ListFormat(list_format_id)
);

-- Price Compare Table
CREATE TABLE IF NOT EXISTS PriceCompare (
    price_compare_id INT PRIMARY KEY AUTO_INCREMENT,
    fixed_price DECIMAL(10, 2) NOT NULL,
    fake_price INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Product Inventory Table
CREATE TABLE IF NOT EXISTS ProductInventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    warranty INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Discount Table
CREATE TABLE IF NOT EXISTS Discount (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    discount_percentage DECIMAL(5, 2) NOT NULL,
    active BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Product Category Table
CREATE TABLE IF NOT EXISTS ProductCategory (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Product Table
CREATE TABLE IF NOT EXISTS Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description_id INT NOT NULL,
    category_id INT NOT NULL,
    inventory_id INT NOT NULL,
    price_compare_id INT NOT NULL,
    discount_id INT NOT NULL,
    image_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (description_id) REFERENCES Description(description_id),
    FOREIGN KEY (category_id) REFERENCES ProductCategory(category_id),
    FOREIGN KEY (inventory_id) REFERENCES ProductInventory(inventory_id),
    FOREIGN KEY (price_compare_id) REFERENCES PriceCompare(price_compare_id),
    FOREIGN KEY (discount_id) REFERENCES Discount(discount_id),
    FOREIGN KEY (image_id) REFERENCES Image(image_id)
);

-- Relative Product Table
CREATE TABLE IF NOT EXISTS RelativeProduct (
    relative_product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (relative_product_id) REFERENCES Product(product_id)
);

-- User Table
CREATE TABLE IF NOT EXISTS User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password TEXT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255),
    telephone VARCHAR(15) NOT NULL,
    whatsapp_no VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User Address Table
CREATE TABLE IF NOT EXISTS UserAddress (
    user_address_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(50),
    postal_code VARCHAR(25),
    country VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Order Details Table
CREATE TABLE IF NOT EXISTS OrderDetails (
    order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    payment_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS OrderItems (
    order_items_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    order_details_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (order_details_id) REFERENCES OrderDetails(order_details_id)
);

-- Cart Item Table
CREATE TABLE IF NOT EXISTS CartItem (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- User Payment Table
CREATE TABLE IF NOT EXISTS UserPayment (
    user_payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    payment_type VARCHAR(35),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Payment Details Table
CREATE TABLE IF NOT EXISTS PaymentDetails (
    payment_details_id INT PRIMARY KEY AUTO_INCREMENT,
    order_details_id INT NOT NULL,
    amount INT NOT NULL,
    provider VARCHAR(255),
    status VARCHAR(35) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES OrderDetails(order_details_id)
);

-- Shipping Details Table
CREATE TABLE IF NOT EXISTS ShippingDetails (
    shipping_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_details_id INT NOT NULL,
    user_id INT NOT NULL,
    shipping_method VARCHAR(255) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL,
    shipping_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES OrderDetails(order_details_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- User Wishlists Table
CREATE TABLE IF NOT EXISTS UserWishlists (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- User Sessions Table
CREATE TABLE IF NOT EXISTS UserSessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    session_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    session_end TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Customer Reviews Table
CREATE TABLE IF NOT EXISTS CustomerReviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Return Requests Table
CREATE TABLE IF NOT EXISTS ReturnRequests (
    return_request_id INT PRIMARY KEY AUTO_INCREMENT,
    order_details_id INT NOT NULL,
    user_id INT NOT NULL,
    reason TEXT NOT NULL,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES OrderDetails(order_details_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Order Statuses Table
CREATE TABLE IF NOT EXISTS OrderStatuses (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL
);

-- Order Status History Table
CREATE TABLE IF NOT EXISTS OrderStatusHistory (
    status_history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_details_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_details_id) REFERENCES OrderDetails(order_details_id),
    FOREIGN KEY (status_id) REFERENCES OrderStatuses(status_id)
);

-- User Interactions Table
CREATE TABLE IF NOT EXISTS UserInteractions (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    interaction_type ENUM('view', 'add_to_cart', 'purchase', 'like', 'dislike') NOT NULL,
    interaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Product Recommendations Table
CREATE TABLE IF NOT EXISTS ProductRecommendations (			
    recommendation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    recommended_product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (recommended_product_id) REFERENCES Product(product_id)
);

-- Insert Dummy Data into Image Table
INSERT INTO Image (path) VALUES
    ('path1.jpg'),
    ('path2.jpg'),
    ('path3.jpg'),
    ('path4.jpg'),
    ('path5.jpg');

-- Insert Dummy Data into Table Format Table
INSERT INTO TableFormat (header_name, description) VALUES
    ('Header1', 'Description1'),
    ('Header2', 'Description2'),
    ('Header3', 'Description3'),
    ('Header4', 'Description4'),
    ('Header5', 'Description5');

-- Insert Dummy Data into List Format Table
INSERT INTO ListFormat (description) VALUES
    ('ListDescription1'),
    ('ListDescription2'),
    ('ListDescription3'),
    ('ListDescription4'),
    ('ListDescription5');

-- Insert Dummy Data into Description Table
INSERT INTO Description (table_format_id, list_format_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

-- Insert Dummy Data into Price Compare Table
INSERT INTO PriceCompare (fixed_price, fake_price) VALUES
    (100.00, 80),
    (150.00, 120),
    (80.00, 60),
    (200.00, 160),
    (120.00, 100);

-- Insert Dummy Data into Product Inventory Table
INSERT INTO ProductInventory (quantity, warranty) VALUES
    (50, 1),
    (30, 2),
    (40, 1),
    (20, 3),
    (60, 2);

-- Insert Dummy Data into Discount Table
INSERT INTO Discount (name, discount_percentage, active) VALUES
    ('Discount1', 10.00, true),
    ('Discount2', 15.00, true),
    ('Discount3', 5.00, true),
    ('Discount4', 20.00, true),
    ('Discount5', 12.00, true);

-- Insert Dummy Data into Product Category Table
INSERT INTO ProductCategory (name, description) VALUES
    ('Category1', 'CategoryDescription1'),
    ('Category2', 'CategoryDescription2'),
    ('Category3', 'CategoryDescription3'),
    ('Category4', 'CategoryDescription4'),
    ('Category5', 'CategoryDescription5');

-- Insert Dummy Data into Product Table
INSERT INTO Product (name, description_id, category_id, inventory_id, price_compare_id, discount_id, image_id) VALUES
    ('Product1', 1, 1, 1, 1, 1, 1),
    ('Product2', 2, 2, 2, 2, 2, 2),
    ('Product3', 3, 3, 3, 3, 3, 3),
    ('Product4', 4, 4, 4, 4, 4, 4),
    ('Product5', 5, 5, 5, 5, 5, 5);

-- Insert Dummy Data into Relative Product Table
INSERT INTO RelativeProduct (product_id, relative_product_id) VALUES
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 1);

-- Insert Dummy Data into User Table
INSERT INTO User (username, password, first_name, last_name, telephone, whatsapp_no) VALUES
    ('user1', 'password1', 'John', 'Doe', '1234567890', '9876543210'),
    ('user2', 'password2', 'Jane', 'Smith', '9876543210', '1234567890'),
    ('user3', 'password3', 'Bob', 'Johnson', '1112233445', '5556667777'),
    ('user4', 'password4', 'Alice', 'Williams', '4445556666', '8889990000'),
    ('user5', 'password5', 'Charlie', 'Brown', '7778889999', '1112223333');

-- Insert Dummy Data into User Address Table
INSERT INTO UserAddress (user_id, address_line1, address_line2, city, postal_code, country) VALUES
    (1, 'Address1-1', 'Address1-2', 'City1', '12345', 'Country1'),
    (2, 'Address2-1', 'Address2-2', 'City2', '54321', 'Country2'),
    (3, 'Address3-1', 'Address3-2', 'City3', '67890', 'Country3'),
    (4, 'Address4-1', 'Address4-2', 'City4', '09876', 'Country4'),
    (5, 'Address5-1', 'Address5-2', 'City5', '13579', 'Country5');

-- Insert Dummy Data into Order Details Table
INSERT INTO OrderDetails (user_id, total, payment_id) VALUES
    (1, 250.00, 1),
    (2, 180.00, 2),
    (3, 300.00, 3),
    (4, 200.00, 4),
    (5, 150.00, 5);

-- Insert Dummy Data into Order Items Table
INSERT INTO OrderItems (product_id, order_details_id, quantity) VALUES
    (1, 1, 2),
    (2, 2, 1),
    (3, 3, 3),
    (4, 4, 2),
    (5, 5, 1);

-- Insert Dummy Data into Cart Item Table
INSERT INTO CartItem (product_id, quantity) VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (4, 3),
    (5, 1);

-- Insert Dummy Data into User Payment Table
INSERT INTO UserPayment (user_id, payment_type) VALUES
    (1, 'Credit Card'),
    (2, 'PayPal'),
    (3, 'Debit Card'),
    (4, 'Cash on Delivery'),
    (5, 'Net Banking');

-- Insert Dummy Data into Payment Details Table
INSERT INTO PaymentDetails (order_details_id, amount, provider, status) VALUES
    (1, 250.00, 'PaymentProvider1', 'Paid'),
    (2, 180.00, 'PaymentProvider2', 'Paid'),
    (3, 300.00, 'PaymentProvider3', 'Pending'),
    (4, 200.00, 'PaymentProvider4', 'Paid'),
    (5, 150.00, 'PaymentProvider5', 'Pending');

-- Insert Dummy Data into Shipping Details Table
INSERT INTO ShippingDetails (order_details_id, user_id, shipping_method, shipping_cost, shipping_date) VALUES
    (1, 1, 'Standard Shipping', 20.00, '2023-01-01'),
    (2, 2, 'Express Shipping', 30.00, '2023-01-02'),
    (3, 3, 'Standard Shipping', 25.00, '2023-01-03'),
    (4, 4, 'Express Shipping', 35.00, '2023-01-04'),
    (5, 5, 'Standard Shipping', 15.00, '2023-01-05');

-- Insert Dummy Data into User Wishlists Table
INSERT INTO UserWishlists (user_id, name) VALUES
    (1, 'Wishlist1'),
    (2, 'Wishlist2'),
    (3, 'Wishlist3'),
    (4, 'Wishlist4'),
    (5, 'Wishlist5');

-- Insert Dummy Data into User Sessions Table
INSERT INTO UserSessions (user_id, session_start, session_end) VALUES
    (1, '2023-01-01 10:00:00', '2023-01-01 12:00:00'),
    (2, '2023-01-02 11:00:00', '2023-01-02 13:00:00'),
    (3, '2023-01-03 12:00:00', '2023-01-03 14:00:00'),
    (4, '2023-01-04 13:00:00', '2023-01-04 15:00:00'),
    (5, '2023-01-05 14:00:00', '2023-01-05 16:00:00');

-- Insert Dummy Data into Customer Reviews Table
INSERT INTO CustomerReviews (user_id, product_id, rating, review_text, review_date) VALUES
    (1, 1, 4, 'Great product!', '2023-01-01'),
    (2, 2, 5, 'Excellent service!', '2023-01-02'),
    (3, 3, 3, 'Average experience.', '2023-01-03'),
    (4, 4, 2, 'Not satisfied.', '2023-01-04'),
    (5, 5, 4, 'Good value for money.', '2023-01-05');

-- Insert Dummy Data into Return Requests Table
INSERT INTO ReturnRequests (order_details_id, user_id, reason, request_date) VALUES
    (1, 1, 'Product damaged', '2023-01-01'),
    (2, 2, 'Wrong item received', '2023-01-02'),
    (3, 3, 'Changed my mind', '2023-01-03'),
    (4, 4, 'Defective product', '2023-01-04'),
    (5, 5, 'Not as described', '2023-01-05');

-- Insert Dummy Data into Order Statuses Table
INSERT INTO OrderStatuses (status_name) VALUES
    ('Processing'),
    ('Shipped'),
    ('Delivered'),
    ('Cancelled'),
    ('Returned');

-- Insert Dummy Data into Order Status History Table
INSERT INTO OrderStatusHistory (order_details_id, status_id, status_date) VALUES
    (1, 1, '2023-01-01'),
    (2, 2, '2023-01-02'),
    (3, 3, '2023-01-03'),
    (4, 4, '2023-01-04'),
    (5, 5, '2023-01-05');

-- Insert Dummy Data into User Interactions Table
INSERT INTO UserInteractions (user_id, product_id, interaction_type, interaction_date) VALUES
    (1, 1, 'view', '2023-01-01'),
    (2, 2, 'add_to_cart', '2023-01-02'),
    (3, 3, 'purchase', '2023-01-03'),
    (4, 4, 'like', '2023-01-04'),
    (5, 5, 'dislike', '2023-01-05');

-- Insert Dummy Data into Product Recommendations Table
INSERT INTO ProductRecommendations (user_id, recommended_product_id) VALUES
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 1);
