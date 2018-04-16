CREATE TABLE accounts
(
  aid       INT AUTO_INCREMENT
    PRIMARY KEY,
  atype     VARCHAR(30) NULL,
  abalance  INT         NULL,
  cid       INT         NULL,
  branch_id INT         NULL
)
  ENGINE = InnoDB;

CREATE INDEX accounts_customers_cid_fk
  ON accounts (cid);

CREATE INDEX accounts_branches_branch_id_fk
  ON accounts (branch_id);

CREATE TABLE banks
(
  bank_id      INT AUTO_INCREMENT
    PRIMARY KEY,
  bank_name    VARCHAR(30) NULL,
  bank_address VARCHAR(90) NULL
)
  ENGINE = InnoDB;

CREATE TABLE branches
(
  branch_id      INT AUTO_INCREMENT
    PRIMARY KEY,
  branch_address VARCHAR(90) NULL,
  bank_id        INT         NULL,
  CONSTRAINT branches_banks_bank_id_fk
  FOREIGN KEY (bank_id) REFERENCES banks (bank_id)
)
  ENGINE = InnoDB;

CREATE INDEX branches_banks_bank_id_fk
  ON branches (bank_id);

ALTER TABLE accounts
  ADD CONSTRAINT accounts_branches_branch_id_fk
FOREIGN KEY (branch_id) REFERENCES branches (branch_id);

CREATE TABLE customers
(
  cid      INT AUTO_INCREMENT
    PRIMARY KEY,
  cname    VARCHAR(30) NULL,
  cphone   VARCHAR(30) NULL,
  caddress VARCHAR(90) NULL
)
  ENGINE = InnoDB;

ALTER TABLE accounts
  ADD CONSTRAINT accounts_customers_cid_fk
FOREIGN KEY (cid) REFERENCES customers (cid);

CREATE TABLE loans
(
  lid       INT AUTO_INCREMENT
    PRIMARY KEY,
  ltype     VARCHAR(30) NULL,
  lamount   INT         NULL,
  cid       INT         NULL,
  branch_id INT         NULL,
  CONSTRAINT loans_customers_cid_fk
  FOREIGN KEY (cid) REFERENCES customers (cid),
  CONSTRAINT loans_branches_branch_id_fk
  FOREIGN KEY (branch_id) REFERENCES branches (branch_id)
)
  ENGINE = InnoDB;

CREATE INDEX loans_customers_cid_fk
  ON loans (cid);

CREATE INDEX loans_branches_branch_id_fk
  ON loans (branch_id);

