# HultonHotels
cs336 group 32 project

Instructions for Running:
Need Golang Version 1.9

create directory in home folder /go. Inside create /src. Inside git clone this repository or paste the code. So the structure should be /go/src/HultonHotels with all of our code inside it

Setting up the database:
  - mysql -u root -p to access the shell. Enter your root password.
  
  SQL: 
  create database Hulton;
  use Hulton;
  source ...../createHotelsDB.sql   (you should include the absolute path of this file. For me its /home/eminkin/go/src/HultonHotels/createHotelsDB.sql)
  
  That should fill the database. Then, create a user and grant him privileges on the database
  
  GRANT ALL PRIVILEGES ON *.* TO 'viewer'@'localhost' IDENTIFIED BY 'Rutgers568$';
  
  
 That's it for setting up the database.
 Go into the /go/src/HultonHotels folder and run 'go build'
 This should build the executable. Then run the executable which will be called HultonHotels.
 
 ./HultonHotels on linux or mac, and HultonHotels on windows
  
  Any questions please reach out to me at (201)496-9463 or ebm74@scarletmail.rutgers.edu
