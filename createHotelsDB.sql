create table Hotel(HotelID int, Street varchar(15), City varchar(20), State char(2), Country varchar(20), Zip char(5), primary key(HotelID));

create table Phone_no(phone_no char(10), HotelID int, primary key(phone_no), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Breakfast(HotelID int, bType varchar(15), Description varchar(20), bPrice float, primary key (HotelID, bType), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Service(HotelID int, sType varchar(15), sCost float, primary key (HotelID, sType), foreign key (HotelID) references Hotel(HotelID) on delete cascade);

create table Room(HotelID int, Room_no int, Price float, Capacity int, Floor_no int, Description varchar(100), Type varchar(15), SDate date, EDate date, Discount int, primary key(HotelID, Room_no), foreign key (HotelID) references Hotel(HotelID));

create table Customer(CID int, Name varchar(30), Email varchar(40), Address varchar(100), Phone_no char(10), primary key(CID));

create table Review(ReviewID int, Rating varchar(2), TextComment varchar(500), HotelID int, Room_no int, bType varchar(15), sType varchar(15), CID int, primary key (ReviewID), foreign key (HotelID, Room_no) references Room(HotelID, Room_no), foreign key (HotelID, bType) references Breakfast (HotelID, bType), foreign key (HotelID, sType) references Service (HotelID, sType), foreign key (CID) references Customer(CID));

create table CreditCard(Cnumber char(16), BillingAddr varchar(100), Name varchar(30), secCode int, Type varchar(15), ExpDate date, primary key (Cnumber));

create table Reservation(InvoiceNo int, ResDate date, TotalAmt float, CID int, CreditCard char(16), primary key (InvoiceNo), foreign key (CID) references Customer(CID), foreign key (CreditCard) references CreditCard(Cnumber));

create table BreakfastIncluded(InvoiceNo int, HotelID int, bType varchar(15), primary key (InvoiceNo, HotelID, bType), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, bType) references Breakfast(HotelID, bType));

create table ServiceIncluded(InvoiceNo int, HotelID int, sType varchar(15), primary key (InvoiceNo, HotelID, sType), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, sType) references Service(HotelID, sType));

create table RoomReserve(InvoiceNo int, HotelID int, Room_no int, OutDate date, InDate date, NoOfDays int, primary key (InvoiceNo, HotelID, Room_no), foreign key (InvoiceNo) references Reservation(InvoiceNo), foreign key (HotelID, Room_no) references Room(HotelID, Room_no));



INSERT into Hotel VALUES ( 1 ,'2 Washington' , 'Newark' , 'NJ','USA' , 07102);
INSERT into Hotel VALUES ( 2 ,'361 Nassau' , 'princeton' , 'NJ','USA' , 08540);
INSERT into Hotel VALUES ( 3 ,'210 Pacific ave' , 'Atlantic City' , 'NJ','USA' , 08401);
INSERT into Hotel VALUES ( 4 ,'3 bush PKWY' , 'Hoboken' , 'NJ','USA' , 07030);
INSERT into Hotel VALUES ( 5 ,'1 Main' , 'Fair Lawn' , 'NJ','USA' , 07410);

INSERT into Hotel VALUES ( 6 ,'701 Ellicott' , 'Buffalo' , 'NY','USA' , 14203);
INSERT into Hotel VALUES ( 7 ,'34th' , 'New York City' , 'NY','USA' , 10018);
INSERT into Hotel VALUES ( 8 ,'Broadway' , 'Yonkers' , 'NY','USA' , 10019);

INSERT into Hotel VALUES ( 9 ,'12 Broadway' , 'Allgood' , 'AL','USA' , 65418);
INSERT into Hotel VALUES ( 10 ,'6 Bush' , 'Alabaster' , 'AL','USA' , 65001);
INSERT into Hotel VALUES ( 11,'2 main' , 'Brantley' , 'AL','USA' , 81920);
INSERT into Hotel VALUES ( 12 ,'5 River Road' , 'Brookwood' , 'AL','USA' , 10018);

INSERT into Hotel VALUES ( 13 ,'45 East Ave' , 'Phoenix' , 'AZ','USA' , 88712);
INSERT into Hotel VALUES ( 14 ,'27 George St' , 'Tucson' , 'AZ','USA' , 77461);



