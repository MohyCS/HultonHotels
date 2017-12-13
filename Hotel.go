package main

import(
	_ "github.com/go-sql-driver/mysql"
	"net/http"
	"database/sql"
	"log"
	"time"
	"encoding/json"
	"math/rand"
	"strconv"
	"strings"
	"fmt"
)

//make the db accessable in all methods
var db *sql.DB

//room enties returned to book rooms page
type room_entry struct {
	Hotel_id int
	City string
	Room_description string
	Room_no int
	Room_price float64
	Room_type string
}

//review entry returned to see reviews page
type review_entry struct {
	City string
	Room_no int
	Description string
	Rating string
	Customer_name string
	Btype string
	Stype string
}

type breakfast_service_price struct {
	Breakfast_price float64
	Service_price float64
	Num_days int
}

func login(w http.ResponseWriter, r *http.Request) {
	setToken(w, r, 0)
	return
}

func checkLoginStatus(w http.ResponseWriter, r *http.Request) {
	//gets the cookie
	_, err := r.Cookie("Auth")

	if err == http.ErrNoCookie {
		//not logged in
		login_status := 0

		data, err := json.Marshal(login_status)
		if err != nil {
			log.Fatal(err)
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(data)
	} else if err != nil {
		log.Fatal(err)
	} else {
		//logged in
		login_status := 1

		data, err := json.Marshal(login_status)
		if err != nil {
			log.Fatal(err)
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(data)
	}
}

func register(w http.ResponseWriter, r *http.Request) {
	log.Println("REGISTERING")
	setToken(w, r, 1)
	return
}

//create a cookie for the client
func setToken(w http.ResponseWriter, r *http.Request, loginOrRegister int) {
	r.ParseForm()	//parse url parameters passed

	var CID int	//customer ID
	email := r.Form["email"][0]

	//if login check to see if user is already in the databse
	if loginOrRegister == 0 {
		err := db.QueryRow("SELECT c.CID from Customer c where Email=?", email).Scan(&CID)

		if err == sql.ErrNoRows {
			//TODO: should return error message to the client
			log.Fatal("No customer matching those credentials")
		} else if err != nil {
        		log.Fatal(err)
		}
	} else {
		//register user
		name := r.Form["name"][0]
		phone_no := r.Form["phone_no"][0]
		address := r.Form["address"][0]

		//check to see if user is already in the database
		var email1 string
		err := db.QueryRow("SELECT c.Email from Customer c where c.Email=?", email).Scan(&email1)

		if err != sql.ErrNoRows {
			log.Fatal("Can't register User, User already exists")
		}

		//if user doesn't already exit, register the user
		rand.Seed(time.Now().UTC().UnixNano())
		CID = rand.Intn(32767)		//generate random customer ID
		//create user in database
		_, err = db.Exec("INSERT INTO Customer values(?, ?, ?, ?, ?)", CID, name, email, address, phone_no)
		if err != nil {
			log.Println("INSERTING USER FAILED")
			log.Fatal(err)
		}

	}

	expireCookie := time.Now().Add(time.Hour * 10)

	// Place the token in the client's cookie 
	cookie := http.Cookie{Name: "Auth", Domain: "localhost", Path: "/", Value: strconv.Itoa(CID), Expires: expireCookie}
	http.SetCookie(w, &cookie)

	// Redirect the user back to the home page
	http.Redirect(w, r, "/", 307)
}

//deletes the cookie
func logout(w http.ResponseWriter, r *http.Request){
	//set cookie that will expire immediately thus removing cookie
	deleteCookie := http.Cookie{Name: "Auth", Domain: "localhost", Path: "/", Value: "none", Expires: time.Now()}
	http.SetCookie(w, &deleteCookie)

	//redirect back to home
	http.Redirect(w, r, "/", 307)
	return
}

//gets room data by state
func room_data_fetcher(w http.ResponseWriter, r *http.Request) {
	var rooms []room_entry

	state := r.URL.Query()["state"][0]	//gets state query parameter that user passed on GET request
	
	//gets hotel rooms available in that state
	rows, err := db.Query("SELECT r.HotelID, h.City, r.Description, r.Room_no, r.Price, r.Type FROM Room r, Hotel h WHERE r.HotelID = h.HotelID and h.State=?", state)
	log.Println(rows)
	if err != nil {
        	log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
        	var entry room_entry
        	if err := rows.Scan(&(entry.Hotel_id), &(entry.City),  &(entry.Room_description), &(entry.Room_no), &(entry.Room_price), &(entry.Room_type)); err != nil {
                	log.Fatal(err)
        	}
			
		//append room_entry to the rooms array
		rooms = append(rooms, entry)
	}
	
	
	if err := rows.Err(); err != nil {
        	log.Fatal(err)
	}

	json1, err := json.Marshal(rooms)
	log.Println(rooms)
	log.Println(string(json1))
	if err != nil {
		log.Fatal(err)
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(json1)
}

//gets rooms that customer has booked
func room_history_fetcher(w http.ResponseWriter, r *http.Request) {
	//get authentication cookie which contains CID as value
	cookie, err := r.Cookie("Auth")

	if err == http.ErrNoCookie {
		log.Println("NO COOKIE. USER MUST LOG IN");

		//return error if Cookie isn't there
		http.Error(w, "User Not Logged In", 401)
		return
	} else if err != nil {
		log.Fatal(err)
	}

	CID, err := strconv.Atoi(cookie.Value)
	if err != nil {
		log.Fatal(err)
	}
	var rooms []room_entry

	//gets hotel rooms that have a reservation with CID
	rows, err := db.Query("SELECT r.HotelID, h.City, r.Description, r.Room_no, r.Price FROM Room r, Hotel h, Reservation q, RoomReserve p, Customer c  WHERE r.HotelID = h.HotelID and c.CID = q.CID and p.InvoiceNo=q.InvoiceNo and p.HotelID=r.HotelID and p.Room_no=r.Room_no and c.CID=?", CID)
	log.Println(rows)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var entry room_entry
		if err := rows.Scan(&(entry.Hotel_id), &(entry.City), &(entry.Room_description), &(entry.Room_no), &(entry.Room_price)); err != nil {
			log.Fatal(err)
	}

		//append room_entry to the rooms array
		rooms = append(rooms, entry)
	}


	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	json1, err := json.Marshal(rooms)
	log.Println(rooms)
	log.Println(string(json1))
	if err != nil {
		log.Fatal(err)
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(json1)
}


func submitReview(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()	//parse url parameters passed
	log.Println(r.Form)
	cookie, err := r.Cookie("Auth")

	if err == http.ErrNoCookie {
		log.Println("NO COOKIE. USER MUST LOG IN");

		//return error if Cookie isn't there
		http.Error(w, "User Not Logged In", 401)
		return
	} else if err != nil {
		log.Fatal(err)
	}

	//customer ID
	CID, err := strconv.Atoi(cookie.Value)
	if err != nil {
		log.Fatal(err)
	}


	//parse post data
	log.Println("1")
	rating := r.Form["rating"][0]
	log.Println("2")
	comment := r.Form["description"][0]
	log.Println("3")
	hotel_id := r.Form["hotel_id"][0]
	log.Println(hotel_id)
	room_no := r.Form["room_no"][0]

	//find breakfast based on reservation
	var bType string
	err = db.QueryRow("SELECT b.bType from Breakfast b, Reservation r, BreakfastIncluded b1, RoomReserve r1 where b1.InvoiceNo=r.InvoiceNo and b1.bType=b.bType and b1.HotelID=b.HotelID and r1.InvoiceNo=r.InvoiceNo and r1.HotelID=? and r1.Room_no=? and r.CID=?", hotel_id, room_no, CID).Scan(&bType)

	if err == sql.ErrNoRows {
		log.Fatal("No Breakfast option. Not possible")
	} else if err != nil {
		log.Fatal(err)
	}

	//check to see which service is associated to the hotel
	var sType string
	err = db.QueryRow("SELECT s.sType from Service s, Reservation r, ServiceIncluded s1, RoomReserve r1 where s1.InvoiceNo=r.InvoiceNo and s1.sType=s.sType and s1.HotelID=s.HotelID and r1.InvoiceNo=r.InvoiceNo and r1.HotelID=? and r1.Room_no=? and r.CID=?", hotel_id, room_no, CID).Scan(&sType)

	if err == sql.ErrNoRows {
		log.Fatal("No Service option. Not possible")
	} else if err != nil {
		log.Fatal(err)
	}

	//insert review into database
	rand.Seed(time.Now().UTC().UnixNano())
	reviewID := rand.Intn(32767)	//generate random review id

	_, err = db.Exec("INSERT INTO Review values(?, ?, ?, ?, ?, ?, ?, ?)", reviewID, rating, comment, hotel_id, room_no, bType, sType, CID)
	if err != nil {
		log.Fatal(err)
	}

	return
}

func calcDayDifference(indate string, outdate string) int {
	//calculate number of days from outdate - indate
	date1 := strings.Split(indate, "-")
	date2 := strings.Split(outdate, "-")

	yr1, err := strconv.Atoi(date1[0])
	if err != nil {
		log.Fatal(err)
	}

	m1, err := strconv.Atoi(date1[1])
	if err != nil {
		log.Fatal(err)
	}

	d1, err := strconv.Atoi(date1[2])
	if err != nil {
		log.Fatal(err)
	}

	yr2, err := strconv.Atoi(date2[0])
	if err != nil {
		log.Fatal(err)
	}

	m2, err := strconv.Atoi(date2[1])
	if err != nil {
		log.Fatal(err)
	}

	d2, err := strconv.Atoi(date2[2])
	if err != nil {
		log.Fatal(err)
	}

	dateIn :=  time.Date(yr1, time.Month(m1), d1, 0, 0, 0, 0, time.UTC)
	dateOut :=  time.Date(yr2, time.Month(m2), d2, 0, 0, 0, 0, time.UTC)

	//calculates difference between 2 dates
	difference := dateOut.Sub(dateIn)
	return int(difference.Hours() / 24)
}

func makeReservation(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()	//parse url parameters passed

	cookie, err := r.Cookie("Auth")
	if err == http.ErrNoCookie {
		log.Println("NO COOKIE. USER MUST LOG IN");

		//return error if Cookie isn't there
		http.Error(w, "User Not Logged In", 401)
		return
	} else if err != nil {
		log.Fatal(err)
	}

	//customer ID
	CID, err := strconv.Atoi(cookie.Value)
	if err != nil {
		log.Fatal(err)
	}

	rand.Seed(time.Now().UTC().UnixNano())
	InvoiceNo := rand.Intn(32767)	//generate random Invoice No
	totalamt := r.Form["price"][0]	//total amount
	year, month, day := time.Now().Date()	//resdate info
	resdate := fmt.Sprintf("%d-%d-%d", year, month, day)

	//credit card information
	cardnum := strings.TrimSpace(r.Form["cardnum"][0])
	seccode := r.Form["seccode"][0]
	cardtype := r.Form["cardtype"][0]
	billingaddress := r.Form["address"][0]
	name := r.Form["name"][0]
	expirdate := r.Form["expirdate"][0]

	//check to see if card is already in the database
	var a string
	err = db.QueryRow("SELECT c.Cnumber from CreditCard c where c.Cnumber=?", cardnum).Scan(&a)

	if err == sql.ErrNoRows {
		log.Println("Inserting credit card into database")

		//add credit card to database
		_, err = db.Exec("INSERT INTO CreditCard values(?, ?, ?, ?, ?, ?)", cardnum, billingaddress, name, seccode, cardtype, expirdate)
		if err != nil {
			log.Println("INSERTING CREDIT CARD FAILED")
			log.Fatal(err)
		}
	} else if err != nil {
		log.Fatal(err)
	}

	//insert into Table Reservation
	_, err = db.Exec("INSERT INTO Reservation values(?, ?, ?, ?, ?)", InvoiceNo, resdate, totalamt, CID, cardnum)
	if err != nil {
		log.Println("Error in inserting into reservation")
		log.Fatal(err)
	}

	indate := r.Form["indate"][0]		//Date reservation starts
	outdate := r.Form["outdate"][0]		//Date reservation ends
	hotelID := r.Form["hotelID"][0]		//id of hotel for reservation
	room_no := r.Form["room_no"][0]		//room number being reserved
	numDays := r.Form["num_days"][0]

	breakfast := r.Form["breakfast"][0]
	service := r.Form["service"][0]

	//insert into Table Breakfast Included
	_, err = db.Exec("INSERT INTO BreakfastIncluded values(?, ?, ?)", InvoiceNo, hotelID, breakfast)
	if err != nil {
		log.Fatal(err)
	}

	//insert into Table Service Included
	_, err = db.Exec("INSERT INTO ServiceIncluded values(?, ?, ?)", InvoiceNo, hotelID, service)
	if err != nil {
		log.Fatal(err)
	}


	//insert into Table RoomReserve
	_, err = db.Exec("INSERT INTO RoomReserve values(?, ?, ?, ?, ?, ?)", InvoiceNo, hotelID, room_no, outdate, indate, numDays)
	if err != nil {
		log.Fatal(err)
	}
}

func getReviews(w http.ResponseWriter, r *http.Request) {
	//parse form
	r.ParseForm()

	//get hotelid and room_id
	hotel_id := r.Form["hotel_id"][0]
	room_no := r.Form["room_no"][0]

	var reviews []review_entry

	//gets reviews that are for that Hotel and room_no
	rows, err := db.Query("SELECT h.City, r.Rating, r.TextComment, r.Room_no, r.bType, r.sType, c.Name from Review r, Customer c, Hotel h where r.CID=c.CID and h.HotelID=r.HotelID and r.HotelID=? and r.Room_no=?", hotel_id, room_no)

	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var entry review_entry
		if err := rows.Scan(&(entry.City), &(entry.Rating), &(entry.Description), &(entry.Room_no), &(entry.Btype), &(entry.Stype), &(entry.Customer_name)); err != nil {
			log.Fatal(err)
		}
		log.Println(entry)

		//append room_entry to the rooms array
		reviews = append(reviews, entry)
	}


	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	json1, err := json.Marshal(reviews)

	if err != nil {
		log.Fatal(err)
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(json1)
}


func getBreakfastServicePrice(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()

	hotel_id := r.Form["hotel_id"][0]
	breakfast := r.Form["breakfast"][0]
	service := r.Form["service"][0]
	indate := r.Form["indate"][0]
	outdate := r.Form["outdate"][0]


	//get Price of breakfast
	var b_price float64
	err := db.QueryRow("SELECT b.bPrice from Breakfast b where b.HotelID=? and b.bType=?", hotel_id, breakfast).Scan(&b_price)

	if err == sql.ErrNoRows {
		log.Fatal("Should be a breakfast option")
	} else if err != nil {
		log.Fatal(err)
	}

	//get Price of Service
	var s_price float64
	err = db.QueryRow("SELECT s.sCost from Service s where s.HotelID=? and s.sType=?", hotel_id, service).Scan(&s_price)

	if err == sql.ErrNoRows {
		log.Fatal("Should be a service option")
	} else if err != nil {
		log.Fatal(err)
	}

	//calculate number of days between indate and outdate
	numDays := calcDayDifference(indate, outdate)

	result := breakfast_service_price{Breakfast_price: b_price, Service_price: s_price, Num_days: numDays}
	log.Println(result)

	json1, err := json.Marshal(result)
	log.Println(string(json1))

	if err != nil {
		log.Fatal(err)
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(json1)
}


func main() {
	//open database
	var err error
	db, err = sql.Open("mysql", "viewer:Rutgers568$@/Hulton")

	if err != nil {
		log.Println("4")
		log.Fatal(err)
	}

	//serves the static files in directory static
	http.Handle("/", http.FileServer(http.Dir("./static")))
	http.HandleFunc("/room_data/", room_data_fetcher)
	http.HandleFunc("/room_history/", room_history_fetcher)
	http.HandleFunc("/register/", register)
	http.HandleFunc("/login/", login)
	http.HandleFunc("/logout/", logout)
	http.HandleFunc("/submit_review/", submitReview)
	http.HandleFunc("/make_reservation/", makeReservation)
	http.HandleFunc("/login_status/", checkLoginStatus)
	http.HandleFunc("/review_data/", getReviews)
	http.HandleFunc("/get_breakfast_service_price/", getBreakfastServicePrice)

	//listens on port 8081
	log.Fatal(http.ListenAndServe(":8081", nil))
}
