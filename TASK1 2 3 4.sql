TASK1.sql
-- -----------------------------------------------------------------Tasks 1: Database Design:---------------------------------------------------------------
-- 1. Create the database named "HMBank"
CREATE DATABASE HMBank;

use HMBank;

-- 2. Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema.
-- 5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
-- 6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.
-- Customers
-- Accounts
-- Transactions

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(65) not null,
  last_name VARCHAR(60) not null,
  DOB DATE not null,
  email VARCHAR(100),
  phone_number VARCHAR(20) not null,
  address VARCHAR(300) not null
);

CREATE TABLE Accounts (
  account_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  account_type ENUM('savings', 'current', 'zero_balance'),
  balance DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
  transaction_id INT PRIMARY KEY AUTO_INCREMENT,
  account_id INT,
  transaction_type ENUM('deposit', 'withdrawal', 'transfer'),
  amount DECIMAL(10,2),
  transaction_date DATETIME, 
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

DELIMITER //
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON Transactions FOR EACH ROW
BEGIN
  DECLARE trans_amount DECIMAL(10,2);
  DECLARE acc_id INT;
  DECLARE acc_balance DECIMAL(10,2);
  
  SET acc_id = NEW.account_id;
  SET trans_amount = NEW.amount;

  SELECT balance INTO acc_balance FROM Accounts WHERE account_id = acc_id;

  IF NEW.transaction_type = 'deposit' THEN
    UPDATE Accounts SET balance = acc_balance + trans_amount WHERE account_id = acc_id;
  ELSEIF NEW.transaction_type = 'withdrawal' THEN
    UPDATE Accounts SET balance = acc_balance - trans_amount WHERE account_id = acc_id;
  ELSEIF NEW.transaction_type = 'transfer' THEN
    -- Assuming transfer means transferring out
    UPDATE Accounts SET balance = acc_balance - trans_amount WHERE account_id = acc_id;
  END IF;
END; //
DELIMITER ;





-- 1. Insert at least 10 sample records into each of the following tables.
-- Customers
-- Accounts
-- Transactions

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address)
VALUES 
    ('Emily', 'Johnson', '1990-05-15', 'emily.johnson@email.com', '(555) 123-4567', '123 Maple Street, Cityville, State, 12345'),

    ('Michael', 'Rodriguez', '1985-09-22', 'michael.rodriguez@email.com', '(555) 987-6543', '456 Oak Avenue, Townsville, State, 54321'),

    ('Olivia', 'Smith', '1993-03-10', 'olivia.smith@email.com', '(555) 321-7890', '789 Pine Lane, Villagetown, State, 67890'),

    ('Benjamin', 'Carter', '1988-11-05', 'benjamin.carter@email.com', '(555) 456-7891', '101 Cedar Road, Hamletville, State, 23456'),

    ('Sophia', 'Anderson', '1996-07-18', 'sophia.anderson@email.com', '(555) 789-0123', '202 Birch Street, Villageville, State, 34567'),

    ('William', 'Davis', '1982-01-30', 'william.davis@email.com', '(555) 234-5678', '303 Elm Avenue, Citytown, State, 45678'),

    ('Ava', 'Martinez', '1997-04-25', 'ava.martinez@email.com', '(555) 876-5432', '404 Spruce Lane, Suburbia, State, 56789'),

    ('Elijah', 'White', '1984-08-12', 'elijah.white@email.com', '(555) 345-6789', '505 Pine Street, Riverside, State, 67890'),

    ('Mia', 'Taylor', '1995-12-03', 'mia.taylor@email.com', '(555) 678-9012', '606 Cedar Road, Hilltop, State, 78901'),

    ('Lucas', 'Brown', '1989-06-20', 'lucas.brown@email.com', '(555) 901-2345', '707 Oak Avenue, Meadowville, State, 89012');
select * from customers;

INSERT INTO Accounts (customer_id, account_type, balance)
VALUES 
  (1, 'savings', 8000.00),
  (2, 'current', 11000.50),
  (3, 'zero_balance', 0.00),
  (4, 'savings', 7500.75),
  (5, 'current', 11000.25),
  (6, 'zero_balance', 0.00),
  (7, 'savings', 3000.50),
  (8, 'current', 1000.20),
  (9, 'zero_balance', 0.00),
  (10, 'savings', 80000.00),
   (1, 'current', 9000.20),
   (1, 'zero_balance', 0.00),
   (7, 'current', 7000.20),
   (8,	, 'savings', 3000.50);
   
   
   
   

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES 
  (11, 'deposit', 8000.00, '2023-03-11'),
  (2, 'deposit', 900.50, '2021-01-14'),
  (4, 'deposit', 8000.25, '2022-11-12'),
  (7, 'deposit', 200.00, '2022-05-16'),
  (10, 'deposit', 1800.00, '2020-01-17'),

  (11, 'withdrawal', 700.75, '2023-11-11'),
  (8, 'withdrawal', 300.20, '2023-10-14'),

 (11, 'transfer', 100.50, '2024-01-10'),
  (2, 'transfer', 300.50, '2024-01-10'),
  (6, 'transfer', 800.00, '2024-01-10'),
  (9, 'transfer', 400.00, '2024-01-10');

  