INSERT into Hotel VALUES ( 15 ,'19 main'  , 'Los Angeles' , 'CA','USA' , 11234);
INSERT into Hotel VALUES ( 16 ,'34 East Ave' , 'San Francisco' , 'CA','USA' , 11871);
INSERT into Hotel VALUES ( 17 ,'2 Bush ST' , 'San Jose' , 'CA','USA' , 11762);

INSERT into Hotel VALUES ( 18 ,'990 4th Street' , 'Little Rock' , 'AR','USA' , 17663);
INSERT into Hotel VALUES ( 19 ,'45 Tyler Ave', 'Fayetteville' , 'AR','USA' , 76453);
INSERT into Hotel VALUES ( 20 ,'123 Alex Road' , 'Fort Smith' , 'AR','USA' , 86253);
INSERT into Hotel VALUES ( 21 ,'432 Hill Street' , 'Conway' , 'AR','USA' , 18643);

INSERT into Hotel VALUES ( 22 ,'872 5th Street' , 'Denver' , 'CO','USA' , 99825);
INSERT into Hotel VALUES ( 23 ,'16 Earl Ave', 'Boulder' , 'CO','USA' , 99826);
INSERT into Hotel VALUES ( 24 ,'123 Alex Road' , 'Fort Smith' , 'CO','USA' , 99882);
INSERT into Hotel VALUES ( 25 ,'990 4th Street' , 'Little Rock' , 'CO','USA' , 10019);
INSERT into Hotel VALUES ( 26 ,'69 Mo Street' , 'Big Mo' , 'CO','USA' , 10019);


INSERT into Hotel VALUES ( 27 ,'47 Eli Ave' , 'Philadelphia' , 'PA','USA' , 78659);
INSERT into Hotel VALUES ( 28 ,'7th Street', 'Pittsburgh' , 'PA','USA' , 87092);
INSERT into Hotel VALUES ( 29 ,'123 Nice Road' , 'Harrisburg' , 'PA','USA' , 99112);






INSERT into Phone_no VALUES ( 2847594857,1 );
INSERT into Phone_no VALUES ( 3547587858,2 );
INSERT into Phone_no VALUES ( 1876594859,3 );
INSERT into Phone_no VALUES ( 2858320058,4 );
INSERT into Phone_no VALUES ( 4394230950,5 );
INSERT into Phone_no VALUES ( 2839572385,6 );
INSERT into Phone_no VALUES ( 2305839589,7 );
INSERT into Phone_no VALUES ( 9556587858,8 );
INSERT into Phone_no VALUES ( 9876874859,9 );
INSERT into Phone_no VALUES ( 1847594857,10 );
INSERT into Phone_no VALUES ( 8747575357,11 );
INSERT into Phone_no VALUES ( 9696587858,12 );
INSERT into Phone_no VALUES ( 9112374859,13 );
INSERT into Phone_no VALUES ( 9876874858,14 );
INSERT into Phone_no VALUES ( 1547594857,15 );
INSERT into Phone_no VALUES ( 8747573457,16 );
INSERT into Phone_no VALUES ( 9696588858,17 );
INSERT into Phone_no VALUES ( 8912374859,18 );
INSERT into Phone_no VALUES ( 8456485684,19 );
INSERT into Phone_no VALUES ( 1624161624,20 );
INSERT into Phone_no VALUES ( 6078055078,21 );
INSERT into Phone_no VALUES ( 2896538983,22 );
INSERT into Phone_no VALUES ( 1234161624,23 );
INSERT into Phone_no VALUES ( 6078054378,24 );
INSERT into Phone_no VALUES ( 2891299983,25 );
INSERT into Phone_no VALUES ( 1555561624,26 );
INSERT into Phone_no VALUES ( 8078023437,28 );
INSERT into Phone_no VALUES ( 2893499983,29 );





INSERT into Breakfast VALUES ( 1 ,'vegetarian' , 'asparagus with eggs' , 7.50);
INSERT into Breakfast VALUES ( 1 ,'vegan' , 'roasted vegetables' , 3.50);
INSERT into Breakfast VALUES ( 1 ,'regular' , 'turkey sandwich' , 8.50);

