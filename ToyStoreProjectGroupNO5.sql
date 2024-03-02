--        ~ SQL definition commands ~

-- 1- CREATING OUR SCHEMA :
CREATE SCHEMA IF NOT EXISTS `ToyStore`;
USE `ToyStore`;
-- 2-Creating tables :

CREATE TABLE branch 
(branch_name        VARCHAR(30) NOT NULL,
 contact_num       INT(10),
 location    VARCHAR(50),
 CONSTRAINT branch__PK PRIMARY KEY (branch_name)
);

CREATE TABLE employee
(Fname        VARCHAR(15),
 Lname        VARCHAR(15),
 EmployeeID   INT(10) NOT NULL,
 position     VARCHAR(30),
 Gender       VARCHAR(6) CHECK (Gender IN ('female' , 'male')),
 branchN       VARCHAR(30) ,
 CONSTRAINT EmployeeID_PK PRIMARY KEY (EmployeeID),
 CONSTRAINT branch_FK FOREIGN KEY (branchN) REFERENCES branch(branch_name)
 ON DELETE CASCADE ON UPDATE CASCADE ,
 INDEX (position) -- add an index on the 'position' column
);


CREATE TABLE employee_salary
(salary     DECIMAL(7,2) CHECK (salary>1000.00),
 position   VARCHAR(30),
  CONSTRAINT position_PK PRIMARY KEY (position),
  CONSTRAINT position_FK FOREIGN KEY (position) REFERENCES employee(position) 
  ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE machine
(MachineID INT(5) NOT NULL,
Type VARCHAR(25),
Machine_status VARCHAR(30),
CONSTRAINT MCHINE_PK PRIMARY KEY (MachineID),
INDEX (type));


CREATE TABLE supervises
(EmpID INT(10) NOT NULL,
MID INT(5) NOT NULL,
CONSTRAINT suoervises_PK PRIMARY KEY (EmpID ,MID),
CONSTRAINT supervises_FK1 FOREIGN KEY (EmpID) REFERENCES employee (EmployeeID) ON DELETE CASCADE,
CONSTRAINT supervises_FK2 FOREIGN KEY (MID) REFERENCES machine (MachineID) ON DELETE CASCADE);


CREATE TABLE toy(
toyID  INT (5) NOT NULL ,
type   VARCHAR(25) NOT NULL,
CONSTRAINT toy_PK1 PRIMARY KEY(toyID),
iNDEX (type)
);


CREATE TABLE toy_price(
type VARCHAR (25) NOT NULL ,
price DECIMAL (5,2) NOT NULL,
CONSTRAINT toy_price_PK1 PRIMARY KEY(type),
CONSTRAINT toy_price_FK1 FOREIGN KEY (type) REFERENCES toy(type)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE produces(
toyID  INT(5)NOT NULL , 
MID    INT(5)NOT NULL , 
production_Date DATE NOT NULL,
CONSTRAINT produces_PK PRIMARY KEY (toyID ,MID),
CONSTRAINT produces_FK1 FOREIGN KEY (toyID) REFERENCES toy(toyID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT produces_FK2 FOREIGN KEY (MID) REFERENCES machine(MachineID)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE customer (
    CustomerID INT(10) NOT NULL,
    Fname VARCHAR(15),
    Lname VARCHAR(15),
    Address VARCHAR(50) NOT NULL,
    CONSTRAINT CUSTOMER_PK PRIMARY KEY (CustomerID)
);


CREATE TABLE Customer_phonenum (
    CustomerID INT(10) NOT NULL,
    Cust_Phonenum INT(10) NOT NULL,
    CONSTRAINT Customer_phonenum_PK PRIMARY KEY (Cust_Phonenum , CustomerID),
    CONSTRAINT Customer_phonenum_FK FOREIGN KEY (CustomerID)
        REFERENCES customer (CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


CREATE TABLE deals_with (
    CustID INT(10) NOT NULL,
    EmpID INT(10) NOT NULL,
    CONSTRAINT deal_with_PK PRIMARY KEY (CustID , EmpID),
    CONSTRAINT deal_with_FK1 FOREIGN KEY (CustID) REFERENCES customer (CustomerID)
 ON UPDATE CASCADE
 ON DELETE CASCADE,
	CONSTRAINT deal_with_FK2 FOREIGN KEY (EmpID) REFERENCES employee (EmployeeID)
 ON UPDATE CASCADE
 ON DELETE CASCADE
        
);


CREATE TABLE `order` (
    Order_ID INT(10) NOT NULL,
    Order_Date DATE NOT NULL,
    Customer_ID INT(10) NOT NULL,
    CONSTRAINT order_PK PRIMARY KEY (Order_ID),
    CONSTRAINT ORDER_FK FOREIGN KEY (Customer_ID) REFERENCES customer (CustomerID) 
ON UPDATE CASCADE
ON DELETE CASCADE
);


CREATE TABLE order_quantity (
    Customer_ID INT(10) NOT NULL,
    order_quantity INT (100) NOT NULL,
    CONSTRAINT order_quantity_PK PRIMARY KEY (Customer_ID),
	CONSTRAINT order_quantity_FK FOREIGN KEY (Customer_ID) REFERENCES `order` (Customer_ID) 
ON UPDATE CASCADE  
ON DELETE CASCADE
);


CREATE TABLE requests (
    toyID INT(5) NOT NULL,
    orderID INT(10) NOT NULL,
    CONSTRAINT requests_PK PRIMARY KEY (toyID, orderID),
    CONSTRAINT requests_FK1 FOREIGN KEY (toyID) REFERENCES toy (toyID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    CONSTRAINT requests_FK2 FOREIGN KEY (orderID) REFERENCES `order` (Order_ID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);




--      ---------------------------------//////////////////////////---------------------------------
--        ~ SQL data manipulation commands ~
-- 3- inserting data:

INSERT INTO branch 
VALUES ('happy world' , 0568901726,'makkah-alzaher'),
('Toy Oasis' , 0238901326,'riyadh-arimal'),
('Toytopia' , 0138931326,'makkah-alzaher'),
('Wonder World' , 0928901326,'madina-albarakah'),
('Playful Pals' , 0498901326,'makkah-alzaher');


INSERT INTO employee
VALUES ('Sara' , 'Albishri', 443000001,'Toy Demonstrator' ,'female' , 'Wonder World'),
 ('Yaser' , 'Alqurashi', 443000002,'Online Sales Specialist' ,'male' , 'Toytopia'),
 ('Mayar' , 'Almoqati', 443000003,'Store Manager' ,'female' , 'Playful Pals'),
 ('Faisal' , 'Alloqmani', 443000004,'Marketing Specialist' ,'male' , 'Toytopia'),
 ('Rawan' , 'Alzahrani', 443000005,'Cashier' ,'female' , 'happy world');
 
 
 INSERT INTO employee_salary
 VALUES (4500.00 ,'Cashier'),
 (80000.00 ,'Marketing Specialist'),
 (10000.00 ,'Store Manager'),
 (7000.00 ,'Online Sales Specialist'),
 (5000.00 ,'Toy Demonstrator');
 
 
INSERT INTO machine 
VALUES
(125,'Injection Molding Machine','Operational'),
(134,'CNC Machine','Under Maintenance'),
(441,'Laser Engraving Machine','Under Maintenance'),
(361,'Extrusion Machine','Operational'),
(111,'CNC Machine','Under Maintenance');


INSERT INTO supervises
VALUES
(443000001,125),
(443000002,111),
(443000003,361),
(443000004,441),
(443000005,134); 


INSERT INTO toy VALUES
(10000,'plastic_doll'),
(11000,'sand_bucket'),
(12345,'lego'),
(54321,'fabric_doll'),
(11123,'rubber_ball');


INSERT INTO toy_price VALUES
('plastic_doll',30.99),
('sand_bucket',15.50),
('lego',35.00),
('fabric_doll',25.99),
('rubber_ball',10.25);


INSERT INTO produces VALUES
(10000,125,'2023-12-1'),
(11000,134,'2023-12-2'),
(12345,441,'2023-11-15'),
(54321,361,'2023-9-5'),
(11123,111,'2023-1-20');


INSERT INTO customer
VALUES
(131, 'Reem', 'Saleh', 'Alaziziah'),
(111, 'Farah', 'Khaled', 'Alawali'),
(224, 'Layla', 'Alhaitham', 'Alshoqiyah'),
(298, 'Mona', 'Ahmed', 'Alsharea'),
(188, 'Amal', 'Hassan', 'Alnaseem');


INSERT INTO Customer_phonenum
VALUES
(131, 0589590032),
(111, 0500211024),
(224, 0505052239),
(298, 0589590032),
(188, 0552002179),
(111, 0589590032);


INSERT INTO deals_with
VALUES (131 ,443000004),
(111 ,443000005),
(224 ,443000004),
(298 ,443000005),
(188 ,443000005);


INSERT INTO `order`
VALUES
(101,'2023-5-10',131),
(503,'2023-4-15',111),
(107,'2023-5-20',224),
(211,'2023-5-25',298),
(119,'2024-5-23',188);


INSERT INTO order_quantity
VALUES
(131,5),
(111,15),
(224,2),
(298,3),
(188,4);


INSERT INTO requests
VALUES
(10000, 101),
(11000, 503),
(12345,107),
(54321, 211),
(11123,119);
    


--      ---------------------------------//////////////////////////---------------------------------
-- 4- update commands:

-- update 1 updating the employees's salary if thier salary less than 5000 adding 2000 to it
UPDATE employee_salary
SET salary = salary +2000
WHERE salary <5000;
select * from employee_salary;

-- update 2 updating the toys's prices if it was equal or less than 20 and equal or less than 30 by multiplying it by 1.5
UPDATE toy_price
SET price = price *1.5
WHERE price <=20 AND price <=30;
select * from toy_price;


-- 5- delete command:

-- delete 1 here in toy table we deleted the row by selecting a specific type ='lego' from 'toy' table
DELETE FROM toy
WHERE type = 'lego';
SELECT * FROM toy;

-- delete 2 here in customer_phonenum table we deleted the rows of customer's phone numbers  by selecting  the ID 
DELETE FROM Customer_phonenum 
WHERE
    CustomerID = 111;
SELECT * FROM customer_phonenum;



--      ---------------------------------//////////////////////////---------------------------------
--      ~ SQL Queries using SELECT command ~


-- 1-  (where 1) here we selected the the IDs of  CNC Machines type
SELECT MachineID AS MachinesIDs_of_CNCType
FROM machine 
WHERE Type ='CNC Machine';


-- 2-  (where 2) here we selected the names of the branches that its location in 'makkah-alzaher'  
SELECT branch_name
FROM branch
WHERE
    location = 'makkah-alzaher';

-- 3-  (where 3) we selected the machineID in machine table to fine the IDs of machine with Operational status
select  MachineID AS OperationalMachines
FROM machine
WHERE Machine_status = 'Operational';

-- 4- (group by 1) we use the'Group by' to group the toy_price table by type and use the MAX function 
-- to find the maximum price of toys in each type
SELECT type AS Toy_Type, MAX(price) as max_price
FROM toy_price
GROUP BY type;


-- 5- (group by 2) here we used 'Group by' command to show the number of female employees
SELECT COUNT(Gender) AS number_of_female_employees
FROM employee
WHERE Gender IN ('female')
GROUP BY Gender;


-- 6- (having 1) Show the sum of order quantity for each customer but only if the sum value is greater than 2
SELECT Customer_ID, SUM(order_quantity) as total_quantity
FROM order_quantity
GROUP BY Customer_ID
HAVING SUM(order_quantity) > 2;

-- 7- having we retrieve the number of employees from 'employee' table in each position using the COUNT() function
SELECT employee.position, COUNT(*) as num_employees
FROM employee
GROUP BY employee.position
HAVING COUNT(*) >= 1;

-- 8- (order by 1) here We arranged the requests details(orderID and toyID) in descending order by toyID
SELECT *
FROM toystore.requests
order by toyID DESC;


-- 9- (order by 2) here We arranged the produces table in ascending order by production _Date
SELECT *
FROM toystore.produces
ORDER BY production_Date;


-- 10- (subquery) find the customers who made orders for toys produced by machines under maintenance:
SELECT *
FROM customer
WHERE CustomerID IN (
    SELECT Customer_ID
    FROM `order`
    WHERE Order_ID IN (
        SELECT orderID
        FROM requests
        WHERE toyID IN (
            SELECT toyID
            FROM produces
            WHERE MID IN (
                SELECT MachineID
                FROM machine
                WHERE Machine_status = 'Under Maintenance')
        )
    )
);


-- 11- (join) retrieve information about orders,  and customers who bought it with the type and its price
SELECT o.Order_ID, CONCAT( c.Fname, " ",c.Lname) AS CustomerName,
       t.type AS ToyType, tp.price AS ToyPrice, od.order_quantity AS Quantity
FROM `order` o
JOIN customer c ON o.Customer_ID = c.CustomerID
JOIN requests r ON o.Order_ID = r.orderID
JOIN toy t ON r.toyID = t.toyID
JOIN toy_price tp ON t.type = tp.type
JOIN order_quantity od ON o.Customer_ID = od.Customer_ID;


