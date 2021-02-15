-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------
use bank;
# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
 SELECT 
    *
FROM
    cricket_1
Union
SELECT 
    *
FROM
    cricket_2;
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50
SELECT 
    player_id, player_name, runs
FROM
    cricket_1
WHERE
    runs > 50;
# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.
SELECT 
    *
FROM
    cricket_1
WHERE
    player_name LIKE 'y%v';
# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.
SELECT 
    *
FROM
    cricket_1
WHERE
    player_name NOT LIKE '%t';
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------
# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio  of popularity to charisma .(Hint :- Popularity divide by Charisma)
alter table cric_combined add PC_Ratio float;
UPDATE cric_combined 
SET 
    PC_Ratio = ROUND(Popularity / Charisma, 2);
# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.
SELECT 
    *
FROM
    cric_combined
ORDER BY PC_Ratio DESC
LIMIT 5;
# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.
SELECT 
    *
FROM
    cric_combined
WHERE
    player_name LIKE '%d%';
# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
SELECT 
    *
FROM
    cric_combined
WHERE
    PC_ratio BETWEEN 0.12 AND 0.25;
-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
 SELECT 
    player_id, player_name
FROM
    new_cricket
WHERE
    charisma IS NULL;
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
SELECT 
    player_id,
    player_name,
    runs,
    popularity,
    IFNULL(charisma, 0) AS Charisma
FROM
    new_cricket;
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
 SELECT 
    SUBSTR(player_id, 3) AS player_id
FROM
    new_cricket;
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.
SELECT 
    player_id, player_name, charisma
FROM
    new_cricket
WHERE
    charisma > 25;
-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------
SELECT 
    *
FROM
    churn_details;
# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount for those paymentmethod is through Electronic check mode.
SELECT 
    customerid, FLOOR(monthlyservicecharges), CEIL(totalamount)
FROM
    churn1
WHERE
    paymentmethod LIKE 'Electronic check';
# Q14. Rename the table churn1 to “Churn_Details”.
ALTER TABLE churn1 RENAME TO Churn_Details;
# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.
ALTER TABLE Churn_Details ADD New_Amount FLOAT;
UPDATE Churn_Details 
SET 
    New_amount = TotalAmount + MonthlyServiceCharges;
SELECT 
    *
FROM
    Churn_Details;
# Q16. Rename column new_Amount to Amount.
ALTER TABLE Churn_details RENAME COLUMN new_amount TO Amount;
# Q17. Drop the column “Amount” from the table “Churn_Details”.
ALTER TABLE churn_details DROP COLUMN Amount;
# Q18. Write a query to extract the customerID, InternetConnection and gender from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ at the second position.
SELECT 
    customerID, InternetConnection, gender
FROM
    churn_details
WHERE
    InternetConnection LIKE '_i%';
# Q19. Find the records where the tenure is 6x, where x is any number.
SELECT 
    *
FROM
    churn_details
WHERE
    MOD(tenure, 6) = 0;
# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.
SELECT 
    UPPER(player_name), IFNULL(charisma, 0), player_id
FROM
    new_cricket
ORDER BY player_name;