INSERT into Breakfast VALUES ( 2 ,'vegetarian' , 'asparagus with eggs' , 9.50);
INSERT into Breakfast VALUES ( 2 ,'vegan' , 'roasted vegetables' , 4.00);
INSERT into Breakfast VALUES ( 2 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 3 ,'vegetarian' , 'asparagus with eggs' , 6.00);
INSERT into Breakfast VALUES ( 3 ,'vegan' , 'roasted vegetables' , 5.00);
INSERT into Breakfast VALUES ( 3 ,'regular' , 'turkey sandwich' , 12.00);

INSERT into Breakfast VALUES ( 4 ,'vegetarian' , 'asparagus with eggs' , 3.50);
INSERT into Breakfast VALUES ( 4 ,'vegan' , 'roasted vegetables' , 9.00);
INSERT into Breakfast VALUES ( 4 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 5 ,'vegetarian' , 'asparagus with eggs' , 6);
INSERT into Breakfast VALUES ( 5 ,'vegan' , 'roasted vegetables' , 6);
INSERT into Breakfast VALUES ( 5 ,'regular' , 'turkey sandwich' , 6);

INSERT into Breakfast VALUES ( 6 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 6 ,'vegan' , 'roasted vegetables' , 10.55);
INSERT into Breakfast VALUES ( 6 ,'regular' , 'turkey sandwich', 1.20);

INSERT into Breakfast VALUES ( 7 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 7 ,'vegan' , 'roasted vegetables' , 6.75);
INSERT into Breakfast VALUES ( 7 ,'regular' , 'turkey sandwich' , 10.50);

INSERT into Breakfast VALUES ( 8 ,'vegetarian' , 'asparagus with eggs' , 7.50);
INSERT into Breakfast VALUES ( 8 ,'vegan' , 'roasted vegetables' , 3.50);
INSERT into Breakfast VALUES ( 8 ,'regular' , 'turkey sandwich' , 8.50);

INSERT into Breakfast VALUES ( 9 ,'vegetarian' , 'asparagus with eggs' , 9.50);
INSERT into Breakfast VALUES ( 9 ,'vegan' , 'roasted vegetables' , 4.00);
INSERT into Breakfast VALUES ( 9 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 10 ,'vegetarian' , 'asparagus with eggs' , 6.00);
INSERT into Breakfast VALUES ( 10 ,'vegan' , 'roasted vegetables' , 5.00);
INSERT into Breakfast VALUES ( 10 ,'regular' , 'turkey sandwich' , 12.00);

INSERT into Breakfast VALUES ( 11 ,'vegetarian' , 'asparagus with eggs' , 3.50);
INSERT into Breakfast VALUES ( 11, 'vegan' , 'roasted vegetables' , 9.00);
INSERT into Breakfast VALUES ( 11 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 12 ,'vegetarian' , 'asparagus with eggs' , 6);
INSERT into Breakfast VALUES ( 12 ,'vegan' , 'roasted vegetables' , 6);
INSERT into Breakfast VALUES ( 12 ,'regular' , 'turkey sandwich' , 6);

INSERT into Breakfast VALUES ( 13 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 13 ,'vegan' , 'roasted vegetables' , 10.55);
INSERT into Breakfast VALUES ( 13 ,'regular' , 'turkey sandwich', 1.20);

INSERT into Breakfast VALUES ( 14 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 14 ,'vegan' , 'roasted vegetables' , 6.75);
INSERT into Breakfast VALUES ( 14 ,'regular' , 'turkey sandwich' , 10.50);

INSERT into Breakfast VALUES ( 15 ,'vegetarian' , 'asparagus with eggs' , 7.50);
INSERT into Breakfast VALUES ( 15 ,'vegan' , 'roasted vegetables' , 3.50);
INSERT into Breakfast VALUES ( 15 ,'regular' , 'turkey sandwich' , 8.50);

