---live assignments-11.12.2022
---Q1
USE DATABASE DEMODATABASE2;

CREATE or replace table AG_SALES
  (order_id VARCHAR2(90),
   order_date VARCHAR2(50) NOT NULL PRIMARY KEY,
   ship_date VARCHAR2(50),
   ship_mode VARCHAR2(50),
   customer_name VARCHAR2(50),
   segment VARCHAR2(50),
   state VARCHAR2(50),
   country VARCHAR2(90),
   market VARCHAR2(50),
   region VARCHAR2(50),
   product_id VARCHAR2(100),
   category	VARCHAR2(50),
   sub_category VARCHAR2(50),
   product_name VARCHAR2(200),
   sales number(10,2),
   quantity VARCHAR2(50),
   discount VARCHAR2(50),
   profit VARCHAR2(50),
   shipping_cost VARCHAR2(50),
   order_priority VARCHAR2(50),
   year VARCHAR2(50));

DESCRIBE TABLE AG_SALES; 
select * from AG_SALES;

CREATE OR REPLACE TABLE  AG_SALES_COPY AS
SELECT * FROM AG_SALES;

SELECT * FROM AG_SALES_COPY;
DESCRIBE TABLE AG_SALES_COPY;
--Q2 Change the Primary key to Order Id Column.

ALTER TABLE AG_SALES
DROP PRIMARY KEY;

ALTER TABLE AG_SALES_COPY
ADD PRIMARY KEY(order_id);

DESCRIBE TABLE AG_SALES_COPY; 

---Q3 Check the data type for Order date and Ship date and mention in what data type
    it should be?
---NOT UNDERSTOOD

---Q4 Create a new column called order_extract and extract the number after the last--
---‘–‘from Order ID column.

SELECT *,substring(ORDER_ID,9,12) AS ORDER_EXTRACT
FROM AG_SALES_COPY;


---Q5 Create a new column called Discount Flag and categorize it based on discount.
 ---    Use ‘Yes’ if the discount is greater than zero else ‘No’. 
 
SELECT *,
CASE WHEN DISCOUNT > 0 then 'YES'
     else 'NO'
   END AS DISCOUNT_TYPE
  
   FROM AG_SALES_COPY;
   
 -----Q6 Create a new column called process days and calculate how many days it takes
---for each order id to process from the order to its shipment. 

SELECT*,DATEDIFF('days',ORDER_DATE,SHIP_DATE) as PROCESS_DAYS
FROM AG_SALES_COPY;
 
----Create a new column called Rating and then based on the Process dates give
----rating like given below.

CREATE OR REPLACE TABLE AG_SALES_COPY AS
SELECT*, 
    CASE
       WHEN DATEDIFF('days',ORDER_DATE,SHIP_DATE)<=3 THEN 5
       WHEN DATEDIFF('days',ORDER_DATE,SHIP_DATE)BETWEEN 4 AND 6 THEN 4
       WHEN DATEDIFF('days',ORDER_DATE,SHIP_DATE)BETWEEN 7 AND 10 THEN 3
       ELSE 2
     END AS RATING
FROM AG_SALES_COPY;