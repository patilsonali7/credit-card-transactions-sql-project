# Credit Card Transactions SQL Project

## Project Overview

This project focuses on analyzing credit card transaction data using SQL Server.
The project contains SQL queries to solve different business-related problems
using aggregations, CTEs, window functions, date functions, and conditional logic.

## Objective

The objective of this project is to analyze credit card transactions and
extract useful business insights such as spending patterns, card-wise spending,
city-wise spending, expense types, and transaction trends.

## Tools Used

- SQL Server
- SQL Server Management Studio (SSMS)

## SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions: SUM(), COUNT()
- CASE WHEN
- CTEs
- Window Functions
- ROW_NUMBER()
- RANK()
- LAG()
- DATEPART()
- DATEDIFF()
- CROSS JOIN
- CAST()
- ROUND()

## Business Questions Solved

1. Find the top 5 cities with the highest spends and their percentage
   contribution to total credit card spends.

2. Find the highest spend month and amount spent in that month for each
   card type.

3. Find the transaction details for each card type when cumulative spending
   reaches 1,000,000.

4. Find the city with the lowest percentage spend for the Gold card type.

5. Find the highest and lowest expense type for each city.

6. Find the percentage contribution of spends by females for each expense type.

7. Find the card type and expense type combination with the highest
   month-over-month growth in January 2014.

8. Find the city with the highest total spend-to-total transaction ratio
   during weekends.

9. Find the city that took the least number of days to reach its 500th
   transaction after its first transaction.

## Key SQL Skills Demonstrated

This project demonstrates practical use of SQL for business analysis,
including:

- Data aggregation and grouping
- Percentage calculations
- Ranking and ordering
- Running totals
- Window functions
- Month-over-month analysis
- Customer/city transaction sequencing
- Date-based analysis
- Conditional aggregation

## Project Structure

- `project1-CREDIT_CARD_TRANSACTIONS.sql` — SQL queries used to solve the
  business questions.
- `README.md` — Project documentation.
