

CREATE DATABASE inventory;

-- CREATING TABLES

-- Suppliers Table
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE
);

-- Categories Table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    supplier_id INT REFERENCES suppliers(supplier_id) ON DELETE SET NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

-- Product ↔ Category (M-M)
CREATE TABLE product_category (
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

-- Stock Movements Table (IN/OUT)
CREATE TABLE stock_movements (
    movement_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    movement_type VARCHAR(10) CHECK (movement_type IN ('IN', 'OUT')) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    movement_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);

-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20)
);

-- Orders Table (Make sure the customers table is created first)
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE SET NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Canceled')) NOT NULL
);

-- OrderDetails Table (Links Orders to Products)
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL
);

-- Warehouses Table
CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location TEXT
);

-- Product Location Table (Tracks quantity at each warehouse)
CREATE TABLE product_location (
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    warehouse_id INT REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id, warehouse_id)
);







-- Sample Data Insertion

-- Suppliers
INSERT INTO suppliers (name, contact_email)
VALUES
('Supplier A', 'contact@suppliera.com'),
('Supplier B', 'contact@supplierb.com'),
('Supplier C', 'contact@supplierc.com');

-- Categories
INSERT INTO categories (name)
VALUES
('Electronics'),
('Furniture'),
('Clothing'),
('Toys');

-- Products
INSERT INTO products (name, sku, supplier_id, quantity_in_stock, price)
VALUES
('Laptop', 'SKU001', 1, 50, 999.99),
('Chair', 'SKU002', 2, 200, 49.99),
('T-Shirt', 'SKU003', 3, 150, 19.99),
('Toy Car', 'SKU004', 1, 300, 14.99);

-- Product ↔ Category (M-M)
INSERT INTO product_category (product_id, category_id)
VALUES
(1, 1),  -- Laptop in Electronics
(2, 2),  -- Chair in Furniture
(3, 3),  -- T-Shirt in Clothing
(4, 4);  -- Toy Car in Toys

-- Stock Movements
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, notes)
VALUES
(1, 'IN', 100, '2025-05-07 10:00:00', 'Restock'),
(2, 'OUT', 20, '2025-05-07 11:00:00', 'Sold'),
(3, 'IN', 50, '2025-05-07 12:00:00', 'Restock'),
(4, 'OUT', 100, '2025-05-07 13:00:00', 'Sold');

-- Customers
INSERT INTO customers (name, contact_email, phone_number)
VALUES
('John Doe', 'john.doe@email.com', '123-456-7890'),
('Jane Smith', 'jane.smith@email.com', '234-567-8901'),
('Michael Johnson', 'michael.johnson@email.com', '345-678-9012');

-- Warehouses
INSERT INTO warehouses (name, location)
VALUES
('Warehouse A', '1234 First St, City, Country'),
('Warehouse B', '5678 Second St, City, Country');

-- Product Location (Stock at each warehouse)
INSERT INTO product_location (product_id, warehouse_id, quantity)
VALUES
(1, 1, 30),  -- 30 Laptops in Warehouse A
(2, 2, 100),  -- 100 Chairs in Warehouse B
(3, 1, 80),  -- 80 T-Shirts in Warehouse A
(4, 2, 200);  -- 200 Toy Cars in Warehouse B