--   -- Deposit for account_id 1
-- UPDATE Accounts
-- SET balance = balance + 1000.00
-- WHERE account_id = 1;

-- -- Deposit for account_id 2
-- UPDATE Accounts
-- SET balance = balance + 400.50
-- WHERE account_id = 2;

-- -- Deposit for account_id 4
-- UPDATE Accounts
-- SET balance = balance + 2000.25
-- WHERE account_id = 4;

-- -- Deposit for account_id 7
-- UPDATE Accounts
-- SET balance = balance + 600.00
-- WHERE account_id = 7;

-- -- Deposit for account_id 10
-- UPDATE Accounts
-- SET balance = balance + 1500.00
-- WHERE account_id = 10;

-- -- Withdrawal for account_id 1
-- UPDATE Accounts
-- SET balance = balance - 900.75
-- WHERE account_id = 1;

-- -- Withdrawal for account_id 5
-- UPDATE Accounts
-- SET balance = balance - 800.75
-- WHERE account_id = 5;

-- -- Withdrawal for account_id 8
-- UPDATE Accounts
-- SET balance = balance - 300.20
-- WHERE account_id = 8;

-- -- Transfer from account_id 1 to account_id 2
-- UPDATE Accounts
-- SET balance = balance - 200.50
-- WHERE account_id = 1;

-- UPDATE Accounts
-- SET balance = balance + 200.50
-- WHERE account_id = 2;

-- -- Transfer from account_id 2 to account_id 6
-- UPDATE Accounts
-- SET balance = balance - 200.50
-- WHERE account_id = 2;

-- UPDATE Accounts
-- SET balance = balance + 200.50
-- WHERE account_id = 6;

-- -- Transfer from account_id 6 to account_id 9
-- UPDATE Accounts
-- SET balance = balance - 500.00
-- WHERE account_id = 6;

-- UPDATE Accounts
-- SET balance = balance + 500.00
-- WHERE account_id = 9;

-- -- Transfer from account_id 9 to account_id 1
-- UPDATE Accounts
-- SET balance = balance - 200.00
-- WHERE account_id = 9;

-- UPDATE Accounts
-- SET balance = balance + 200.00
-- WHERE account_id = 1;


  
  SELECT BALANCE,ACCOUNT_TYPE FROM ACCOUNTS WHERE CUSTOMER_ID=1;

  

-- ------------------------------------------------------------------QUESTION 2:
-- 2.1. Write a SQL query to retrieve the name, account type and email of all customers.
select 
  concat(concat(c.first_name," "),c.last_name) "Name",
  a.account_type 'account type',
  c.email
FROM
  Customers c
JOIN
  Accounts a ON c.customer_id = a.customer_id;
  
  
-- 2.2 Write a SQL query to list all transaction corresponding customers
-- using joins
select 
  c.customer_id,
  concat(concat(c.first_name," "),c.last_name) "Name",
  a.account_id,
   a.account_type,
  t.transaction_type,
  t.amount,
  t.transaction_date
FROM
  Transactions t
JOIN
  Accounts a ON t.account_id = a.account_id
JOIN
  Customers c ON a.customer_id = c.customer_id;
  
-- 2.3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       SUM(t.amount) AS total_deposits
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'deposit'
  AND DATE(t.transaction_date) like '%2020-01-17%'
GROUP BY c.customer_id, customer_name;

-- 2.4. Write a SQL query to Combine first and last names of customers as a full_name.
select 
	concat(concat(c.first_name," "),c.last_name) "full_name"
FROM
Customers c;
  
  
-- 2.5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE 
FROM Accounts
WHERE 
account_type = 'savings' AND balance = 0.00;
select * from accounts;

-- 2.6. Write a SQL query to Find customers living in a specific city.
SELECT *
FROM
CUSTOMERS
WHERE
ADDRESS LIKE '%CHENNAI%';
 -- OR
SELECT *
FROM Customers
WHERE LOWER(address) LIKE LOWER('%Pine Street%');


-- 2.7. Write a SQL query to Get the account balance for a specific account.
SELECT
BALANCE
FROM 
ACCOUNTS
WHERE ACCOUNT_ID=5;

-- 2.8. Write a SQL query to List all current accounts with a balance greater than $1,000.

SELECT *
FROM 
ACCOUNTS
WHERE ACCOUNT_TYPE='CURRENT' AND BALANCE > 1000;