INSERT into Breakfast VALUES ( 16 ,'vegetarian' , 'asparagus with eggs' , 9.50);
INSERT into Breakfast VALUES ( 16 ,'vegan' , 'roasted vegetables' , 4.00);
INSERT into Breakfast VALUES ( 16 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 17 ,'vegetarian' , 'asparagus with eggs' , 6.00);
INSERT into Breakfast VALUES ( 17,'vegan' , 'roasted vegetables' , 5.00);
INSERT into Breakfast VALUES ( 17 ,'regular' , 'turkey sandwich' , 12.00);

INSERT into Breakfast VALUES ( 18 ,'vegetarian' , 'asparagus with eggs' , 3.50);
INSERT into Breakfast VALUES ( 18 ,'vegan' , 'roasted vegetables' , 9.00);
INSERT into Breakfast VALUES ( 18 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 19 ,'vegetarian' , 'asparagus with eggs' , 6);
INSERT into Breakfast VALUES ( 19 ,'vegan' , 'roasted vegetables' , 6);
INSERT into Breakfast VALUES ( 19 ,'regular' , 'turkey sandwich' , 6);

INSERT into Breakfast VALUES ( 20 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 20 ,'vegan' , 'roasted vegetables' , 10.55);
INSERT into Breakfast VALUES ( 20 ,'regular' , 'turkey sandwich', 1.20);

INSERT into Breakfast VALUES ( 21 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 21 ,'vegan' , 'roasted vegetables' , 6.75);
INSERT into Breakfast VALUES ( 21 ,'regular' , 'turkey sandwich' , 10.50);

INSERT into Breakfast VALUES ( 22 ,'vegetarian' , 'asparagus with eggs' , 7.50);
INSERT into Breakfast VALUES ( 22 ,'vegan' , 'roasted vegetables' , 3.50);
INSERT into Breakfast VALUES ( 22 ,'regular' , 'turkey sandwich' , 8.50);

INSERT into Breakfast VALUES ( 23 ,'vegetarian' , 'asparagus with eggs' , 9.50);
INSERT into Breakfast VALUES ( 23 ,'vegan' , 'roasted vegetables' , 4.00);
INSERT into Breakfast VALUES ( 23 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 24 ,'vegetarian' , 'asparagus with eggs' , 6.00);
INSERT into Breakfast VALUES ( 24 ,'vegan' , 'roasted vegetables' , 5.00);
INSERT into Breakfast VALUES ( 24 ,'regular' , 'turkey sandwich' , 12.00);

INSERT into Breakfast VALUES ( 25 ,'vegetarian' , 'asparagus with eggs' , 3.50);
INSERT into Breakfast VALUES ( 25, 'vegan' , 'roasted vegetables' , 9.00);
INSERT into Breakfast VALUES ( 25 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 26 ,'vegetarian' , 'asparagus with eggs' , 3.50);
INSERT into Breakfast VALUES ( 26, 'vegan' , 'roasted vegetables' , 9.00);
INSERT into Breakfast VALUES ( 26 ,'regular' , 'turkey sandwich' , 11.00);

INSERT into Breakfast VALUES ( 27 ,'vegetarian' , 'asparagus with eggs' , 6);
INSERT into Breakfast VALUES ( 27 ,'vegan' , 'roasted vegetables' , 6);
INSERT into Breakfast VALUES ( 27 ,'regular' , 'turkey sandwich' , 6);

INSERT into Breakfast VALUES ( 28 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 28 ,'vegan' , 'roasted vegetables' , 10.55);
INSERT into Breakfast VALUES ( 28 ,'regular' , 'turkey sandwich', 1.20);

INSERT into Breakfast VALUES ( 29 ,'vegetarian' , 'asparagus with eggs' , 5.50);
INSERT into Breakfast VALUES ( 29 ,'vegan' , 'roasted vegetables' , 6.75);
INSERT into Breakfast VALUES ( 29 ,'regular' , 'turkey sandwich' , 10.50);





