/*1- write a query to print top 5 cities with highest spends and their percentage 
contribution of total credit card spends */

WITH cte1 AS
(
    SELECT city,
           SUM(amount) AS total_spend
    FROM credit_card_transcations
    GROUP BY city
),
total_spent AS
(
    SELECT SUM(CAST(amount AS BIGINT)) AS total_amount
    FROM credit_card_transcations
)
SELECT TOP 5
       cte1.city,
       cte1.total_spend,
       ROUND(total_spend * 1.0 / total_amount * 100, 2) AS percentage_contribution
FROM cte1
CROSS JOIN total_spent
ORDER BY total_spend DESC;

/*2- write a query to print highest spend month and amount spent in 
that month for each card type
*/
select *from credit_card_transcations;
WITH cte as(
    SELECT card_type,
            DATEPART(year,transaction_date) as yt,
            DATEPART(month,transaction_date) as mt,
            SUM(amount) as total_spend
    FROM credit_card_transcations
    GROUP BY card_type,
            DATEPART(year,transaction_date),
            DATEPARt(month,transaction_date)
)
SELECT *
FROM(
    SELECT *,
    RANK() OVER(PARTITION BY card_type
                ORDER BY total_spend desc) as rn
    FROM cte
    )a
WHERE rn=1;


/*3- write a query to print the transaction details(all columns from the table) for each card type when
it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)*/

WITH cte AS(
    SELECT *,
    SUM(amount) OVER(PARTITION BY card_type
                     ORDER BY transaction_date,transaction_id) as total_spend
    FROM credit_card_transcations
)
SELECT *
FROM(
        SELECT *,
         RANK()OVER(PARTITION BY card_type
                    ORDER BY total_spend) as rn
        FROM cte
        WHERE total_spend>=1000000
    )a
WHERE rn=1;

/*4- write a query to find city which had lowest percentage spend for gold card type*/
WITH cte AS(
    SELECT city,
            card_type,
            SUM(amount) as amount,
            SUM(CASE WHEN card_type='Gold' THEN amount END) as gold_amount
    FROM credit_card_transcations
    GROUP BY city,card_type
)
SELECT city,
        SUM(gold_amount)*1.0/sum(amount) as gold_ratio
FROM cte
GROUP BY city
HAVING COUNT(gold_amount)>0
    AND SUM(gold_amount)>0
ORDER BY gold_ratio;

/*5- write a query to print 3 columns:city, highest_expense_type , lowest_expense_type
(example format : Delhi , bills, Fuel)*/
WITH cte AS(
    SELECT city,exp_type,
        SUM(amount) as total_amount
    FROM credit_card_transcations
    GROUP by city,exp_type
)
SELECT city,
        MAX(CASE WHEN rn_asc=1 THEN exp_type END) as lowest_exp_type,
        MIN(CASE WHEN rn_desc=1 THEN exp_type END) as highest_ext_type
FROM (
        SELECT *,
        RANK()OVER(PARTITION BY city
                    ORDER BY total_amount desc) as rn_desc,
        RANK()OVER(PARTITION BY city
                    ORDER BY total_amount asc) as rn_asc
        FROM cte
      )a
GROUP BY city;
/*6- write a query to find percentage contribution of spends 
by females for each expense type
*/

SELECT exp_type,
        SUM(CASE WHEN gender='F' THEN amount else 0 end)*1.0/sum(amount) as female_per_contribution
    FROM credit_card_transcations
    GROUP BY exp_type
ORDER BY female_per_contribution desc;
/*7- which card and expense type combination saw highest month over month growth in Jan-2014*/

WITH cte AS(
    SELECT card_type,exp_type,
        DATEPART(year,transaction_date) as yt,
        DATEPART(month,transaction_date) as mt,
        SUM(amount) as total_spend
    FROM credit_card_transcations
    GROUP BY card_type,exp_type,
        DATEPART(year,transaction_date),
        DATEPART(month,transaction_date)
)
SELECT top 1*,(total_spend-prev_month_spend) as mom_growth
FROM (
        SELECT *,
        LAG(total_spend,1) OVER(PARTITION BY card_type,exp_type
                                ORDER BY yt,mt) as prev_month_spend
        FROM cte
    )a
WHERE prev_month_spend is not null and yt=2014 and mt=1
ORDER BY mom_growth desc;

/*8- during weekends which city has highest total spend to total no of transcations ratio 
*/
select top 1 city , 
            sum(amount)*1.0/count(1) as ratio
from credit_card_transcations
where datepart(weekday,transaction_date) in (1,7)
group by city
order by ratio desc;

/*09- which city took least number of days to reach its 500th transaction
after the first transaction in that city*/

WITH cte AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY city
               ORDER BY transaction_date, transaction_id
           ) AS rn
    FROM credit_card_transcations
)
SELECT TOP 1
       city,
       DATEDIFF(DAY, MIN(transaction_date), MAX(transaction_date)) AS days_taken
FROM cte
WHERE rn = 1 OR rn = 500
GROUP BY city
HAVING COUNT(*) = 2
ORDER BY days_taken ASC;
