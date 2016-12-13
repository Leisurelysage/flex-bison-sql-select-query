SELECT CustomerName,City FROM Customers;
SELECT CustomerName,City FROM Customers WHERE customer_id=1 and City='Kazan';
SELECT CustomerName,City FROM Customers WHERE customer_id=1 and City='Kazan' or customer_id=2;

SELECT * FROM table_name;

select %$ from ^12 table_name ~;
