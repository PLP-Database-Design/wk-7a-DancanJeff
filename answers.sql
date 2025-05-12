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
create table OrderDetails (
OrderID  int  ,
CustomerName varchar(255) ,
Product varchar(255) ,
Quantity int );

insert into OrderDetails values 
(101, 'John Doe', 'laptop', 2),
 (101, 'John Doe', 'Mouse', 1),
 (102, 'Jane Smith', 'Tablet', 3),
 (102, 'Jane Smith', 'Keyboard', 1),
 (102, 'Jane Smith', 'Mouse',2),
 (103, 'Emily Clark', 'Phone', 1);
 
 select * from orderdetails
 
 -- Create 2NF tables by separating the tables based on dependencies

 create table Orders (
 OrderId int primary key,
 CustomerName varchar(255) not null );
 
-- Insert data into the normalized tables
 insert into Orders
 select distinct OrderID, CustomerName 
 from orderdetails;
 
 select * from orders;
 
 -- Table 2: OrderProducts (Contains product details for each order)
 create table OrderProduct (
 OrderID int ,
 Product varchar(255),
 Quantity int ,
 primary key (OrderID, Product),
foreign key (OrderID) references orders(OrderID)
  );
  
-- Insert data into the normalized tables
  insert into orderproduct
  select OrderID,Product, quantity
  from orderDetails;
  
  select * from orderproduct
  
  -- Query to view the normalized data
  select CustomerName,Product, Quantity
  from OrderProduct op
  join  orders o
  on op.orderid=o.orderid;
  



