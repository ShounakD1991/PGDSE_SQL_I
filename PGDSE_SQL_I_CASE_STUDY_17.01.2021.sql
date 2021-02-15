#Section A --> Know your data
-- ------------------------------------------------------------------------------------------------------------------------
#1.	Read the data from all tables.
SELECT 
    *
FROM
    customer;
SELECT 
    *
FROM
    Orders;
SELECT 
    *
FROM
    Supplier;
SELECT 
    *
FROM
    Product;
SELECT 
    *
FROM
    OrderItem;
-- ------------------------------------------------------------------------------------------------------------------------
#2.	Find the country wise count of customers.
SELECT 
    id, FirstName, LastName, City, Country, COUNT(id) as Customer_Count
FROM
    customer
GROUP BY Country;
-- ------------------------------------------------------------------------------------------------------------------------
#3.	Display the products which are not discontinued.
SELECT 
    id, ProductName
FROM
    product
WHERE
    IsDiscontinued <> 1
GROUP BY ProductName
ORDER BY id;
-- ------------------------------------------------------------------------------------------------------------------------
#4.	Display the list of companies along with the product name that they are supplying.
SELECT 
    s.CompanyName, p.ProductName
FROM
    supplier AS s
        JOIN
    product AS p ON p.SupplierId = s.id;
-- ------------------------------------------------------------------------------------------------------------------------
#5.	Display customer's information who stays in 'Mexico'
SELECT 
    *
FROM
    customer
WHERE
    country LIKE '%Mexico%';
-- ------------------------------------------------------------------------------------------------------------------------
#6.	Display the costliest item that is ordered by the customer.
SELECT 
    c.id AS Cust_id,
    c.FirstName,
    C.LastName,
    o.id AS Order_id,
    oi.id AS Item_id,
    oi.unitprice
FROM
    customer AS c
        JOIN
    orders AS o ON c.id = o.CustomerId
        JOIN
    orderitem AS oi ON oi.OrderId = o.Id
GROUP BY c.id
ORDER BY UnitPrice DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#7.	Display supplier id who owns highest number of products.
SELECT 
    SupplierId, COUNT(Id) AS Product_count,ProductName
FROM
    product
GROUP BY SupplierId
ORDER BY COUNT(Id) DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#8.	Display month wise and year wise count of the orders placed.
SELECT 
    COUNT(id) AS Order_Count,
    MONTH(orderdate) AS Order_Month,
    YEAR(orderdate) AS Order_Year
FROM
    orders
GROUP BY order_month , order_year
ORDER BY order_count DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#9.	Which country has maximum suppliers.
SELECT 
    id, country, COUNT(id) Supplier_count
FROM
    supplier
GROUP BY country
ORDER BY supplier_count DESC
LIMIT 1;
-- ------------------------------------------------------------------------------------------------------------------------
#10.Which customers did not place any order.
SELECT 
    c.id, c.FirstName, c.lastName
FROM
    customer AS c
        LEFT JOIN
    orders AS o ON c.Id = o.CustomerId
WHERE
    o.CustomerId IS NULL;
-- ------------------------------------------------------------------------------------------------------------------------
#Section B --> Know the business
-- ------------------------------------------------------------------------------------------------------------------------
#1.	Arrange the product id, product name based on high demand by the customer.
SELECT 
    p.Id AS ProductId, ProductName, Quantity, CustomerId
FROM
    product p
        JOIN
    orderitem i ON p.Id = i.ProductId
        JOIN
    orders o ON i.OrderId = o.Id
GROUP BY CustomerId
ORDER BY Quantity DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#2.	Display the number of orders delivered every year.
SELECT 
    YEAR(orderDate) AS Delivery_Year, COUNT(id) Total_orders
FROM
    orders
GROUP BY delivery_year;
-- ------------------------------------------------------------------------------------------------------------------------
#3.	Calculate year-wise total revenue.
SELECT 
    o.id AS Order_ID,
    YEAR(o.orderDate) AS Delivery_Year,
    SUM(i.unitPrice * i.Quantity) AS Revenue
FROM
    orders AS o
        JOIN
    orderitem AS i ON o.id = i.orderid
GROUP BY Delivery_year;
-- ------------------------------------------------------------------------------------------------------------------------
#4.	Display the customer details whose order amount is maximum including his past orders.
SELECT 
    c.id AS Customer_Id,
    c.Firstname AS First_name,
    c.lastname AS Last_name,
    o.id AS Order_id,
    o.orderdate AS Order_Date,
    SUM(o.totalamount) AS Sum_Total_Amount
