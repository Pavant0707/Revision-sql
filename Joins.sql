create database joins
use joins

--E-commerce application: In an e-commerce application, you could use a join to retrieve the order details and customer information for a specific order. 
--For example, you could join the orders table with the customers table on the customer ID to get the customer's name, address, and contact information for the order.
CREATE TABLE customers (
    customerid INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    contactnumber VARCHAR(15) NOT NULL
);

CREATE TABLE orderss (
    orderid INT IDENTITY(1,1) PRIMARY KEY,
	customerid INT FOREIGN key REFERENCES customers(customerid),
    orderdate DATETIME NOT NULL,
    totalamount DECIMAL(10, 2) NOT NULL,
);
Declare @orderid INT;
SELECT 
    o.orderid,
    o.orderdate,
    o.totalamount,
    c.customerid,
    c.name AS customername,
    c.address,
    c.contactnumber

FROM 
    orderss o
JOIN 
    customers c
ON 
    o.customerid = c.customerid
WHERE 
    o.orderid = @orderid;
	INSERT INTO customers (name, address, contactnumber) 
VALUES ('Sai', ' USA', '5551234');

INSERT INTO orderss (customerid, orderdate, totalamount)
VALUES (1, '2023-07-03', 250);
--Healthcare application: In a healthcare application, you could use a join to retrieve the patient information and medical history for a specific appointment. 
--For example, you could join the appointments table with the patients table and the medical history table on the patient ID to get the patient's name, age, medical conditions, and previous treatments.
CREATE TABLE patients (
    patientid INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    contactnumber VARCHAR(15),
    address VARCHAR(255)
);
CREATE TABLE medical_history (
    historyid INT IDENTITY(1,1) PRIMARY KEY,
	patientid INT FOREIGN KEY REFERENCES patients(patientid),
    condition VARCHAR(255) NOT NULL,
    treatment VARCHAR(255),
);
CREATE TABLE appointments (
    appointmentid INT IDENTITY(1,1) PRIMARY KEY,
    patientid INT FOREIGN KEY REFERENCES patients(patientid),
    appointmentdate DATETIME NOT NULL,
    doctor VARCHAR(100),
);
DECLARE @appointmentid INT;
SELECT 
    a.appointmentid,
    a.appointmentdate,
    a.doctor,
    p.patientid,
    p.name AS patientname,
    p.age,
    p.contactnumber,
    p.address,
    mh.treatment
FROM 
    appointments a
JOIN 
    patients p ON a.patientid = p.patientid
JOIN 
    medical_history mh ON p.patientid = mh.patientid
WHERE 
    a.appointmentid = @appointmentid;

INSERT INTO patients (name, age, contactnumber, address)
VALUES ('Prabhas', 45, '1234567890', ' USA');

INSERT INTO patients (name, age, contactnumber, address)
VALUES ('Ansuhka', 32, '0987654321', 'USA');


INSERT INTO medical_history (patientid, condition, treatment)
VALUES (1, 'Hypertension', 'Medication: Lisinopril');

INSERT INTO medical_history (patientid, condition, treatment)
VALUES (1, 'Diabetes', 'Medication: Metformin');




INSERT INTO appointments (patientid, appointmentdate, doctor)
VALUES (1, '2024-07-15', 'Dr. Smith');

INSERT INTO appointments (patientid, appointmentdate, doctor)
VALUES (2, '2024-07-20 ', 'Dr. Johnson');

--Banking application: In a banking application, you could use a join to retrieve the account details and transaction history for a specific customer.
--For example, you could join the customers table with the accounts table and the transactions table on the account ID to get the account balance, transaction dates, and amounts for the customer's account.
CREATE TABLE customer (
    customerid INT PRIMARY KEY IDENTITY(1,1) ,
    name VARCHAR(100) NOT NULL,
    contactnumber VARCHAR(15) NOT NULL,
    email VARCHAR(100),
);
CREATE TABLE accounts (
    accountid INT  PRIMARY KEY IDENTITY(1,1),
	customerid Int FOREIGN KEY REFERENCES customer(customerid),
    accountnumber VARCHAR(20) NOT NULL UNIQUE,
    accounttype VARCHAR(50) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
);
CREATE TABLE transactions (
    transactionid INT PRIMARY KEY  IDENTITY(1,1),
	accountid INT FOREIGN KEY REFERENCES accounts(accountid),
    transactiondate DATETIME NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    transactiontype VARCHAR(50) NOT NULL,
    description VARCHAR(255),
);
DECLARE @customerid INT;
	
