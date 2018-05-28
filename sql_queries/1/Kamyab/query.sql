# 1
SELECT customerName, COUNT(*)
  FROM (Customers JOIN Orders ON Customers.customerNumber = Orders.customerNumber)
  WHERE country="Canada"
  GROUP BY Customers.customerNumber;

# 2
SELECT Employees.email, Employees.jobTitle, COUNT(*)
FROM Customers
  JOIN Employees
    ON Customers.salesRepEmployeeNumber = Employees.employeeNumber
  WHERE Customers.customerNumber IN ( SELECT Customers.customerNumber
                                        FROM Customers
                                          JOIN Orders
                                            ON Customers.customerNumber = Orders.customerNumber
                                          JOIN OrderDetails
                                            ON Orders.orderNumber = OrderDetails.orderNumber
                                          Join Products
                                            On OrderDetails.productCode = Products.productCode
                                          WHERE Products.productName="Ray-Ban Clubmaster eyeglasses")
    GROUP BY Employees.employeeNumber
    HAVING COUNT(*)>=10;

# 3
SELECT Customers.customerName, SUM(Payments.amount) AS sum , RANK() OVER (ORDER BY SUM(Payments.amount) DESC) AS c_rank
FROM Customers
  JOIN Payments
    ON Customers.customerNumber = Payments.customerNumber
  WHERE Customers.customerNumber IN(
                                      SELECT Customers.customerNumber
                                      FROM Customers
                                        JOIN Orders
                                          ON Customers.customerNumber = Orders.customerNumber
                                        JOIN OrderDetails
                                          ON Orders.orderNumber = OrderDetails.orderNumber
                                        Join Products
                                          On OrderDetails.productCode = Products.productCode
                                        WHERE Products.productLine="Pepsi")
  GROUP BY Customers.customerNumber;

# 4
SELECT Products.productLine
FROM Customers
  JOIN Orders
    ON Customers.customerNumber = Orders.customerNumber
  JOIN OrderDetails
    ON Orders.orderNumber = OrderDetails.orderNumber
  Join Products
    On OrderDetails.productCode = Products.productCode
  JOIN Employees
    ON Customers.salesRepEmployeeNumber = Employees.employeeNumber
  JOIN Offices
    ON Employees.officeCode = Offices.officeCode
  JOIN Payments
    ON Customers.customerNumber = Payments.customerNumber
  WHERE Customers.country = "Iran"
    AND Payments.amount = 100
    AND Offices.city = "Frankfurt";

# 5
SELECT Customers.customerName, SUM(Payments.amount) AS p_sum
FROM Customers
  JOIN Payments
    ON Customers.customerNumber = Payments.customerNumber
  JOIN Orders
    ON Customers.customerNumber = Orders.customerNumber
WHERE Customers.city = "NYC"
  AND Orders.shippedDate = "2018-02-10"
  AND Payments.paymentDate = "2018-03-12"
GROUP BY Customers.customerNumber;

# 6
INSERT INTO `Payments` (`customerNumber`, `checkNumber`, `paymentDate`, `amount`) VALUES (52, '530-3567', '2018-04-22 00:00:00', 200);

# 7
UPDATE OrderDetails
  SET quantityOrdered = 2
WHERE orderLineNumber = 3 AND orderNumber IN (SELECT orderNumber FROM Orders WHERE customerNumber = 67) AND productCode = "DKC-1532";