CREATE DATABASE online_Bookstore;
USE online_Bookstore;

CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(100),
Publish_year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE TABLE customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(100),
City VARCHAR(100),
Country VARCHAR(100)
);

CREATE TABLE orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT,
Book_ID INT,
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

DROP TABLE orders;

-- DIRECT IMPORT CSV FILE
SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM orders;

-- Q1: RETRIVE ALL BOOKS IN THE "FICTION" GENRE.
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- Q2: FIND BOOKS PUBLISHED AFTER THE YEAR 1950.
   SELECT * FROM Books 
   WHERE Published_year>1950;

-- Q3: LIST ALL CUSTOMERS FROM THE 'CANADA'.
 SELECT * FROM customers
 WHERE country='Canada';
 
 -- Q4: SHOW ORDERS PLACED IN NOVEMBER 2023.
 SELECT * FROM orders 
 WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';
 
 -- Q5: RETRIEVE THE TOTAL STOKE OF BOOKS AAVAILABLE
 SELECT SUM(stock) AS Total_Stoke
 FROM Books;
 
 -- Q6: FIND THE DETAILS OF THE MOST EXPENSIVE BOOK.
 SELECT * FROM Books
 ORDER BY Price DESC LIMIT 1;
 
 -- Q7: SHOW ALL CUSTOMERS WHO ORESED MORE THEN 1 QUANTITY OF A BOOK;
 SELECT * FROM orders
 WHERE quantity>1;
 
 -- Q8: RETRIEVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20.
 SELECT * FROM orders 
 WHERE Total_amount>20;
 
 -- Q9: LIST ALL GENERES AVAILABLE IN THE BOOKS TABLE:
 SELECT DISTINCT Genre FROM Books;
 
 -- Q10: FIND THE BOOK WITH THE LOWEST STOKES:
 SELECT * FROM Books ORDER BY stock LIMIT 1;
 
 -- Q11: CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS:
 SELECT  SUM(Total_Amount) AS Revenue FROM orders; 
 
       -- ADVANCE QUESTION--
 
 -- Q1: RETRIVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACHGENRE:
 SELECT b.Genre,SUM(o.quantity) AS Total_Books_Sold
 FROM  Orders o
 JOIN Books b ON o.book_ID = b.book_ID
 GROUP BY b.Genre;
 
 -- Q2: FIND THE AVERAGE PRICE OF BOOKS IN THE "FANTASY" GNERE:
 
 SELECT  AVG(Price) AS AVG_Price
 from books
 WHERE Genre= 'Fantasy';
 
 -- Q3: LIST CUSTOMER WHO HAVE PLACED AT LEASTE 2 ORDERS ;
 
 SELECT o.customer_ID ,c.Name,COUNT(o.Order_ID) AS Order_count
 FROM orders o 
 JOIN customers c ON o.customer_ID =c.customer_ID
 group by o.customer_ID,c.Name
 HAVING COUNT(Order_ID)>=2;
 
 -- Q4: FIND THE MOST FREQUENTLY ORDERED BOOK;
 
 SELECT o.Book_ID,b.Title,COUNT(o.Order_ID) AS ORDER_COUNT
 FROM orders o 
 JOIN books b ON o.book_ID= b.book_ID
 GROUP BY o.Book_ID,b.title
 ORDER BY ORDER_COUNT DESC LIMIT 1;

-- Q5: SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANTASY GENRE':
SELECT * FROM BOOKS
WHERE genre= 'Fantasy'
ORDER BY price DESC LIMIT 3;

-- Q6: RETRIVE THE TOTALE QUANTITY OF BOOK SOLD BY EACH AUTHER:

SELECT b.author,SUM(o.quantity) AS Total_Books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.Author;

-- Q7: LIST THE CITIES WHERE CUSTOMERS WHO SPENT $30 ARE LOCATED:

SELECT DISTINCT c.city,total_amount
FROM orders o
JOIN customers c ON o.customer_id= c.customer_id
WHERE o.total_amount>30;

-- Q8: FIND THE CUSTOMER WHO SPENT THE MOST ON ORDERS:
SELECT c.Customer_ID, c.name, sum(o.total_amount) AS Total_spent
from orders o
JOIN customers c ON O.customer_id= c.customer_id
GROUP BY C.Customer_ID,c.name
order by Total_spent desc limit 1;

-- Q9: CALCULATE THE STOKE REMAINNING AFTER FULFILLING ALL ORDERS:
SELECT b.Book_ID,b.Title ,b.stock,COALESCE(SUM(o.quantity),0) AS Order_Quantity,
b.stock- COALESCE(SUM(o.quantity),0) AS Remainning_Quantity
FROM books b
LEFT JOIN orders o ON b.Book_ID=o.Book_ID
GROUP BY b.Book_ID ORDER BY b.Book_ID;
 
SELECT b.Book_ID,b.Title,b.stock,
    COALESCE(SUM(o.quantity), 0) AS Order_Quantity,
    b.stock - COALESCE(SUM(o.quantity), 0) AS Remainning_Quantity
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.stock;

     -- THANK YOU ---