SELECT 
    c.customerid,
    c.name AS customer_name,
    c.address,
    c.contactnumber,
    a.accountid,
    a.accountnumber,
    a.accounttype,
    a.balance,
    t.transactionid,
    t.transactiondate,
    t.amount,
    t.transactiontype,
    t.description
FROM 
    customers c
JOIN 
    accounts a ON c.customerid = a.customerid
JOIN 
    transactions t ON a.accountid = t.accountid
WHERE 
    c.customerid = @customerid;


INSERT INTO customers (name, address, contactnumber)
VALUES ('Ram', ' USA', '5551234');

INSERT INTO customers (name, address, contactnumber)
VALUES ('Sai', 'USA', '5555678');


INSERT INTO accounts (customerid, accountnumber, accounttype, balance)
VALUES (1, 'ACC123456789', 'Checking', 1500);

INSERT INTO accounts (customerid, accountnumber, accounttype, balance)
VALUES (2, 'ACC987654321', 'Savings', 3000);


INSERT INTO transactions (accountid, transactiondate, amount, transactiontype, description)
VALUES (1, '2024-07-01', 500, 'Deposit', 'Paycheck deposit');

INSERT INTO transactions (accountid, transactiondate, amount, transactiontype, description)
VALUES (1, '2024-07-02', -100, 'Withdrawal', 'ATM withdrawal');

INSERT INTO transactions (accountid, transactiondate, amount, transactiontype, description)
VALUES (2, '2024-07-01', 200, 'Deposit', 'Transfer from checking');