FROM
    customer AS c
        JOIN
    orders AS o ON c.id = o.customerid
GROUP BY c.id
ORDER BY Sum_Total_Amount DESC
LIMIT 1;
-- ------------------------------------------------------------------------------------------------------------------------
#5.	Display total amount ordered by each customer from high to low.
SELECT 
    c.id AS Customer_Id,
    c.Firstname AS First_name,
    c.lastname AS Last_name,
    o.id AS Order_id,
    o.orderdate AS Order_Date,
    SUM(o.totalamount) AS Sum_Total_Amount
FROM
    customer AS c
        JOIN
    orders AS o ON c.id = o.customerid
GROUP BY c.id
ORDER BY Sum_Total_Amount DESC;
-- ------------------------------------------------------------------------------------------------------------------------
# A sales and marketing department of this company wants to find out how frequently customer have business with them. This can be done in two ways. (Answer Q 6 and Q 7 for the same)
-- ------------------------------------------------------------------------------------------------------------------------
#6.	Approach 1. List the current and previous order amount for each customers.
select customerId,TotalAmount as currentAmount,Lag(TotalAmount)
over (Partition by customerId order by TotalAmount) as previousAmount from Orders;
-- ------------------------------------------------------------------------------------------------------------------------
#7.	Approach 2. List the current and previous order amount for each customers.
select customerId,TotalAmount as currentAmount,lag(TotalAmount)
over (Partition by customerId order by TotalAmount rows between unbounded preceding and current row) 
as previousAmount from Orders;
-- ------------------------------------------------------------------------------------------------------------------------
#8.	Find out top 3 suppliers in terms of revenue generated by their products.
SELECT 
    p.supplierid AS Supplier_ID,
    s.CompanyName AS Supplier_Name,
    i.orderid AS Order_Id,
    SUM(i.unitprice * i.quantity) AS Revenue
FROM
    orderitem AS i
        JOIN
    product AS p ON i.productid = p.id
        JOIN
    supplier AS s ON p.supplierid = s.id
GROUP BY p.supplierid
ORDER BY revenue DESC
LIMIT 3;
-- ------------------------------------------------------------------------------------------------------------------------
#9.	Display latest order date (should not be same as first order date) of all the customers with customer details.
SELECT 
    c.*, o.OrderDate
FROM
    Orders o
        INNER JOIN
    (SELECT 
        CustomerId, MAX(OrderDate) AS MaxDate
    FROM
        Orders
    GROUP BY CustomerId) od ON o.CustomerId = od.CustomerId
        AND o.OrderDate = od.MaxDate
        JOIN
    Customer c ON o.CustomerId = c.Id;
-- ------------------------------------------------------------------------------------------------------------------------
#10.	Display the product name and supplier name for each order
SELECT 
    p.productname AS Product_name,
    s.Companyname AS Supplier_Name,
    o.id AS Order_ID
FROM
    orders AS o
        JOIN
    orderitem AS i ON o.id = i.orderid
        JOIN
    product AS p ON i.productid = p.id
        JOIN
    supplier AS s ON p.supplierid = s.id;
-- ------------------------------------------------------------------------------------------------------------------------
#Section C --> Business Analysis
-- ------------------------------------------------------------------------------------------------------------------------
#1.	Fetch the records to display the customer details who ordered more than 10 products in the single order
SELECT 
    c.*, Quantity, o.Id AS OrderId
FROM
    Orders o
        JOIN
    OrderItem i ON o.Id = i.OrderId
        JOIN
    Customer c ON c.Id = o.CustomerId
WHERE
    Quantity > 10;

-- ------------------------------------------------------------------------------------------------------------------------
#2.	Display all the product details with the ordered quantity size as 1.
SELECT 
    p.*, i.quantity
FROM
    product AS p
        JOIN
    orderitem AS i ON i.productid = p.id
WHERE
    quantity = 1;
-- ------------------------------------------------------------------------------------------------------------------------
#3.	Display the compan(y)ies which supplies products whose cost is above 100.
SELECT 
    s.companyName AS Company_Name, p.unitprice AS Unit_Price
FROM
    product AS p
        JOIN
    supplier AS s ON p.supplierid = s.id
WHERE
    p.unitprice > 100;
-- ------------------------------------------------------------------------------------------------------------------------
#4.	Create a combined list to display customers and supplier list as per the below format.
SELECT 
    s.ContactName,
    s.City,
    s.country,
    s.phone,
    CASE
        WHEN s.id != '' THEN 'Supplier'
        ELSE NULL
    END AS Type
FROM
    supplier s 
