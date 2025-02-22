USE classicmodels;
select  * from products;
select  * from productlines;
select  * from orderdetails;
select * from payments;
select * from customers;
select * from orders;

-- nomor 1
SELECT products.productName, products.productcode, orders.orderDate From products
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode 
INNER JOIN orders
on  orderdetails.orderNumber = orders.orderNumber
WHERE products.productCode = "S18_1097" order by orders.orderDate desc;

-- nomor 2
SELECT products.productName, products.productcode, orderdetails.priceEach, 80/100*Products.MSRP From products
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode 
WHERE orderdetails.priceEach < 80/100*(Products.MSRP);

-- nomor 3
USE appseminar;

-- SELECT * from ss_mahasiswa;
-- SELECT * FROM ss_pembimbing;
-- SELECT * FROM ss_dosen;
-- 
SELECT ss_mahasiswa.Nama, ss_mahasiswa.id_mahasiswa , ss_pembimbing.id_pembimbing_utama, ss_dosen.nama From ss_mahasiswa
INNER JOIN ss_pembimbing
ON ss_mahasiswa.id_mahasiswa = ss_pembimbing.id_mahasiswa
INNER JOIN ss_dosen
ON ss_pembimbing.id_pembimbing_utama = ss_dosen.id_dosen
WHERE ss_mahasiswa.id_mahasiswa = '288';

-- nomor 4
USE classicmodels;
ALTER TABLE customers
ADD COLUMN `Status` varchar(10);

update customers
INNER JOIN payments
ON customers.customerNumber = payments.customerNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
Set customers.Status = 'VIP'
WHERE payments.amount >= 100000 or orderdetails.quantityOrdered >= 50;

SELECT customers.customerName, payments.amount, orderdetails.quantityOrdered, customers.status FROM customers
INNER JOIN payments
ON customers.customerNumber = payments.customerNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
WHERE payments.amount > 100000 or orderdetails.quantityOrdered >= 50;


Update customers
SET customers.Status = 'Regular'
WHERE customers.Status is NULL;
SELECT * FROM customers;

-- nomor 5
SELECT * FROM orderdetails;
ALTER TABLE orderdetails
DROP CONSTRAINT orderdetails_ibfk_1;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY(OrderNumber) REFERENCES orders(orderNumber)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders
DROP CONSTRAINT orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1 FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE payments
DROP CONSTRAINT payments_ibfk_1;

ALTER TABLE Payments
ADD CONSTRAINT payments_ibfk_1 FOREIGN KEY(customerNumber) REFERENCES customers(customerNumber)
ON DELETE CASCADE ON UPDATE CASCADE;

DELETE customers,orders,orderdetails
FROM customers
INNER JOIN Orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN Orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN payments
ON customers.customerNumber = payments.customerNumber
WHERE orders.status = 'Cancelled';