--Manufacturing application: In a manufacturing application, you could use a join to retrieve the inventory levels and production schedules for a specific product.
--For example, you could join the products table with the inventory table and the production schedule table on the product ID to get the current inventory levels, production dates, and quantities for the product.
CREATE TABLE products (
    productid INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE inventory (
    inventoryid INT IDENTITY(1,1) PRIMARY KEY,
    productid Int FOREIGN KEY REFERENCEs products(productid),
    quantity INT NOT NULL,
    last_updated DATETIME NOT NULL,
);
CREATE TABLE production (
    schedule_id INT IDENTITY(1,1) PRIMARY KEY,
	productid Int FOREIGN KEY REFERENCEs products(productid),
    production_date DATETIME NOT NULL,
    quantity INT NOT NULL
);
DECLARE @productid INT;


SELECT 
    p.productid,
    p.name AS productname,
    p.price,
    i.quantity AS inventory_quantity,
    i.last_updated,
    ps.schedule_id,
    ps.production_date,
    ps.quantity AS production_quantity
FROM 
    products p
JOIN 
    inventory i ON p.productid = i.productid
JOIN 
    production ps ON p.productid = ps.productid
WHERE 
    p.productid = @productid;

INSERT INTO products (name, price)
VALUES ('A',  19);

INSERT INTO products (name, price)
VALUES ('B', 29);


INSERT INTO inventory (productid, quantity, last_updated)
VALUES (1, 100, '2024-07-01');

INSERT INTO inventory (productid, quantity, last_updated)
VALUES (2, 50, '2024-07-01');


INSERT INTO production (productid, production_date, quantity)
VALUES (1, '2024-07-05', 200);

INSERT INTO production (productid, production_date, quantity)
VALUES (2, '2024-07-06', 100);

--Logistics application: In a logistics application, you could use a join to retrieve the delivery schedules and driver information for a specific shipment.
--For example, you could join the shipments table with the delivery schedule table and the drivers table on the shipment ID to get the delivery dates, driver names, and vehicle information for the shipment.
CREATE TABLE shipment (
    shipmentid INT IDENTITY(1,1) PRIMARY KEY,
    shipmentnumber VARCHAR(50) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    shipmentdate DATETIME NOT NULL
);
CREATE TABLE delivery_schedule (
    scheduleid INT IDENTITY(1,1) PRIMARY KEY,
	shipmentid INT FOREIGN key REFERENCES shipment(shipmentid),
    deliverydate DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
);
CREATE TABLE drivers (
    driverid INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    vehicle_info VARCHAR(100)
);
CREATE TABLE driver_assignments (
    assignmentid INT IDENTITY(1,1) PRIMARY KEY,
	scheduleid  INT FOREIGN key REFERENCES delivery_schedule(scheduleid ),
	driverid INT FOREIGN key REFERENCES drivers(driverid)
);
DECLARE @shipmentid INT;


SELECT 
    s.shipmentid,
    s.shipmentnumber,
    s.destination,
    s.shipmentdate,
    ds.deliverydate,
    ds.status,
    d.driverid,
    d.name AS driver_name,
    d.vehicle_info
FROM 
    shipment s
JOIN 
    delivery_schedule ds ON s.shipmentid = ds.shipmentid
JOIN 
    driver_assignments da ON ds.scheduleid = da.scheduleid
JOIN 
    drivers d ON da.driverid = d.driverid
WHERE 
    s.shipmentid = @shipmentid;

INSERT INTO shipment (shipmentnumber, destination, shipmentdate)
VALUES ('1', 'USA', '2024-07-01');

INSERT INTO shipment (shipmentnumber, destination, shipmentdate)
VALUES ('2',  'Chicago', '2024-07-02');


INSERT INTO delivery_schedule (shipmentid, deliverydate, status)
VALUES (1, '2024-07-05', 'Scheduled');

INSERT INTO delivery_schedule (shipmentid, deliverydate, status)
VALUES (2, '2024-07-06', 'Scheduled');


INSERT INTO drivers (name,  vehicle_info)
VALUES ('Sai Tej',  'Truck A');

INSERT INTO drivers (name, vehicle_info)
VALUES ('Jr.Ntr',  'Truck B');


INSERT INTO driver_assignments (scheduleid, driverid)
VALUES (1, 1);

INSERT INTO driver_assignments (scheduleid, driverid)
VALUES (2, 2);

--Social media application: In a social media application, you could use a join to retrieve the user profiles and activity logs for a specific user. 
--For example, you could join the users table with the activity log table on the user ID to get the user's name, age, location, and activity history.
CREATE TABLE users (
    userid INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    location VARCHAR(100),
);
CREATE TABLE activity (
    activity_id INT IDENTITY(1,1) PRIMARY KEY,
	userid INT FOREIGN key REFERENCES users(userid),
    activity_type VARCHAR(50) NOT NULL,
    activity_date DATETIME NOT NULL,
);
DECLARE @userid INT;


SELECT 
    u.userid,
    u.name AS user_name,
    u.age,
    u.location,
    al.activity_id,
    al.activity_type,
    al.activity_date
FROM 
    users u
JOIN 
    activity al ON u.userid = al.userid
WHERE 
    u.userid = @userid;

INSERT INTO users (name, age, location)
VALUES ('Sai', 28, 'New York');

INSERT INTO users (name, age, location)
VALUES ('Ram', 35, 'San Francisco');


INSERT INTO activity (userid, activity_type, activity_date)
VALUES (1, 'Post', '2024-07-01 ');

INSERT INTO activity (userid, activity_type, activity_date)
VALUES (1, 'Comment', '2024-07-01');

INSERT INTO activity (userid, activity_type, activity_date)
VALUES (2, 'Like', '2024-07-01');

--Travel booking application: In a travel booking application, you could use a join to retrieve the flight or hotel details and customer information for a specific booking. For example, you could join the bookings table with the flights table or the hotels table and the customers table on the booking ID to get the booking details, customer names, and contact information.
CREATE TABLE customerss (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
);
CREATE TABLE booking (
    bookingid INT PRIMARY KEY IDENTITY(1,1),
	customer_id Int FOREIGN KEY REFERENCEs customerss(customer_id),
    bookingdate DATETIME NOT NULL,
    booking_type VARCHAR(50) NOT NULL,
);
CREATE TABLE flights (
    flight_id INT PRIMARY KEY IDENTITY(1,1),
    airline VARCHAR(100) NOT NULL,
    departure_airport VARCHAR(100) NOT NULL,
    arrival_airport VARCHAR(100) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL
);
CREATE TABLE hotel (
    hotelid INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
);
INSERT INTO customerss (name) 
VALUES ('Sai');

INSERT INTO booking (customer_id, bookingdate, booking_type)
VALUES (1, '2023-07-03', 'Flight');

INSERT INTO flights (airline, departure_airport, arrival_airport, departure_time, arrival_time)
VALUES ('Airways', 'A', 'B', '2023-07-10 08:00:00', '2023-07-10 11:00:00');

INSERT INTO hotel (name, location)
VALUES ('Grand Hotel', 'Downtown');
DECLARE @bookingid INT;

SELECT 
    b.bookingid,
    b.bookingdate,
    c.customer_id,
    c.name AS customer_name,
    CASE
        WHEN b.booking_type = 'Flight' THEN f.flight_id
        WHEN b.booking_type = 'Hotel' THEN h.hotelid
    END AS service_id,
   
    CASE
        WHEN b.booking_type = 'Flight' THEN f.airline
        WHEN b.booking_type = 'Hotel' THEN h.location
    END AS service_location,
    CASE
        WHEN b.booking_type = 'Flight' THEN f.departure_time
        WHEN b.booking_type = 'Hotel' THEN NULL
    END AS service_start_time,
    CASE
        WHEN b.booking_type = 'Flight' THEN f.arrival_time
        WHEN b.booking_type = 'Hotel' THEN NULL
    END AS service_end_time
FROM 
    booking b
JOIN 
    customerss c ON b.customer_id = c.customer_id
LEFT JOIN 
    flights f ON b.booking_type = 'Flight' AND b.bookingid = f.flight_id
LEFT JOIN 
    hotel h ON b.booking_type = 'Hotel' AND b.bookingid = h.hotelid
WHERE 
    b.bookingid = @bookingid;

--Supply chain management application: In a supply chain management application, you could use a join to retrieve the supplier details and shipment information for a specific product. For example, you could join the products table with the suppliers table and the shipments table on the product ID to get the supplier names, shipment dates, and quantities for the product.
CREATE TABLE productss (
    productid INT PRIMARY KEY identity(1,1),
    productname VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2)
);
CREATE TABLE supplierss (
    supplierid INT PRIMARY KEY identity(1,1),
    suppliername VARCHAR(100) NOT NULL
);
CREATE TABLE shipmentss (
    shipment_id INT PRIMARY KEY identity(1,1),
    productid INT FOREIGN key REFERENCES productss(productid),
    supplierid INT FOREIGN key REFERENCES supplierss(supplierid),
    shipment_date DATE,
    quantity INT,
);
INSERT INTO productss (productname, price)
VALUES ('Product A', 19.99),
       ('Product B', 29.99);

INSERT INTO supplierss (suppliername)
VALUES ('Supplier X'),
       ('Supplier Y');

INSERT INTO shipmentss (productid, supplierid, shipment_date, quantity)
VALUES (1, 1, '2023-07-01', 100),
       (2, 2, '2023-07-02', 200);
SELECT
    p.productname,
    s.suppliername,
    sh.shipment_date,
    sh.quantity
FROM
    productss p
JOIN
    shipmentss sh ON p.productid = sh.productid
JOIN
    supplierss s ON sh.supplierid = s.supplierid
WHERE
    p.productid = @productid;
