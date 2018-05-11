#zahra mohammadi 9413031
#HW2_1
############################################################################
# اسامی تمامی مشتریان (customers) اهل کانادا و تعداد سفارش‌های هر کدام از آن‌ها

SELECT
  customerName,
  count(*)
FROM (Customers
  JOIN Orders ON Orders.customerNumber = Customers.customerNumber)
WHERE country = "canada"
GROUP BY customerName;

############################################################################

#ایمیل و عنوان شغلی تمامی کارمندانی که نماینده فروش (sales representative) به حداقل 10 مشتری بوده‌اند؛ به نحوی که هر کدام از آن مشتریان، محصولی به نام Ray-Ban Clubmaster eyeglasses را خریداری کرده‌اند.

SELECT
  jobTitle,
  email
FROM Customers, Employees, Orders, OrderDetails, Products
WHERE salesRepEmployeeNumber = employeeNumber AND
      Orders.customerNumber = Customers.customerNumber AND
      Orders.orderNumber = OrderDetails.orderNumber AND
      Products.productCode = OrderDetails.productCode AND
      productName = "Ray-Ban Clubmaster eyeglasses"
GROUP BY employeeNumber
HAVING count(*) > 10;

############################################################################

#رتبه‌بندی مشتریانی که یکی از محصولات خط تولید pepsi را خریداری کرده‌اند. (بر اساس میزان پرداخت‌ها)

SELECT
  Customers.customerNumber,
  customerName,
  contactLastName,
  contactFirstName,
  phone,
  addressLine1,
  addressLine2,
  city,
  state,
  postalCode,
  country,
  salesRepEmployeeNumber,
  creditLimit,
  sum(amount)
FROM (Customers
  JOIN Payments ON Payments.customerNumber = Customers.customerNumber)
WHERE Customers.customerNumber IN
      (
        SELECT customerNumber
        FROM Orders
        WHERE orderNumber IN
              (
                SELECT orderNumber
                FROM OrderDetails
                WHERE productCode IN
                      (
                        SELECT productCode
                        FROM Products
                        WHERE productLine = "pepsi"
                      )
              )
      )
GROUP BY Customers.customerNumber
ORDER BY sum(amount);

############################################################################

#خط تولیدی که مشتریان ایرانی آن، سفارش‌هایی را به ارزش 100 دلار، از دفتری واقع در شهر فرانکفورت خریداری کرده‌اند.

SELECT productLine
FROM Products
WHERE productCode IN
      (
        SELECT productCode
        FROM OrderDetails
        WHERE priceEach * quantityOrdered = 100 AND orderNumber IN
                                                    (
                                                      SELECT orderNumber
                                                      FROM Orders
                                                      WHERE customerNumber IN
                                                            (
                                                              SELECT customerNumber
                                                              FROM Customers, Employees, Offices
                                                              WHERE salesRepEmployeeNumber = employeeNumber AND
                                                                    Employees.officeCode = Offices.officeCode AND
                                                                    Customers.country = "iran" AND
                                                                    Offices.city = "ferankfort"

                                                            )
                                                    )
      );

############################################################################

#مشتریان اهل نیویورک که سفارش‌هایشان در تاریخ 2018-02-10 ارسال شده است را در نظر بگیرید. مجموع پرداخت‌های این مشتریان در تاریخ 2018-03-12 را به تفکیک برای هر مشتری حساب کنید. (توجه: به تاریخی که یک سفارش ارسال شده است، shipping date می‌گویند).

SELECT sum(amount)
FROM Payments
WHERE paymentDate = "2018-03-12" AND customerNumber IN
                                     (SELECT Customers.customerNumber
                                      FROM (Customers
                                        JOIN Orders ON Orders.customerNumber = Customers.customerNumber)
                                      WHERE state = "New York" AND shippedDate = "2018-02-10")
GROUP BY customerNumber;

############################################################################

#پرداختی به مبلغ 200 دلار در تاریخ 2018-04-22 توسط یک مشتری با شناسه 52 انجام شده است. مقدار فیلد checkNumber را برابر "530-3567" در نظر بگیرید. اطلاعات مربوط به این پرداخت را در جدول مربوطه اضافه نمایید.

INSERT INTO Payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (52, "530-3567", '2018-04-22 00:00:00', 200);

############################################################################

# مشتری‌ای با شناسه 67، در ابتدا قصد خرید 1 عدد از محصولی با کد DKC-1532 از خط تولید 3 را داشت. اطلاعات مربوط به خرید او در پایگاه داده ثبت شد. اما ناگهان تصمیم گرفت 1 عدد دیگر آن محصول را نیز خریداری کند. کوئری‌ای بنویسید که اطلاعات سفارش او را بروزرسانی نماید.

UPDATE OrderDetails
SET quantityOrdered = quantityOrdered + 1
WHERE orderNumber IN
      (
        SELECT orderNumber
        FROM Orders
        WHERE customerNumber = 67
      ) AND productCode IN
            (
              SELECT productCode
              FROM Products
              WHERE productCode = "DKC-1532" AND productLine = 3
            );