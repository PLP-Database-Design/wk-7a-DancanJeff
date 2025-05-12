-- Question 1: Transform ProductDetail table into 1NF

-- First, create the original table with the unnormalized data
create table ProductDetail (
OrderID int not null primary key ,
CustomerName varchar(255) not null,
Products varchar(255) not null );

insert into ProductDetail values 
(101, 'John Doe', 'laptop, Mouse' ),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

select * from ProductDetail;;

-- Create a new table in 1NF
create table ProductDetail_1NF (
OrderId int not null ,
CustomerName varchar(255) not null,
product varchar(255) not null ,
primary key(product , orderId)
);

 insert into productdetail_1NF values
 (101, 'John Doe', 'laptop'),
 (101, 'John Doe', 'Mouse'),
 (102, 'Jane Smith', 'Tablet'),
 (102, 'Jane Smith', 'Keyboard'),
 (102, 'Jane Smith', 'Mouse'),
 (103, 'Emily Clark', 'Phone');


-- Query to view the normalized data
  select * from productdetail_1NF



-- Question 2: Transform OrderDetails table into 2NF

-- First, create the original OrderDetails table (1NF)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert sample data
INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Create 2NF tables by separating the tables based on dependencies

-- Table 1: Orders (Contains customer information)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

-- Table 2: OrderProducts (Contains product details for each order)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the normalized tables
INSERT INTO Orders
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderProducts
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Query to view the normalized data
SELECT o.OrderID, o.CustomerName, op.Product, op.Quantity
FROM Orders o
JOIN OrderProducts op ON o.OrderID = op.OrderID
ORDER BY o.OrderID;
