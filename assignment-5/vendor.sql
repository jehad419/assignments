-- PART B:

-- 1. Create SubscriptionPlan table
CREATE TABLE SubscriptionPlan (
    plan_id INTEGER PRIMARY KEY,
    plan_name VARCHAR(50) UNIQUE NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    duration_days INTEGER NOT NULL,
    features TEXT
);

-- 2. Create Vendor table
CREATE TABLE Vendor (
    vendor_id INTEGER PRIMARY KEY,
    business_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    business_address TEXT,
    plan_id INTEGER NOT NULL,
    FOREIGN KEY (plan_id)
        REFERENCES SubscriptionPlan(plan_id)
        ON DELETE CASCADE
);

-- 3. Create Product table
CREATE TABLE Product (
    product_id INTEGER PRIMARY KEY,
    vendor_id INTEGER NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(12, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    status VARCHAR(10) NOT NULL DEFAULT 'active',
    FOREIGN KEY (vendor_id)
        REFERENCES Vendor(vendor_id)
        ON DELETE CASCADE
);

-- 4. Create Category table
CREATE TABLE Category (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- 5. Create ProductCategory junction table
CREATE TABLE ProductCategory (
    product_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE CASCADE,
    FOREIGN KEY (category_id)
        REFERENCES Category(category_id)
        ON DELETE CASCADE
);

-- 6. Create Customer table
CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

-- 7. Create Orders table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE
);

-- 8. Create OrderItem table
CREATE TABLE OrderItem (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,
    subtotal NUMERIC(12, 2) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE CASCADE,
    UNIQUE (order_id, product_id)
);

-- 9. Create Payment table
CREATE TABLE Payment (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL UNIQUE,
    method VARCHAR(30) NOT NULL
        CHECK (method IN (
            'Card', 'Bkash', 'PayPal', 'Cash on Delivery'
        )),
    amount NUMERIC(12, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
);



-- PART C:


--Insert subscription 
INSERT INTO SubscriptionPlan
(plan_name, price, duration_days, features)
VALUES
    ('Basic', 500.00, 30, 'Basic product listing'),
    ('Standard', 1000.00, 30, 'Extended product listing'),
    ('Premium', 2000.00, 30, 'Advanced vendor features');

-- Insert product category
INSERT INTO Category (category_name, description)
VALUES
    ('Electronics', 'Electronic products and devices');

-- Insert the vendor SmartTech Ltd.
INSERT INTO Vendor (
    business_name,
    contact_person,
    email,
    phone,
    business_address,
    plan_id
)
SELECT
    'SmartTech Ltd.',
    'Rahim Khan',
    'rahim@smarttech.com',
    '017XXXXXXXX',
    'Dhaka, Bangladesh',
    plan_id
FROM SubscriptionPlan
WHERE plan_name = 'Basic';

-- Insert Laptop 
INSERT INTO Product (
    vendor_id,
    product_name,
    description,
    price,
    stock_quantity,
    status
)
SELECT
    v.vendor_id,
    'Laptop',
    'Laptop computer',
    75000.00,
    10,
    'active'
FROM Vendor v
WHERE v.business_name = 'SmartTech Ltd.'
  AND v.email = 'rahim@smarttech.com';

-- Link Laptop 
INSERT INTO ProductCategory (product_id, category_id)
SELECT p.product_id, c.category_id
FROM Product p
CROSS JOIN Category c
WHERE p.product_name = 'Laptop'
  AND c.category_name = 'Electronics'
  AND p.vendor_id = (
      SELECT vendor_id
      FROM Vendor
      WHERE email = 'rahim@smarttech.com'
  );

-- Update Laptop
UPDATE Product
SET stock_quantity = 15
WHERE product_name = 'Laptop'
  AND vendor_id = (
      SELECT vendor_id
      FROM Vendor
      WHERE email = 'rahim@smarttech.com'
  );

-- Insert a sample customer
INSERT INTO Customer (
    customer_name,
    email,
    phone,
    address
)
VALUES (
    'Karim Uddin',
    'karim@example.com',
    '018XXXXXXXX',
    'Dhaka, Bangladesh'
);

-- Insert a sample order 
INSERT INTO Orders (
    customer_id,
    order_date,
    total_amount,
    status
)
SELECT
    customer_id,
    CURRENT_TIMESTAMP,
    75000.00,
    'processing'
FROM Customer
WHERE email = 'karim@example.com';

-- Insert the order 
INSERT INTO OrderItem (
    order_id,
    product_id,
    quantity,
    unit_price,
    subtotal
)
SELECT
    o.order_id,
    p.product_id,
    1,
    75000.00,
    75000.00
FROM Orders o
JOIN Customer c ON c.customer_id = o.customer_id
CROSS JOIN Product p
WHERE c.email = 'karim@example.com'
  AND p.product_name = 'Laptop'
  AND p.vendor_id = (
      SELECT vendor_id
      FROM Vendor
      WHERE email = 'rahim@smarttech.com'
  );

-- Insert payment 
INSERT INTO Payment (
    order_id,
    method,
    amount,
    payment_date,
    status
)
SELECT
    o.order_id,
    'Bkash',
    o.total_amount,
    CURRENT_TIMESTAMP,
    'completed'
FROM Orders o
JOIN Customer c ON c.customer_id = o.customer_id
WHERE c.email = 'karim@example.com';

--Delete a customer by email

DELETE FROM Customer
WHERE email = 'oldcustomer@gmail.com';




-- PART D:

--Display all vendors 
SELECT
    v.vendor_id,
    v.business_name,
    v.contact_person,
    v.email,
    sp.plan_name,
    sp.price AS plan_price
FROM Vendor v
JOIN SubscriptionPlan sp
    ON v.plan_id = sp.plan_id;


-- Find all products under the Electronics category
SELECT
    p.product_name,
    p.price,
    p.stock_quantity
FROM Product p
JOIN ProductCategory pc
    ON p.product_id = pc.product_id
JOIN Category c
    ON pc.category_id = c.category_id
WHERE c.category_name = 'Electronics';


-- List all orders placed by Karim Uddin
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM Orders o
JOIN Customer c
    ON o.customer_id = c.customer_id
WHERE c.customer_name = 'Karim Uddin';


-- Display payment details for order_id = 1
SELECT
    method,
    amount,
    status
FROM Payment
WHERE order_id = 1;


-- Find the top 5 best-selling products by total quantity sold
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Product p
JOIN OrderItem oi
    ON p.product_id = oi.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_quantity_sold DESC,
    p.product_name ASC
LIMIT 5;