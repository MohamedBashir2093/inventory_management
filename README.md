
![Screenshot 2025-05-07 120854](https://github.com/user-attachments/assets/c53da0ae-e972-4794-a814-40313e348cb5)


# Inventory Management System

### Description 

This project is a relational database solution for managing inventory, suppliers, products, categories, stock movements, orders, and customers. It tracks product quantities, customer orders, and supplier details across multiple warehouses.

### Features

* Manage **suppliers**, **products**, and **categories**.
* Track **stock movements** (in/out).
* Manage **orders** and **order details**.
* Monitor **warehouse stock** locations.

### Setup Instructions

1. **Clone the repository**:

   
   git clone https://github.com/MohamedBashir2093/inventory_management.git
  

2. **Import the SQL schema** into PostgreSQL/MySQL:

   * Create a new database:

     ```sql
     CREATE DATABASE inventory;
     ```
   * Run the `inventory.sql` script to create tables.

3. **Insert Sample Data**:
   The `inventory.sql` file includes sample data for testing.

### Example Queries

* Get all products:

  ```sql
  SELECT * FROM products;
  ```

* View stock movements for a product:

  ```sql
  SELECT * FROM stock_movements WHERE product_id = 1;
  ```

### Technologies Used

* PostgreSQL/MySQL
* SQL


