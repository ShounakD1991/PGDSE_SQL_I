##### Create the Database as Supply_chain 
###_______________________________________________________###
Create database Supply_chain;
use Supply_chain;

##### Create table Customer along with its indexes 
###_______________________________________________________###

create table Customer (
   Id                   int                  ,
   FirstName            varchar(40)         not null,
   LastName             varchar(40)         not null,
   City                 varchar(40)         null,
   Country              varchar(40)         null,
   Phone                varchar(20)         null,
   constraint PK_CUSTOMER primary key (Id)
);
create index IndexCustomerName on Customer (
LastName ASC,
FirstName ASC
);

##### Create table Orders along with its indexes 
###_______________________________________________________###


create table Orders (
   Id                   int                  ,
   OrderDate            varchar(20)             not null, 
   OrderNumber          varchar(10)         null,
   CustomerId           int                  not null,
   TotalAmount          decimal(12,2)        null default 0,
   constraint PK_ORDER primary key (Id)
);
create index IndexOrderCustomerId on Orders (
CustomerId ASC
);
create index IndexOrderOrderDate on Orders (
OrderDate ASC
);

##### Create table OrderItem along with its indexes 
###_______________________________________________________###

create table OrderItem (
   Id                   int                  ,
   OrderId              int                  not null,
   ProductId            int                  not null,
   UnitPrice            decimal(12,2)        not null default 0,
   Quantity             int                  not null default 1,
   constraint PK_ORDERITEM primary key (Id)
);

create index IndexOrderItemOrderId on OrderItem (
OrderId ASC
);

create index IndexOrderItemProductId on OrderItem (
ProductId ASC
);

##### Create table Product along with its indexes 
###_______________________________________________________###

create table Product (
   Id                   int                  ,
   ProductName          varchar(50)         not null,
   SupplierId           int                  not null,
   UnitPrice            decimal(12,2)        null default 0,
   Package              varchar(30)         null,
   IsDiscontinued       bit                  not null default 0,
   constraint PK_PRODUCT primary key (Id)
);
create index IndexProductSupplierId on Product (
SupplierId ASC
);
create index IndexProductName on Product (
ProductName ASC
);

##### Create table Supplier along with its indexes 
###_______________________________________________________###


create table Supplier (
   Id                   int                  ,
   CompanyName          varchar(40)         not null,
   ContactName          varchar(50)         null,
   ContactTitle         varchar(40)         null,
   City                 varchar(40)         null,
   Country              varchar(40)         null,
   Phone                varchar(30)         null,
   Fax                  varchar(30)         null,
   constraint PK_SUPPLIER primary key (Id)
);

create index IndexSupplierName on Supplier (
CompanyName ASC
);

create index IndexSupplierCountry on Supplier (
Country ASC
);

