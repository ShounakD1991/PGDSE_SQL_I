# Question 1:
# 1) Create a Database Bank.
CREATE DATABASE bank;
USE bank;
# Question 2:
# 2) Create a table with the name “Bank_Inventory” with the following columns
-- Product  with string data type and size 10 --
-- Quantity with numerical data type --
-- Price with data type that can handle all real numbers
-- purcahase_cost with data type which always shows two decimal values --
-- estimated_sale_price with data type float --
CREATE TABLE bank_inventory (
    Product CHAR(10),
    Quantity INT,
    Price FLOAT,
    purchase_cost DECIMAL(10 , 2 ),
    estimated_sale_price FLOAT
);
# Question 3:
# 3) Display all column names and their datatype and size in Bank_Inventory.
DESC bank_inventory;
# Question 4:
# 4) Insert the below two records into Bank_Inventory table .
-- 1st record with values --
			-- Product : PayCard
			-- Quantity: 2 
			-- price : 300.45 
			-- Puchase_cost : 8000.87
			-- estimated_sale_price: 9000.56 --
-- 2nd record with values --
			-- Product : PayPoints
			-- Quantity: 4
			-- price : 200.89 
			-- Puchase_cost : 7000.67
			-- estimated_sale_price: 6700.56
INSERT INTO bank_inventory(Product,Quantity,Price,purchase_cost,estimated_sale_price) 
VALUES ('PayCard',2,300.45,8000.87,9000.56),
('PayPoints',4,200.89,7000.67,6700.56);
# Question 5:
# 5) Add a column : Geo_Location to the existing Bank_Inventory table with data type varchar and size 20 .
ALTER TABLE bank_inventory ADD COLUMN Geo_location VARCHAR(20);
# Question 6:
# 6) What is the value of Geo_Location for product : ‘PayCard’?
SELECT 
    geo_location
FROM
    bank_inventory
WHERE
    product = 'PayCard';
# Question 7:
# 7) How many characters does the  Product : ‘PayCard’ store in the Bank_Inventory table.
SELECT 
    product, LENGTH(product) AS Length_Product
FROM
    bank_inventory
WHERE
    product = 'PayCard';
# Question 8:
# a) Update the Geo_Location field from NULL to ‘Delhi-City’
UPDATE bank_inventory 
SET 
    geo_location = 'Delhi-City'
WHERE
    geo_location IS NULL;
# b) How many characters does the  Geo_Location field value ‘Delhi-City’ stores in the Bank_Inventory table
SELECT 
    *, LENGTH(geo_location) AS length_Geo_Location
FROM
    bank_inventory
WHERE
    geo_location = 'Delhi-City';
# Question 9:
# 9) update the Product field from CHAR to VARCHAR size 10 in Bank_Inventory 
ALTER TABLE bank_inventory MODIFY product VARCHAR(20);
# Question 10:
# 10) Reduce the size of the Product field from 10 to 6 and check if it is possible. 
#We cannot do this because if we'll do this we are trying to truncate the 1st row's data which has length of seven characters. Hence, compromising with data integrity
# Question 11:
# 11) Bank_inventory table consists of ‘PayCard’ product details .
-- For ‘PayCard’ product, Update the quantity from 2 to 10  
UPDATE bank_inventory 
SET 
    quantity = 10
WHERE
    product = 'PayCard';
 # Question 12:
# 12) Create a table named as Bank_Holidays with below fields 
-- a) Holiday field which displays or accepts only date
-- b) Start_time field which also displays or accepts date and time both.  
-- c) End_time field which also displays or accepts date and time along with the timezone also. 
CREATE TABLE bank_holiday (
    Holiday_date DATE,
    Start_time DATETIME,
    End_time TIMESTAMP
);

 # Question 13:
# 13) Step 1: Insert today’s date details in all fields of Bank_Holidays
INSERT INTO bank_holiday(holiday_date,start_time,end_time) VALUES (current_date(),current_date(),current_date());
-- Step 2: After step1, perform the below 
-- Postpone Holiday to next day by updating the Holiday field 
UPDATE bank_holiday 
SET 
    Holiday_date = CURRENT_DATE() + 1;
# Question 14:
# 14) Modify  the Start_time data with today's datetime in the Bank_Holidays table 
UPDATE bank_holiday 
SET 
    holiday_date = NOW();
# Question 15:
# 15) Update the End_time with UTC time(GMT Time) in the Bank_Holidays table. 
UPDATE bank_holiday 
SET 
    end_time = UTC_TIMESTAMP();
# Question 16:
# 16) Select all columns from Bank_Inventory without mentioning any column name
SELECT 
    *
FROM
    bank_inventory;
# Question 17:
# 17)  Display output of PRODUCT field as NEW_PRODUCT in  Bank_Inventory table 
SELECT 
    product AS New_product
FROM
    bank_inventory;
# Question 18:
# 18)  Display only one record from bank_Inventory 
SELECT 
    *
FROM
    bank_inventory
LIMIT 1;
# Question 19:
# 19) Modify  the End_time data with today's datetime in the Bank_Holidays table 
UPDATE bank_holiday 
SET 
    end_time = CURRENT_TIMESTAMP();
# Question 20:
# 20) Display the first five rowss of the Geo_location field of Bank_Inventory.
SELECT 
    geo_location
FROM
    bank_inventory
LIMIT 5;