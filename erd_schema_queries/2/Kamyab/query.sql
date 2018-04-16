# 1
SELECT branches.branch_address FROM branches,banks WHERE banks.bank_name="Mellat" AND banks.bank_id= branches.bank_id;

# 2
SELECT customers.cname, customers.caddress, customers.cphone FROM customers, accounts WHERE customers.cid = accounts.cid AND accounts.abalance > 1000000;

# 3
SELECT loans.lamount, customers.cname FROM customers,loans WHERE customers.cid = loans.cid ORDER BY loans.lamount DESC LIMIT 1;

# 4
SELECT SUM(accounts.abalance) AS SUM FROM accounts,banks, branches WHERE accounts.branch_id = branches.branch_id AND branches.bank_id = banks.bank_id AND banks.bank_name = "Refah";

# 5
SELECT accounts.abalance FROM accounts,customers WHERE accounts.cid = customers.cid AND customers.cname="Irani";

# 6
SELECT branches.branch_address, COUNT(customers.cid) FROM branches, banks, customers, accounts WHERE banks.bank_name="Keshavarzi" AND
                                                                                                     customers.cid=accounts.cid AND
                                                                                                     accounts.branch_id=branches.branch_id AND
                                                                                                     branches.bank_id=banks.bank_id GROUP BY branches.branch_id;

# 7
SELECT DISTINCT loans.ltype FROM loans,branches,banks WHERE loans.branch_id = branches.branch_id AND branches.bank_id = banks.bank_id AND bank_name="Maskan";

# 8
SELECT COUNT(branch_id) AS COUNT FROM branches,banks WHERE branches.bank_id = banks.bank_id AND banks.bank_name="Ayandeh";

# 9
SELECT customers.caddress FROM customers,branches,banks,accounts WHERE branches.bank_id = banks.bank_id
        AND banks.bank_name = "Sepah" AND accounts.branch_id = branches.branch_id AND customers.cid = accounts.cid ORDER BY accounts.aid DESC LIMIT 1;