-- 2.9. Write a SQL query to Retrieve all transactions for a specific account.
SELECT
A.ACCOUNT_ID,
A.ACCOUNT_TYPE,
T.TRANSACTION_ID,
T.TRANSACTION_TYPE
FROM
ACCOUNTS A,
TRANSACTIONS T
WHERE
A.ACCOUNT_ID=T.ACCOUNT_ID AND A.ACCOUNT_ID=2;


-- 2.10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
SELECT 
    account_id, 
    balance * 0.06 AS interest_accrued
FROM Accounts
WHERE account_type = 'savings';


-- 2.11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.

SELECT *
FROM 
ACCOUNTS
WHERE BALANCE <100;

-- 2.12. Write a SQL query to Find customers not living in a specific city.
SELECT * 
FROM 
CUSTOMERS
WHERE
LOWER(ADDRESS) NOT LIKE '%townsville%';


- ------------------------------------------------------Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:---------------------------------------------
-- 1. Write a SQL query to Find the average account balance for all customers.
SELECT 
AVG(BALANCE) 'AVERAGE BALANCE'
FROM
ACCOUNTS;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
SELECT 
C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),A.ACCOUNT_ID,A.BALANCE,A.ACCOUNT_TYPE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
ORDER BY A.BALANCE DESC LIMIT 0,10;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(t.amount) AS total_deposits
FROM
    Customers c
JOIN
    Accounts a ON c.customer_id = a.customer_id
JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_type = 'deposit'
    AND DATE(t.transaction_date) like '%2023-01-16%' -- not working why
GROUP BY
    c.customer_id, customer_name;



SELECT
    account_id,
    SUM(amount) AS total_deposits,
    MIN(transaction_date) AS deposit_date
FROM
    Transactions
WHERE
    transaction_type = 'deposit' AND
    transaction_date LIKE '%2023-01-16%' -- not working why
GROUP BY
    account_id
LIMIT 0, 1000;

-- 4. Write a SQL query to Find the Oldest and Newest Customers
-- Oldest Customer
SELECT *
FROM Customers
ORDER BY DOB ASC
LIMIT 1;

-- Newest Customer
SELECT *
FROM Customers
ORDER BY DOB DESC
LIMIT 1;
-- 5. Write a SQL query to Retrieve transaction details along with the account type.
SELECT 
A.ACCOUNT_ID,A.ACCOUNT_TYPE,T.TRANSACTION_ID,T.TRANSACTION_TYPE
FROM ACCOUNTS A
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID;

-- 6. Write a SQL query to Get a list of customers along with their account details.
SELECT *
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID;
-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
SELECT 
C.CUSTOMER_ID,C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),C.PHONE_NUMBER,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID
WHERE T.ACCOUNT_ID=2;

-- 8. Write a SQL query to Identify customers who have more than one account.
SELECT 
C.CUSTOMER_ID,C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME) NAME,C.PHONE_NUMBER,A.ACCOUNT_ID,A.ACCOUNT_TYPE,A.BALANCE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
WHERE C.CUSTOMER_ID IN(SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1 );
-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
-- done using triggers

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
SELECT
    a.account_id,
    AVG(a.balance) AS average_daily_balance
FROM
    Accounts a
JOIN
    Transactions t ON a.account_id = t.account_id
WHERE
    t.transaction_date BETWEEN '2020-01-16' AND '2023-01-16'
GROUP BY
    a.account_id;


-- 11. Calculate the total balance for each account type.
SELECT AVG(BALANCE),ACCOUNT_TYPE 
FROM ACCOUNTS 
GROUP BY ACCOUNT_TYPE;
-- 12. Identify accounts with the highest number of transactions order by descending order.
-- SELECT 
-- ACCOUNT_ID,TRANSACTION_ID
-- FROM TRANSACTIONS
-- GROUP BY ACCOUNT_ID HAVING COUNT(*)>1;
SELECT 
ACCOUNT_ID,TRANSACTION_ID
FROM TRANSACTIONS
WHERE ACCOUNT_ID in(SELECT ACCOUNT_ID FROM TRANSACTIONS
GROUP BY ACCOUNT_ID HAVING COUNT(*)>1);

-- 13. List customers with high aggregate account balances, along with their account types.
SELECT
C.CUSTOMER_ID,C.FRIST_NAME,A.ACCOUNT_TYPE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=C.ACCOUNT_ID;

SELECT SUM(BALANCE),ACCOUNT_TYPE,C.CUSTOMER_ID,C.FIRST_NAME
FROM ACCOUNTS A 
JOIN CUSTOMERS C ON A.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY ACCOUNT_TYPE;

