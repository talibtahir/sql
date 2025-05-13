create table Categories (CategoryID number(6), CategoryName varchar2(30), Description varchar2(100), Picture varchar2(30));

create table Suppliers (SupplierID number(6), CompanyName varchar2(100), ContactName varchar2(30), 
ContactTitle  varchar2(30), Address varchar2(100), city varchar(30), Region varchar2(30), Postalcode varchar2(30),
Country varchar2(30), Phone varchar2(12), Fax varchar2(100), HomePage varchar2(100));

create table Products (ProductID number(6), ProductName varchar2(100), SupplierID number(6), CategoryID number(6),
QuantityPerUnit varchar2(30), UnitPrice number(20,2), UnitsInStock number(6), UnitsOnOrder number(6), ReorderLevel number(6),
Discontinued number(6));

create table OrderDetails (OrderID number(6), ProductID number(6), UnitPrice number(20,2), Quantity number(6), Discount varchar2(100));

create table Orders (OrderID number(6), CustomerID varchar2(30), EmployeeID number(6), OrderDate date, RequiredDate date, ShippedDate date,
ShipVia number(6), Freight number(6,2), ShipName varchar2(100), ShipAddress varchar2(100), ShipCity varchar2(30), ShipRegion varchar2(30), 
ShipPostalCode varchar2(30), ShipCountry varchar2(30));

create table Customers (CustomerID varchar2(30), CompanyName varchar2(60), ContactName varchar2(30), ContactTitle varchar2(30), Address varchar2(100),
City varchar2(30), Region varchar2(30), PostalCode varchar2(30), Country varchar2(30), Phone varchar2(30), Fax varchar2(30));

create table shippers (ShipperID number(30), CompanyName varchar2(30) , Phone number(11));

create table region (RegionID number(6) , RegionDescription varchar2(30));

create table Territories (TerritoryID varchar2(100), TerritoryDescription varchar2(100), RegionID number(6));

create table  EmployeeTerritories (EmployeeID number(6), TerritoryID number(10));

create table Employees1 (EmployeeID number(6), LastName varchar2(30), FirstName varchar2(30), Title varchar2(30), TitleOfCourtesy varchar2(30),
BirthDate date, HireDate date, Address varchar2(30), City varchar2(30), Region varchar2(30), PostalCode varchar2(30), Country varchar2(30),
HomePhone varchar2(30), Extension number(6), Photo varchar2(30), Notes varchar2(4000), ReportsTo varchar2(30), PhotoPath varchar2(30));

--Add primary keys using constraint

alter table Categories add constraint pk_c_id primary key (categoryID);

alter table Suppliers add CONSTRAINT pk_s_id primary key (SupplierID);

alter table Products add CONSTRAINT pk_p_id primary key (ProductID);

alter table OrderDetails add CONSTRAINT pk_op_id primary key (orderID, productID);

alter table Orders add CONSTRAINT pk_o_id primary key (orderID);

alter table Customers add CONSTRAINT pk_cu_id primary key (customerID);

alter table shippers add CONSTRAINT pk_sh_id primary key (shipperID);

alter table region add CONSTRAINT pk_re_id1 primary key (regionID);

alter table Territories add CONSTRAINT pk_t_id primary key (territoryID);

alter table EmployeeTerritories add CONSTRAINT pk_et_id primary key (EmployeeID, TErritoryID);

alter table Employees1 add CONSTRAINT pk_e_id primary key (EmployeeID);
alter table employees1 drop CONSTRAINT pk_e_id;

--Add constraint foreign key

alter table Products add CONSTRAINT fk__ps foreign key (supplierID) REFERENCES Suppliers (supplierID);

alter table products add CONSTRAINT fk_pc FOREIGN key (categoryID) REFERENCES Categories (categoryID);

alter table orderdetails add CONSTRAINT fk_op FOREIGN key (productid) REFERENCES products (productid);

alter table orderdetails add CONSTRAINT fk_oo FOREIGN key (orderid) REFERENCES orders (orderid);

alter table orders add CONSTRAINT fk_oc FOREIGN key (customerid) REFERENCES customers (customerID);

alter table orders add CONSTRAINT fk_os FOREIGN key (ShipVia) REFERENCES shippers (shipperID);

alter table Territories add CONSTRAINT fk_tr FOREIGN key (regionID) REFERENCES region (regionID);

alter table EmployeeTerritories add CONSTRAINT fk_ee FOREIGN key (employeeID) REFERENCES employees1 (employeeID);
alter table EmployeeTerritories drop CONSTRAINT fk_ee;

alter table EmployeeTerritories add CONSTRAINT fk_et FOREIGN key (TerritoryID) REFERENCES Territories (TerritoryID);
alter table EmployeeTerritories drop CONSTRAINT fk_et;

