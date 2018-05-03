#1
select
    c.customerName,
    count(*)
from
    Customers c,
    Orders o
where
    c.country = 'Canada'
    and o.customerNumber = c.customerNumber
group by
    c.customerNumber;

#2
select
    e.email,
    e.jobTitle
from
    Employees e,
    Customers c,
    Orders o,
    OrderDetails od,
    Products p
where
    p.productCode = od.productCode
    and o.orderNumber = od.orderNumber
    and o.customerNumber = c.customerNumber
    and c.salesRepEmployeeNumber = e.employeeNumber
    and p.productName = "Ray-Ban Clubmaster eyeglasses" -- "1992 Ferrari 360 Spider red"
group by
    e.employeeNumber
having
    count(*) > 10;
#3
create view pepsi_cust(cn) as (
    select
        distinct c.customerNumber
    from
        Customers c,
        Products p,
        Orders o,
        OrderDetails od
    where
        p.productCode = od.productCode
        and o.orderNumber = od.orderNumber
        and o.customerNumber = c.customerNumber
        and p.productLine = "pepsi" -- Classic Cars
);
create view cus_am as(
    select
        c.customerName as name,
        sum(p.amount) as amount
    from
        Customers c,
        Payments p
    where
        c.customerNumber in (
            select
                *
            from
                pepsi_cust
        )
        and p.customerNumber = c.customerNumber
    group by
        c.customerNumber
);
select
    c1.name,
    count(c1.amount)
from
    cus_am c1
    left join cus_am c2 on c1.amount <= c2.amount
group by
    c1.name
order by
    count(c1.amount)‌;

#4
select
    p.productLine
from
    Offices of,
    Employees e,
    Customers c,
    Orders o,
    OrderDetails od,
    Products p
where
    of.officeCode = e.officeCode
    and e.employeeNumber = c.salesRepEmployeeNumber
    and o.customerNumber = c.customerNumber
    and o.orderNumber = od.orderNumber
    and od.productCode = p.productCode
    and od.priceEach = 100
    and c.country = "Iran"
    and Offices.city = "Frankfurt";

#5
select
    c.customerNumber,
    sum(p.amount)
from
    Customers c,
    Orders o,
    Payments p
where
    DATE(o.shippedDate) = "2018-02-10"
    and c.city = "NYC"
    and o.customerNumber = c.customerNumber
    and c.customerNumber = p.customerNumber
    and DATE(p.paymentDate = "2018-03-12")
group by
    c.customerNumber;

#6
INSERT INTO
    Payments (amount, checkNumber, customerNumber, paymentDate)
VALUES
    (
        '200',
        '530-3567',
        52,
        '2018-04-22'
    );

#7
UPDATE
    OrderDetails ods
SET
    ods.quantityOrdered = 2
WHERE
    ods.orderNumber in (
        select od.orderNumber
        from Customers c, (select * from OrderDetails) od, Orders o
        where
            c.customerNumber = o.customerNumber
            and o.orderNumber = od.orderNumber
            and od.quantityOrdered = 1
            and c.customerNumber = 67
            and od.orderLineNumber = 3
            and od.productCode = "DKC-1532"
    )