UNION SELECT 
    CONCAT(c.FirstName, c.LastName),
    c.city,
    c.country,
    c.phone,
    CASE
        WHEN c.id != '' THEN 'Customer'
        ELSE NULL
    END AS Type
FROM
    Customer c;
-- ------------------------------------------------------------------------------------------------------------------------
# 5.	Display the customer list who belongs to same city and country arrange in country wise.
select Id,FirstName,LastName,Phone,first_value(City)
over (Partition by city order by Country)as city,country from Customer;
-- ------------------------------------------------------------------------------------------------------------------------
# Section D --> Challenge
-- ------------------------------------------------------------------------------------------------------------------------
#1.	Company sells the product at different discounted rates. Refer actual product price in product table and selling price in the order item table. Write a query to find out total amount saved in each order then display the orders from highest to lowest amount saved. 
SELECT 
    p.id AS Product_id,
    i.id AS Item_id,
    (p.unitprice - i.unitprice) AS Savings
FROM
    orderitem AS i
        JOIN
    product AS p ON i.productid = p.id
ORDER BY savings DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#2.	Mr. Kavin want to become a supplier. He got the database of "Richard's Supply" for reference. Help him to pick: 
#a. List few products that he should choose based on demand.
SELECT 
    p.Id AS ProductId, ProductName, i.Quantity
FROM
    OrderItem i
        JOIN
    Product p ON p.Id = i.ProductId
ORDER BY i.Quantity DESC;
#b. Who will be the competitors for him for the products suggested in above questions.
SELECT 
    p.Id AS ProductId,
    ProductName,
    i.Quantity,
    s.Id AS SupplierId,
    CompanyName,
    ContactName
FROM
    OrderItem i
        JOIN
    Product p ON p.Id = i.ProductId
        JOIN
    Supplier s ON p.SupplierId = s.Id
ORDER BY i.Quantity DESC;
-- ------------------------------------------------------------------------------------------------------------------------
#3.	Create a combined list to display customers and suppliers details considering the following criteria 
#•	Both customer and supplier belong to the same country
#•	Customer who does not have supplier in their country
#•	Supplier who does not have customer in their country
SELECT 
    s.Id AS SupplierId,
    CompanyName,
    ContactName,
    s.Country AS SupplierCountry,
    c.Id AS CustomerId,
    FirstName,
    C.Country AS CustomerCountry
FROM
    Supplier s
        JOIN
    Product p ON s.Id = P.SupplierId
        JOIN
    OrderItem i ON i.ProductId = p.Id
        JOIN
    Orders o ON o.Id = i.OrderId
        JOIN
    Customer c ON c.Id = o.CustomerId
WHERE
    s.Country = c.Country;

SELECT 
    s.Id AS SupplierId,
    CompanyName,
    ContactName,
    s.Country AS SupplierCountry,
    c.Id AS CustomerId,
    FirstName,
    C.Country AS CustomerCountry
FROM
    Supplier s
        JOIN
    Product p ON s.Id = P.SupplierId
        JOIN
    OrderItem i ON i.ProductId = p.Id
        JOIN
    Orders o ON o.Id = i.OrderId
        JOIN
    Customer c ON c.Id = o.CustomerId
WHERE
    s.Country != c.Country;
-- ------------------------------------------------------------------------------------------------------------------------
#4.	Every supplier supplies specific products to the customers. Create a view of suppliers and total sales made by their products and write a query on this view to find out top 2 suppliers (using windows function RANK() in each country by total sales done by the products.
With sale as (select s.*,p.Id as ProductID,i.quantity*i.UnitPrice as sales,
 RANK() OVER (PARTITION BY
                     Country
                 ORDER BY
                     i.quantity*i.UnitPrice DESC 
                ) sales_rank 
from Supplier s join Product p on s.Id = p.SupplierId
join OrderItem i on i.ProductId = p.Id) select * from sale where sales_rank <=2;
-- ------------------------------------------------------------------------------------------------------------------------
#5.	Find out for which products, UK is dependent on other countries for the supply. List the countries which are supplying these products in the same list.
SELECT 
    s.Country AS suppliercountry,
    p.Id AS productid,
    ProductName,
    c.Country
FROM
    Supplier s
        JOIN
    Product p ON s.Id = p.SupplierId
        JOIN
    OrderItem i ON p.Id = i.ProductId
        JOIN
    Orders o ON o.Id = i.OrderId
        JOIN
    Customer c ON o.CustomerId = c.Id
WHERE
    c.Country = 'UK' AND s.Country != 'UK';
-- ------------------------------------------------------------------------------------------------------------------------

