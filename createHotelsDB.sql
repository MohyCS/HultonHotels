create table Hotel(HotelID int, Street varchar(15), City varchar(15), State char(2), Country varchar(20), Zip char(5), primary key(HotelID));

create table Phone_no(phone_no char(10), HotelID int, primary key(phone_no), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Breakfast(HotelID int, bType varchar(15), Description varchar(20), bPrice float, primary key (HotelID, bType), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Service(HotelID int, sType varchar(15), sCost float, primary key (HotelID, sType), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Room(HotelID int, Room_no int, Price float, Capacity int, Floor_no int, Description varchar(100), Type varchar(15), SDate date, EDate date, Discount int, primary key(HotelID, Room_no), foreign key (HotelID) references Hotel(HotelID));

create table Customer(CID int, Name varchar(30), Email varchar(40), Address varchar(100), Phone_no char(10), primary key(CID));

create table Review(ReviewID int, Rating varchar(2), TextComment varchar(100), HotelID int, Room_no int, bType varchar(15), sType varchar(15), CID int, primary key (ReviewID), foreign key (HotelID, Room_no) references Room(HotelID, Room_no), foreign key (HotelID, bType) references Breakfast (HotelID, bType), foreign key (HotelID, sType) references Service (HotelID, sType), foreign key (CID) references Customer(CID));

create table CreditCard(Cnumber int, BillingAddr varchar(100), Name varchar(30), secCode int, Type varchar(15), ExpDate date, primary key (Cnumber));

create table Reservation(InvoiceNo int, ResDate date, TotalAmt float, CID int, CreditCard int, primary key (InvoiceNo), foreign key (CID) references Customer(CID), foreign key (CreditCard) references CreditCard(Cnumber));

create table BreakfastIncluded(InvoiceNo int, HotelID int, bType varchar(15), primary key (InvoiceNo, HotelID, bType), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, bType) references Breakfast(HotelID, bType));

create table ServiceIncluded(InvoiceNo int, HotelID int, sType varchar(15), primary key (InvoiceNo, HotelID, sType), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, sType) references Service(HotelID, sType));

create table RoomReserve(InvoiceNo int, HotelID int, Room_no int, OutDate date, InDate date, NoOfDays int, primary key (InvoiceNo, HotelID, Room_no), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, Room_no) references Room(HotelID, Room_no));

