Scenario
An e-commerce company wants to build a Multi-Vendor SaaS application where multiple vendors
can register and sell their products to customers. Each vendor must provide details such as business
name, contact person, email, phone number, business address, and the subscription plan they are
using. A vendor can list many products on the platform.
Every product has information like product name, description, price, stock quantity, and status
(active/inactive). A product must belong to a single vendor but can also fall under one or more
categories. Each category has its own name and description, and a product may appear in multiple
categories.
The application also allows customers to register with their name, email, phone number, and
address. A customer can place multiple orders. Each order contains an order date, total amount,
and order status. Since a single order may include products from different vendors, there is a need
for an order item entity that keeps track of each product in an order along with the quantity, unit
price, and subtotal.
For every order, the customer must make a payment. A payment has a unique ID, method (such as
Card, Bkash, PayPal, or Cash on Delivery), amount, payment date, and payment status.
Finally, the system supports subscription plans for vendors. Each subscription plan has a plan
name, price, duration, and features. A vendor can only subscribe to one plan at a time.

Questions
Part A: ERD & Database Design
1. Draw the ERD diagram with correct relationships and cardinalities (1:1, 1:N, M:N).

Part B: SQL DDL (Table Creation)
3. Write the SQL command to create a table for Vendor, including primary key and foreign
key reference to SubscriptionPlan.
4. Write the SQL command to create the ProductCategory table, ensuring it properly handles
the M:N relationship between Product and Category.


 
Part C: SQL DML (Insert/Update/Delete)
5. Insert a new vendor named "SmartTech Ltd.", with contact person Rahim Khan, email
rahim@smarttech.com, phone 017XXXXXXXX, address Dhaka, Bangladesh, under the
Basic plan.
6. Insert a product called "Laptop" under the Electronics category, price 75,000, stock 10,
status active, belonging to SmartTech Ltd.
7. Update the stock quantity of "Laptop" product to 15.
8. Delete a customer whose email is "oldcustomer@gmail.com".

Part D: SQL Queries (DQL)
9. Write a query to display all vendors along with their subscription plan name and price.
10. Find all products under the category "Electronics" with their name, price, and stock
quantity.
11. List all orders placed by customer "Karim Uddin", showing order_id, date, total_amount,
and status.
12. Show the payment details (method, amount, status) for order_id = 1.
13. Find the top 5 best-selling products based on total quantity sold.
