# SQL-VS-POWER-QUERY---DATA-CLEANING

SQL vs Power Query : the same messy dataset, cleaned twice. A side-by-side comparison of two essential data cleaning tools. 


## 1. Inspect the data

A.	MySQL :
After creating the database and the table named: messy_shipping_data, we loaded the csv file with raw data.
We inspected the raw data with the most famous order in SQL : 

select *
from messy_shipping_data;

in order to identify mistakes .
Then we made a plan about the steps we should follow for cleaning our dataset.
This plan is the below :
    -- 2.1 Text standardization
    -- 2.2 Numeric cleaning
    -- 2.3 Date cleaning
    -- 2.4 Validation checks
    -- 2.5 Duplicates

B.	Power Query :
After opening Power Bi desktop we imported the CSV file by clicking on the transform button before load data in the program.
Then we followed the same plan as we did in MySQL.


## 2.1 Text standardization 

A.	MySQL :
The approach we followed is about text type columns such as : vessel_name , origin_port,  destination_port , cargo_type, shipment_status , customer_name ,we used the functions : UPPER,TRIM.
After using these functions we updated the table  using the function UPDATE.
As a final  validate step we used the  function DISTINCT .

B.	Power Query : 
We also used TRIM and UPPERCASE orders . Selecting the column we want right click transform and then we selected the orders mentioned . UPDATE had already done after we selected the buttons.

## 2.2 Numeric Cleaning

A.	MySQL :
About  columns : cargo_weight_kg and shipping_cost_usd we  used the CASE..WHEN..THEN..ELSE function including other such as : TRIM, LOWER,REPLACE. The reason we selected this one is because there were different data entries so this function operates as the “if” in excel. After this we also used UPDATE and DISTINCT as previous. 


B.	Power Query : 
These steps applied separately row by row using the order : REPLACE.

## 2.3 Date Cleaning

A.	MySQL :
For dates also we used the CASE..WHEN..THEN..ELSE  since different types of date format were used and STR_TO_DATE, in order to transform the data type from varchar to date.

B.	Power Query : 
For the two date columns we created 2 new columns with the : add column and M language using “ifs” . After this creation we deleted the old ones columns and replace them with the new cleaned.

## 2.4  Validation checks

A.	MySQL : 
We use this step in order to be sure all previous orders happened successfully .

B.	Power Query : 
Validation checks isn’t a step in Power query ,but it exists at any time under the column titles .
 This info comes from the below path : menu -> view.

 This step does not exists in Power Query.


## 2.5 Removing duplicates

Some containers appear in more than one shipment record.

A.	MySQL : 
Dublicates removed using ROW_NUMBER function:
ROW_NUMBER: is a window function. It assigns a sequential number(1,2,3,..) to each row based on the rules you define inside OVER().
OVER: defines the ‘window’ : count within which group? and in what order?
PATRITION BY container_id : restarts the numbering for each container ,so every container gets its own count (group). It answers the first question of OVER : count within which group? since it splits the rows into groups.
ORDER BY shipment_id : decides which row is ranked first – the earliest shipment (lowest ID) gets row_num =1 ,the next gets 2. This is the line that decides which record counts as the “first occurrence” , so it answers the second question of OVER : in what order? 
WHERE row_num > 1 : filter the 2nd and later occurrences – duplicate appearance
i.e the 6 duplicate records , so the DELETE removes exactly those rows.


B.	Power Query :
Sort by shipment_id : ascending order &  Remove Duplicates on container_id, wrapped in Table.Buffer() to guarantee the sort order is respected — the sort plays the role of `ORDER BY` in deciding which row survives.


## Key Differences

| | SQL (MySQL) | Power Query |
|---|---|---|
| UI | Requires coding | Visual, menu-driven |
| Validation | Queries (SELECT DISTINCT) | Quality bars & column distribution |
| Steps | Scroll through the script | Listed in the Applied Steps panel |
| Access to original data | Lost after UPDATE — re-import needed | One click away in the Source step |
| Repeatability | Re-run the script manually | Refresh re-applies all steps |
| Error visibility | Found by querying | Shown per cell/column |
| Scale | Millions of rows, in-database | Small/medium files |

==================