SELECT
    SUM(A.BALANCE) AS TOTAL_BALANCE,
    A.ACCOUNT_TYPE,
    C.CUSTOMER_ID,
    C.FIRST_NAME
FROM
    ACCOUNTS A
JOIN
    CUSTOMERS C ON A.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
    A.ACCOUNT_TYPE,
    C.CUSTOMER_ID,
    C.FIRST_NAME;


-- 14. Identify and list duplicate transactions based on transaction amount, date, and account
      SELECT amount, transaction_date, account_id, COUNT(*) AS duplicate_count
FROM your_transaction_table
GROUP BY amount, transaction_date, account_id
HAVING COUNT(*) > 1;


 --------------------------------------------------------Tasks 4: Subquery and its type:--------------------------------------------------------
-- 1. Retrieve the customer(s) with the highest account balance.
SELECT distinct
BALANCE
FROM
ACCOUNTS ORDER BY BALANCE DESC
LIMIT 1;
-- ------------------------------------------------------------OR
SELECT C.CUSTOMER_ID, C.FIRST_NAME,A.BALANCE
FROM CUSTOMERS C,ACCOUNTS A
WHERE C.CUSTOMER_ID=A.CUSTOMER_ID IN (
    SELECT A.CUSTOMER_ID
    FROM ACCOUNTS A
    WHERE A.BALANCE = (
        SELECT DISTINCT BALANCE
        FROM ACCOUNTS
        ORDER BY BALANCE DESC
        LIMIT 1
    )
);




-- 2. Calculate the average account balance for customers who have more than one account.

SELECT AVG(BALANCE) FROM ACCOUNTS WHERE CUSTOMER_ID IN (
SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1)
;


-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
SELECT C.CUSTOMER_ID,A.ACCOUNT_ID,T.AMOUNT
FROM CUSTOMERS C,ACCOUNT A 
WHERE C.CUSTOMERS=A.ACCOUNTS IN(
SELECT A.ACCOUNT_ID
FROM ACCOUNTS A,TRANSACTIONS T WHERE T.AMOUNT>
(SELECT AVG(AMOUNT) FROM TRANSACTIONS));

SELECT ACCOUNT_ID,AMOUNT 
FROM TRANSACTIONS WHERE AMOUNT>(
SELECT AVG(AMOUNT) FROM TRANSACTIONS) ;



SELECT C.CUSTOMER_ID, A.ACCOUNT_ID, T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE A.ACCOUNT_ID IN (
    SELECT A.ACCOUNT_ID
    FROM ACCOUNTS A
    JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
    WHERE T.AMOUNT > (SELECT AVG(AMOUNT) FROM TRANSACTIONS)
);


-- 4. Identify customers who have no recorded transactions.
SELECT 
C.CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME)
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID=T.ACCOUNT_ID
WHERE T.TRANSACTION_ID IS NULL;



-- 5. Calculate the total balance of accounts with no recorded transactions.
SELECT ACCOUNT_ID FROM TRANSACTIONS
WHERE TRANSACTION_ID IS NULL;
SELECT * FROM TRANSACTIONS;
-- 6. Retrieve transactions for accounts with the lowest balance.

SELECT A.ACCOUNT_ID,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT,A.BALANCE
FROM TRANSACTIONS T
JOIN ACCOUNTS A ON T.ACCOUNT_ID=A.ACCOUNT_ID WHERE A.ACCOUNT_ID IN(
SELECT ACCOUNT_ID 
FROM
ACCOUNTS WHERE BALANCE = 
(SELECT DISTINCT(BALANCE) FROM ACCOUNTS
ORDER BY BALANCE LIMIT 1));

-- 7. Identify customers who have accounts of multiple types.
-- SELECT 
-- CUSTOMER_ID,
-- CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME),
-- COUNT(A.CUSTOMER_ID)
-- FROM CUSTOMERS C
-- JOIN ACCOUNTS A ON C.CUSTOMER_ID=A.CUSTOMER_ID
-- WHERE 1<(SELECT COUNT(CUSTOMER_ID),CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID);

SELECT CUSTOMER_ID,CONCAT(CONCAT(FIRST_NAME," "),LAST_NAME) NAME
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ACCOUNTS GROUP BY CUSTOMER_ID HAVING COUNT(*)>1);




-- 8. Calculate the percentage of each account type out of the total number of accounts.

-- 9. Retrieve all transactions for a customer with a given customer_id.
SELECT C.CUSTOMER_ID,C.FIRST_NAME,A.ACCOUNT_ID,T.TRANSACTION_ID,T.TRANSACTION_TYPE,T.AMOUNT
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID
WHERE C.CUSTOMER_ID=2;

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.

SELECT SUM(BALANCE),ACCOUNT_TYPE FROM ACCOUNTS GROUP BY ACCOUNT_TYPE;