INSERT into Service VALUES ( 1 ,'Full' , 12.10);
INSERT into Service VALUES ( 1 ,'Half' , 6.10);
INSERT into Service VALUES ( 1 ,'No' , 0.00);
INSERT into Service VALUES ( 2 ,'Full' , 12.10);
INSERT into Service VALUES ( 2 ,'Half' , 6.10);
INSERT into Service VALUES ( 2 ,'No' , 0.00);
INSERT into Service VALUES ( 3 ,'Full' , 12.10);
INSERT into Service VALUES ( 3 ,'Half' , 6.10);
INSERT into Service VALUES ( 3 ,'No' , 0.00);
INSERT into Service VALUES ( 4 ,'Full' , 12.10);
INSERT into Service VALUES ( 4 ,'Half' , 6.10);
INSERT into Service VALUES ( 4 ,'No' , 0.00);
INSERT into Service VALUES ( 5 ,'Full' , 12.10);
INSERT into Service VALUES ( 5 ,'Half' , 6.10);
INSERT into Service VALUES ( 5 ,'No' , 0.00);
INSERT into Service VALUES ( 6 ,'Full' , 12.10);
INSERT into Service VALUES ( 6 ,'Half' , 6.10);
INSERT into Service VALUES ( 6 ,'No' , 0.00);
INSERT into Service VALUES ( 7 ,'Full' , 12.10);
INSERT into Service VALUES ( 7 ,'Half' , 6.10);
INSERT into Service VALUES ( 7 ,'No' , 0.00);
INSERT into Service VALUES ( 8 ,'Full' , 12.10);
INSERT into Service VALUES ( 8 ,'Half' , 6.10);
INSERT into Service VALUES ( 8 ,'No' , 0.00);
INSERT into Service VALUES ( 9 ,'Full' , 12.10);
INSERT into Service VALUES ( 9 ,'Half' , 6.10);
INSERT into Service VALUES ( 9 ,'No' , 0.00);
INSERT into Service VALUES ( 10 ,'Full' , 12.10);
INSERT into Service VALUES ( 10 ,'Half' , 6.10);
INSERT into Service VALUES ( 10 ,'No' , 0.00);
INSERT into Service VALUES ( 11 ,'Full' , 12.10);
INSERT into Service VALUES ( 11 ,'Half' , 6.10);
INSERT into Service VALUES ( 11 ,'No' , 0.00);
INSERT into Service VALUES ( 12 ,'Full' , 12.10);
INSERT into Service VALUES ( 12 ,'Half' , 6.10);
INSERT into Service VALUES ( 12 ,'No' , 0.00);
INSERT into Service VALUES ( 13,'Full' , 12.10);
INSERT into Service VALUES ( 13 ,'Half' , 6.10);
INSERT into Service VALUES ( 13 ,'No' , 0.00);
INSERT into Service VALUES ( 14 ,'Full' , 12.10);
INSERT into Service VALUES ( 14 ,'Half' , 6.10);
INSERT into Service VALUES ( 14 ,'No' , 0.00);
INSERT into Service VALUES ( 15 ,'Full' , 12.10);
INSERT into Service VALUES ( 15 ,'Half' , 6.10);
INSERT into Service VALUES ( 15 ,'No' , 0.00);
INSERT into Service VALUES ( 16 ,'Full' , 12.10);
INSERT into Service VALUES ( 16 ,'Half' , 6.10);
INSERT into Service VALUES ( 16 ,'No' , 0.00);
INSERT into Service VALUES ( 17 ,'Full' , 12.10);
INSERT into Service VALUES ( 17 ,'Half' , 6.10);
INSERT into Service VALUES ( 17 ,'No' , 0.00);
INSERT into Service VALUES ( 18 ,'Full' , 12.10);
INSERT into Service VALUES ( 18 ,'Half' , 6.10);
INSERT into Service VALUES ( 18 ,'No' , 0.00);
INSERT into Service VALUES ( 19 ,'Full' , 12.10);
INSERT into Service VALUES ( 19 ,'Half' , 6.10);
INSERT into Service VALUES ( 19 ,'No' , 0.00);
INSERT into Service VALUES ( 20 ,'Full' , 12.10);
INSERT into Service VALUES ( 20 ,'Half' , 6.10);
INSERT into Service VALUES ( 20 ,'No' , 0.00);
INSERT into Service VALUES ( 21 ,'Full' , 12.10);
INSERT into Service VALUES ( 21 ,'Half' , 6.10);
INSERT into Service VALUES ( 21 ,'No' , 0.00);
INSERT into Service VALUES ( 22 ,'Full' , 12.10);
INSERT into Service VALUES ( 22 ,'Half' , 6.10);
INSERT into Service VALUES ( 22 ,'No' , 0.00);
INSERT into Service VALUES ( 23 ,'Full' , 12.10);
INSERT into Service VALUES ( 23 ,'Half' , 6.10);
INSERT into Service VALUES ( 23 ,'No' , 0.00);
INSERT into Service VALUES ( 24 ,'Full' , 12.10);
INSERT into Service VALUES ( 24 ,'Half' , 6.10);
INSERT into Service VALUES ( 24 ,'No' , 0.00);
INSERT into Service VALUES ( 25 ,'Full' , 12.10);
INSERT into Service VALUES ( 25 ,'Half' , 6.10);
INSERT into Service VALUES ( 25 ,'No' , 0.00);
INSERT into Service VALUES ( 26 ,'Full' , 12.10);
INSERT into Service VALUES ( 26 ,'Half' , 6.10);
INSERT into Service VALUES ( 26 ,'No' , 0.00);
INSERT into Service VALUES ( 27 ,'Full' , 12.10);
INSERT into Service VALUES ( 27 ,'Half' , 6.10);
INSERT into Service VALUES ( 27 ,'No' , 0.00);
INSERT into Service VALUES ( 28 ,'Full' , 12.10);
INSERT into Service VALUES ( 28 ,'Half' , 6.10);
INSERT into Service VALUES ( 28 ,'No' , 0.00);
INSERT into Service VALUES ( 29 ,'Full' , 12.10);
INSERT into Service VALUES ( 29 ,'Half' , 6.10);
INSERT into Service VALUES ( 29 ,'No' , 0.00);





INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 33, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 21, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 1 , 11, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 2 , 18, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 2 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 2 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 2 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 2 , 19, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 4, 159.99 , 5 , 1,  '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 71, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 3 , 41, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 4 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 4 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 4 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 4 , 31, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 4 , 56, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 4, 159.99 , 5 , 1,  '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 23, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 24, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 61, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 21, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 17, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 16, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 5 , 39, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 41, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 16, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 6 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 7 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 7 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 7 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 7 , 49, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 7 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 39, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 41, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 52, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 8 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 9 , 12, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 9 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 9 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 9 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 9 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 41, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 46, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 58, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 10 , 31, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 11 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 11 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 11 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 11 , 41, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 11 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 4, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 9, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 51, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 12 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 13 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 13 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 13 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 13 , 12, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 13 , 13, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 4, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 15, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 16, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 17, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 14 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 15 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 15 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 15 , 46, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);

INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 15 , 41, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 15 , 30, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 30, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 35, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 40, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 16 , 55, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 55, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 40, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 30, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 17 , 48, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 18 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 18 , 45, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 18 , 40, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 18 , 35, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 18 , 30, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 19 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 19 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 19 , 40, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 19 , 35, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 19 , 30, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 45, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 50, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 55, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 60, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 65, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 21 , 70, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 20 , 75, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 20 , 80, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 20 , 85, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 20 , 90, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 20 , 95, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 100, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 105, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 110, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 115, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 120, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 22 , 135, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 23 , 125, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 23 , 130, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 23 , 140, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 23 , 145, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 23 ,150, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 155, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 160, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 165, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 170, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 175, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 24 , 180, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 25 , 185, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 25 , 190, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 25 , 195, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 25 , 200, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 25 , 205, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 210, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 215, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 220, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 225, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 230, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 26 , 235, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 27 , 245, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 27 , 250, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 27 , 240, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 27 , 255, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 27 , 260, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 265, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 270, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 275, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 280, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 285, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 28 , 290, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 29 , 295, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 29 , 300, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 29 , 305, 159.99 , 5 , 1, '3 bedroom 3 bath', 'regular' , 30);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 29 , 310, 89.99 , 3 , 12, '2 bedroom 1 bath', 'vip' , 10);
INSERT into Room (HotelID, Room_no, Price, Capacity, Floor_no, Description, Type, Discount ) VALUES ( 29 , 315, 99.99 , 4 , 12, '2 bedroom 2 bath', 'regular' , 20);