alter table employees1 add CONSTRAINT fk_er FOREIGN key (ReportsTo) REFERENCES employees1 (employeeID);

--drop all table sequence
--vo table sab se pahle drop hota hai jise koi bhi table ka foreign key na laga ho

drop table  OrderDetails;

drop table Orders;

drop table Customers;

drop table Shippers;

drop table Products;

drop table Suppliers;

drop table Categories;

drop table EmployeeTerritories;

drop table Employees1;

drop table Territories;

drop table Region;

--whos table load first and table views

select * from region;

select * from shippers;

select * from suppliers;

select * from categories;

select * from products;

select * from EmployeeTerritories;

select * from customers;

select * from orders;

select * from Territories;

select * from employees1;

select * from orderDetails;

--don't run

alter table employees1 modify (employeeID varchar2(30));

alter table EmployeeTerritories modify (employeeID varchar2(30));

alter table shippers modify (phone varchar2(30));

alter table Suppliers modify (CompanyName varchar2(100), Address varchar2(100), Phone varchar2(100), Fax varchar2(100), homepage varchar2(100));

alter table categories modify (Description varchar2(100));

alter table products modify (ProductName varchar2(100), UnitPrice number(20,2));

alter table orderdetails modify(Discount varchar2(100));

alter table EmployeeTerritories modify (TerritoryID varchar2(100));

alter table Territories modify (TerritoryID varchar2(100), TerritoryDescription varchar2(100));

alter table customers modify (Address varchar2(100), Phone varchar2(30), Fax varchar2(30));

alter table orders modify (Freight number(6,2), ShipName varchar2(100),ShipAddress varchar2(100));

alter table employees1 modify (HomePhone varchar2(30), PhotoPath varchar2(100));

--alter table Orders rename to OrderDetails;

--select *from customers;
--select *from 
--(select customerID from rank() over(order by customerID ) as rk from employees) where rank <= 5;
--
--select * from orderdetails;
--
--select c.CustomerID, max(Quantity) 
--from customers c join orders o
--on (c.CustomerID = o.customerID)
--join  OrderDetails od
--on (o.orderid = od.orderID)
--group by c.customerid;
--
--select c.CustomerID, sum(UnitPrice * Quantity) as tot, sum(Quantity) 
--from customers c join orders o
--on (c.CustomerID = o.customerID)
--join  OrderDetails od
--on (o.orderid = od.orderID)
--group by c.customerid;

--Q1: Who are the top 5 customers? 
--Ans : sabse phle unit price ka total sum nikalo or usko quantity se multiply karo or custmers table se flow join karo OrderDetails tak
select *from(
select customerID, tot, rank() over (order by tot desc) rk from
(select c.CustomerID, sum(UnitPrice * Quantity) as tot
from customers c join orders o
on (c.CustomerID = o.customerID)
join  OrderDetails od
on (o.orderid = od.orderID)
group by c.customerid))
where rk <=5;


--Q2: Who are the top 5 sales people? 

select *from(
select employeeID, ets, rank() over (order by ets desc) as rk  from
(select e.employeeID, sum(UnitPrice * Quantity) as ets
from employees1 e join orders o 
on (e.employeeID = o.employeeID)
join  OrderDetails od
on (o.orderID = od.orderID)
group by (e.employeeid )))
where rk <= 5; 
--koi bhi alieas direct where close me use nahi ho sakta uske liye naya select statement likhte hai 

--Q3: Which is the 2nd best selling product? 

select * from
(select  productname, secondP,rank() over (order by secondP desc) as rk from
(select productname, sum(o.quantity ) as secondP 
from orderdetails o join products p
on (o.productID = p.productid)
group by productname))
where rk = 2;


select * from ( 
select productname, secondpro, rank() over(order by secondpro desc) as rk from
(select productname, sum(quantity) as secondpro
from orderdetails join products
using (productid)
group by productname ))
where rk = 2
;


--Q4: Display product name, category of that product that are shipped by Speedy Express. 

select p.productname, c.CategoryName, s.CompanyName 
from Products p join Categories c
on (p.CategoryID = p.CategoryID)
join  OrderDetails od
on (p.productID = od.ProductID)
join orders o
on (od.orderid = o.orderid)
join customers cu
on (o.customerid = cu.customerid)
join shippers s
on (o.ShipVia = s.shipperid)
where s.CompanyName = 'Speedy Express';

--Q5: Display list of cities where Dairy Products is not being sold? 
select productname, CategoryName, city
from products join categories
using (categoryid)
join Suppliers 
using (SupplierID)
where CategoryName != 'Dairy Products';


--Q6: Which is the best performing year (sales wise)? 

















