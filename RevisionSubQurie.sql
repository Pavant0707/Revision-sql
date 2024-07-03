CREATE DATABASE REVISION
USE REVISION

CREATE TABLE ORDERS (
    ORDERID INT PRIMARY KEY IDENTITY(1,1),
    CUSTOMERNAME VARCHAR(255) NOT NULL,
    ORDERDATE DATE NOT NULL,
    TOTALAMOUNT DECIMAL(10, 2) NOT NULL,
);

INSERT INTO ORDERS (CUSTOMERNAME, ORDERDATE, TOTALAMOUNT)
VALUES 
('SAI', '2022-01-15', 100),
('RAM', '2022-03-22', 250),
('ARJUN', '2022-05-05', 300)

--Write a query retrieves the customer name, order date, and total amount from the "orders" table for orders 
--with a total amount greater than the average total amount of orders placed in the year 2022.

WITH AvgTotal AS (
    SELECT 
        AVG(TOTALAMOUNT) AS AvgTotalAmount2022
    FROM 
        ORDERS
    WHERE 
        YEAR(ORDERDATE) = 2022
)
SELECT 
    CUSTOMERNAME, 
    ORDERDATE, 
    TOTALAMOUNT
FROM 
    ORDERS
WHERE 
    TOTALAMOUNT > (SELECT AvgTotalAmount2022 FROM AvgTotal)
    AND YEAR(ORDERDATE) = 2022;

--query retrieves the customer names from the "customers" table for customers who have placed an order on a specific date, 
SELECT
    O.CUSTOMERNAME
FROM
    ORDERS O

WHERE
    O.ORDERDATE = '2022-01-15';

--Write a query retrieves the product name and price from the "products" table for products that have been ordered by a specific customer with the ID 1.


CREATE TABLE PRODUCTS (
    PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
    PRODUCTNAME VARCHAR(255) NOT NULL,
    AMOUNT DECIMAL(10, 2) NOT NULL,
	CUSTOMERID INT NOT NULL,
);


INSERT INTO PRODUCTS (PRODUCTNAME, AMOUNT, CUSTOMERID)
VALUES 
('Product X', 50, 1)
INSERT INTO PRODUCTS (PRODUCTNAME, AMOUNT, CUSTOMERID)
VALUES 
('Product A', 120, 2),
('Product B', 85, 2);

INSERT INTO PRODUCTS (PRODUCTNAME, AMOUNT, CUSTOMERID)
VALUES 
('Product C', 90, 3),
('Product D', 60, 3);

SELECT
    P.PRODUCTNAME,
    P.AMOUNT
FROM
    PRODUCTS P
WHERE
    P.CUSTOMERID = 1;

--query retrieves the employee name and hire date from the "employees" table for employees who were hired most recently in their respective departments.
CREATE TABLE EMPLOYEE(
EMPLOYEEID INT PRIMARY KEY IDENTITY(1,1),
NAME VARCHAR (100) NOT NULL,
HIREDATE DATE NOT NULL,
DEPARTMENT VARCHAR(100) NOT NULL)
INSERT INTO EMPLOYEE(NAME,HIREDATE,DEPARTMENT) VALUES('SAI','2018-02-15','SALES');
INSERT INTO EMPLOYEE(NAME,HIREDATE,DEPARTMENT) VALUES('RAM','2018-02-15','TEACHER');
INSERT INTO EMPLOYEE(NAME,HIREDATE,DEPARTMENT) VALUES('ARJUN','2017-02-15','TEACHER');
SELECT
    E.NAME AS EmployeeName,
    E.HIREDATE AS HireDate
FROM
    EMPLOYEE E
WHERE
    E.HIREDATE = (
        SELECT MAX(E2.HIREDATE)
        FROM EMPLOYEE E2
        WHERE E2.DEPARTMENT = E.DEPARTMENT
    );

--query retrieves the customer name from the "customers" table along with the count of orders made by each customer. 
--The subquery is used within the SELECT statement to calculate the order count for each customer.
CREATE TABLE  CUSTOMERS(
    CUSTOMERID INT IDENTITY(1,1) PRIMARY KEY,
    customer_name NVARCHAR(100) NOT NULL
);

CREATE TABLE orderss (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
	CUSTOMERID INT FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMERID),
    order_date DATE,
);
INSERT INTO customers (customer_name)
VALUES ('Sai'),('Ram');

INSERT INTO orderss (CUSTOMERID, order_date)
VALUES 
(1, '2024-01-15'),
(2, '2024-02-20')
SELECT 
    c.customer_name,
    (SELECT COUNT(*) 
     FROM orderss o 
     WHERE o.CUSTOMERID = c.CUSTOMERID) AS order_count
FROM 
    customers c;

	--query calculates the total number of orders for each product in the "order_details" table and then retrieves the product name along with the total_orders. 
	--The subquery is used in the FROM clause to generate a temporary result set that is then joined with the "products" table.

	CREATE TABLE product (
    productid INT IDENTITY(1,1) PRIMARY KEY,
    productname NVARCHAR(100) NOT NULL
);

CREATE TABLE orderdetails (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    productid INT FOREIGN KEY REFERENCES product(productid),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    
);

INSERT INTO product (productname)
VALUES ('Product A'), ('Product B'), ('Product C'), ('Product D');

INSERT INTO orderdetails (order_id, product_id, quantity)
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 1, 1),
(2, 3, 5),
(3, 2, 2),
(3, 4, 3);

SELECT 
    p.productname,
    temp.total_orders
FROM 
    (SELECT 
         product_id,
         COUNT(*) AS total_orders
     FROM 
         orderdetails
     GROUP BY 
         product_id) AS temp
JOIN 
    product p ON p.productid = temp.product_id;
