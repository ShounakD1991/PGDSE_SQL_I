/* Prerequisites */
-- Use the Bank_Holidays and bank_inventory tables from Online_Day1_Inclass file to answer the below questions

# Question 1:
# 1) Increase the length of geo_location size of 30 characters in the bank_inventory table.
ALTER TABLE bank_inventory MODIFY geo_location VARCHAR(30);
# Question 2:
# 2) Update  estimated_sale_price of bank_inventory table with an increase of 15%  when the quantity of product is more than 4.
UPDATE bank_inventory 
SET 
    estimated_sale_price = (1.15 * estimated_sale_price)
WHERE
    quantity > 4;
# Question 3:
# 3) Insert below record by increasing 10% of estimated_sale_price to the given estimated_sale_price 
		-- Product : DailCard
		-- Quantity: 2 
		-- price : 380.00 
		-- Puchase_cost : 8500.87
		-- estimated_sale_price: 9000.00
INSERT INTO bank_inventory(Product,Quantity,Price,purchase_cost,estimated_sale_price) 
VALUES ('DailCard',2,300.45,8000.87,9000.56);
UPDATE bank_inventory 
SET 
    estimated_sale_price = (1.1 * estimated_sale_price)
WHERE
    product='DailCard';
 
# Question 4:
# 4) Delete the records from bank_inventory when the difference of estimated_sale_price and 
-- Purchase_cost is less than 5% of estimated_sale_price 
DELETE FROM bank_inventory 
WHERE
    (ABS(purchase_cost - estimated_sale_price) < (estimated_sale_price * 0.05));
# Question 5:
# 5) Update the end time of bank holiday to 2020-03-20 11:59:59 for the holiday on 2020-03-20
 UPDATE bank_holiday 
SET 
    end_time = '2020-03-20 11:59:59';
#------------------------------------------------------------------------------------------------------------------------------------------------------
# Use tables cricket_1 and cricket_2 from Online_Day2_InClass to answer the queries. 
SELECT 
    *
FROM
    cricket_1;
SELECT 
    *
FROM
    cricket_2;
# Question 6:

# Q6.Extract Player_Id and Player_name of those columns where charisma is null.
SELECT 
    player_id, player_name
FROM
    cricket_2
WHERE
    charisma IS NULL;
# Question 7:

# Q7.Write MySQL query to extract Player_Id , Player_Name , charisma where charisma is greater than 25.
SELECT 
    player_id, player_name
FROM
    cricket_2
WHERE
    charisma>25;
# Question 8:

# Q8.Write MySQL query to extract Player_Id , Player_Name who scored fifty and above
SELECT 
    Player_Id, Player_Name
FROM
    cricket_1
WHERE
    runs > 50 
UNION ALL SELECT 
    Player_Id, Player_Name
FROM
    cricket_2
WHERE
    runs > 50;
# Question 9:

# Q9.Write MySQL query to extract Player_Id , Player_Name who have popularity in the range of 10 to 12.
SELECT 
    *
FROM
    cricket_1
WHERE
    popularity BETWEEN 10 AND 12;

# Question 10:

# Q10.Write MySQL query to extract Player_id, Player_Name where the Runs and Charisma both are greater than 50.
SELECT 
    player_id, player_name
FROM
    cricket_2
WHERE
    runs > 50 AND charisma > 50;
