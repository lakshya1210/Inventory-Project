-- File containing queries for creating tables.

-- Table storing a list of brands of products.
CREATE TABLE IF NOT EXISTS brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(50) NOT NULL
);

-- Table storing a list of various product categories.
CREATE TABLE IF NOT EXISTS category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    parent_id INT REFERENCES category(category_id),
    depth INT CHECK (depth >= 0)
);

-- Table storing details about products in our inventory.
CREATE TABLE IF NOT EXISTS product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    mrp NUMERIC(10, 2) NOT NULL CHECK (mrp > 0),
    selling_price NUMERIC(10, 2) NOT NULL CHECK (
        selling_price > 0 AND
        selling_price <= mrp
    ),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    reserved_stock INT NOT NULL DEFAULT 0 CHECK (reserved_stock >= 0)
);

-- Table storing details about our suppliers.
CREATE TABLE IF NOT EXISTS supplier (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact_number CHAR(10) NOT NULL CHECK (contact_number NOT LIKE '%[^0-9]%'),
    email VARCHAR(30) NOT NULL CHECK (email LIKE '%_@__%.__%')
);

-- Table storing details about our customers.
CREATE TABLE IF NOT EXISTS customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact_number CHAR(10) NOT NULL CHECK (contact_number NOT LIKE '%[^0-9]%'),
    email VARCHAR(30) NOT NULL CHECK (email LIKE '%_@__%.__%')
);

-- Table storing details about our invoices to suppliers.
CREATE TABLE IF NOT EXISTS invoice (
    invoice_id SERIAL PRIMARY KEY,
    invoice_date TIMESTAMP NOT NULL DEFAULT NOW(),
    quantity INT NOT NULL CHECK (quantity > 0),
    bill_amount NUMERIC(10, 2) NOT NULL CHECK (bill_amount > 0),
    status VARCHAR(50) NOT NULL DEFAULT 'NOT PAID' CHECK (
        status = 'PAID' OR 
        status = 'NOT PAID' OR
        status = 'CANCELLED'
    )
);

-- Table storing details about our customers' orders.
CREATE TABLE IF NOT EXISTS customer_order (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP NOT NULL DEFAULT NOW(),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    status VARCHAR(50) NOT NULL DEFAULT 'NOT PAID' CHECK (
        status = 'PAID' OR 
        status = 'NOT PAID' OR
        status = 'CANCELLED'
    )
);

-- Table storing payment information pertaining to our customers' orders.
CREATE TABLE IF NOT EXISTS customer_payment (
    order_id INT PRIMARY KEY REFERENCES customer_order(order_id),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP NOT NULL DEFAULT NOW(),
    payment_mode VARCHAR(50) NOT NULL DEFAULT 'CASH' CHECK (
        payment_mode = 'CASH' OR
        payment_mode = 'CARD' OR 
        payment_mode = 'DIGITAL'
    ),
    comments VARCHAR(200)
);

-- Table relating products to their respective brands (if they exist).
CREATE TABLE IF NOT EXISTS product_brand (
    product_id INT PRIMARY KEY REFERENCES product(product_id),
    brand_id INT NOT NULL REFERENCES brand(brand_id)
);

-- Table relating products to their respective categories (if they exist).
CREATE TABLE IF NOT EXISTS product_category (
    product_id INT PRIMARY KEY REFERENCES product(product_id),
    category_id INT NOT NULL REFERENCES category(category_id)
);

-- Table to denote the supplying relationship.
CREATE TABLE IF NOT EXISTS supplies (
    invoice_id INT PRIMARY KEY REFERENCES invoice(invoice_id),
    supplier_id INT NOT NULL REFERENCES supplier(supplier_id),
    product_id INT NOT NULL REFERENCES product(product_id)
);

-- Table to denote the ordering relationship
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY REFERENCES customer_order(order_id), 
    customer_id INT NOT NULL REFERENCES customer(customer_id),
    product_id INT NOT NULL REFERENCES product(product_id)
);
