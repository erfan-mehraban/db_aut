#1
SELECT department.addr from department,bank WHERE bank.name="mellat" AND bank.id=department.bank_id

#2
SELECT cu.name, cu.addr, cu.pn FROM customer cu, account ac WHERE ac.balance>1000000 AND ac.customer_id=cu.id

#3
SELECT loan.amount, customer.name FROM customer, loan WHERE customer.id=loan.customer_id ORDER BY loan.amount DESC LIMIT 1

#4
SELECT SUM(account.balance) FROM account, department, bank WHERE bank.name="refah" and bank.id=department.bank_id and account.department_id=department.id

#5
SELECT SUM(account.balance) FROM account, customer WHERE account.customer_id=customer.id AND customer.name="irani"

#6
SELECT department.addr, COUNT(customer.id) FROM department, bank, customer, account WHERE bank.name="keshavarzi" AND customer.id=account.customer_id AND account.department_id=department.id AND department.bank_id=bank.id GROUP BY department.id

#7
SELECT DISTINCT loan.type FROM loan, bank, department WHERE bank.id=department.bank_id AND bank.name="maskan" AND loan.department_id=department.id

#8
SELECT COUNT(department.id) FROM bank, department WHERE bank.id = department.bank_id AND bank.name="ayande"

#9
SELECT customer.addr FROM bank, department, account, customer WHERE customer.id=account.customer_id AND account.department_id=department.id AND department.bank_id=bank.id AND bank.name="sepah" LIMIT 1