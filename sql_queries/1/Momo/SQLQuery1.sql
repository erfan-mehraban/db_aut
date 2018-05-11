#A
#1
select
customers.customerName, count(orders.orderNumber)
from
Customers customers, Orders orders
where
customers.country = 'Canada'
and
orders.customerNumber = customers.customerNumber
group by
customers.customerName;

#2
select
    Employees.email,
    Employees.jobTitle
from
    Employees,
    Customers,
    Orders,
    OrderDetails,
    Products
where
    Products.productCode = OrderDetails.productCode
    and OrderDetails.orderNumber = Orders.orderNumber
    and Orders.customerNumber = Customers.customerNumber
    and Customers.salesRepEmployeeNumber = Employees.employeeNumber
    and Products.productName = 'Ray-Ban Clubmaster eyeglasses'
group by
    Employees.employeeNumber
having
    count(Customers.customerNumber) > 10;

#3
create view pepsibuyers as
select c.customernumber
from
		Customers c,
        Products p,
        Orders o,
        OrderDetails odetails
where
        c.customerNumber = o.customerNumber
		and o.orderNumber = odetails.orderNumber
		and odetails.productCode = p.productCode
        and p.productLine = 'Pepsi'
;
create view customersgrade as
select customerNumber, sum(amount) as amount
        from
		Payments
		group by
		customerNumber
		order by amount desc
;
select  customersgrade.customerNumber, customersgrade.amount
from
		customersgrade,
		pepsibuyers
where
		customersgrade.customerNumber=pepsibuyers.customernumber
group by
		customersgrade.customerNumber
		order by customersgrade.amount desc;

#4
select
    products.productLine
from
    Customers customers,
	Employees employees,
    Offices offices,
	OrderDetails orderdetails,
    Orders orders,
    Products products
where
	customers.salesRepEmployeeNumber = employees.employeeNumber
	and employees.officeCode = offices.officeCode
	and offices.city = 'Frankfurt'
    and orderdetails.orderNumber = orders.orderNumber
	and orders.customerNumber = customers.customerNumber
	and customers.country = 'Iran'
    and orderdetails.productCode = products.productCode
    and orderdetails.priceEach = 100;

#5
select
   distinct customers.customerNumber,
    sum(payments.amount) as  total_paid
from
    Customers customers,
    Orders orders,
    Payments payments
where
    orders.shippedDate = '2018-02-10 00:00:00'
    and orders.customerNumber = customers.customerNumber
	and customers.city = 'New York'
    and customers.customerNumber = payments.customerNumber
    and payments.paymentDate = '2019-03-12 00:00:00'
group by
    customers.customerNumber;
    
#B
#1
insert into Payments values ('52','530-3567','2018-04-22 00:00:00','200');

#2
update
    OrderDetails
set
    orderdetails.quantityOrdered = 2
where
    orderdetails.orderNumber in (
        select orderdetails.orderNumber
        from
		Customers customers,
		Orders orders,
		OrderDetails orderdetails

        where
			customers.customerNumber = 67
            and customers.customerNumber = orders.customerNumber
            and orders.orderNumber = orderdetails.orderNumber
            and orderdetails.quantityOrdered = 1
            and orderdetails.orderLineNumber = 3
            and orderdetails.productCode = 'DKC-1532'
    )