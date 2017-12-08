package main

import(
	_ "github.com/go-sql-driver/mysql"
	"net/http"
	"database/sql"
	"log"
	"fmt"
	"time"
	"encoding/json"
	"math/rand"
	"github.com/dgrijalva/jwt-go"
)

//make the db accessable in all methods
var db *sql.DB

//room enties returned to book rooms page
type room_entry struct {
	Hotel_id int
	Room_description string
	Room_no int
	Room_price float64
}

type Claims struct {
	email string `json:"email"`
	jwt.StandardClaims
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

//create a JWT for the client
func setToken(w http.ResponseWriter, r *http.Request, loginOrRegister int) {
	r.ParseForm()	//parse url parameters passed

	email := r.Form["email"][0]

	//if login check to see if user is already in the databse
	if loginOrRegister == 0 {
		var name1 string
		err := db.QueryRow("SELECT c.Name from Customer c where Email=?", email).Scan(&name1)

		if err == sql.ErrNoRows {
			//TODO: should return error message to the client
			log.Fatal("No customer matching those credentials")
		} else if err != nil {
        		log.Fatal(err)
		}
	} else {
		//register user
		name := r.Form["name"][0]
		log.Println(name)
		address := r.Form["address"][0]
		phone_no := r.Form["phone_no"][0]

		//check to see if user is already in the database
		var email1 string
		err := db.QueryRow("SELECT c.Email from Customer c where c.Email=?", email).Scan(&email1)

		if err != sql.ErrNoRows {
			log.Fatal("Can't register User, User already exists")
		}

		//if user doesn't already exit, register the user
		customerId := rand.Intn(32767)		//generate random customer ID
		//create user in database
		_, err = db.Exec("INSERT INTO Customer values(?, ?, ?, ?, ?)", customerId, name, email, address, phone_no)
		if err != nil {
			log.Println("INSERTING USER FAILED")
			log.Fatal(err)
		}
	}

	// Expires the token and cookie in 1 hour
	expireToken := time.Now().Add(time.Hour * 1).Unix()
	expireCookie := time.Now().Add(time.Hour * 1)

	// We'll manually assign the claims but in production you'd insert values from a database 
	claims := Claims {
		email,
		jwt.StandardClaims {
			ExpiresAt: expireToken,
			Issuer:    "localhost:8081",
		},
	}

	// Create the token using your claims
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	// Signs the token with a secret.    
	signedToken, _ := token.SignedString([]byte("secret"))

	// Place the token in the client's cookie 
	cookie := http.Cookie{Name: "Auth", Domain: "localhost", Path: "/", Value: signedToken, Expires: expireCookie}
	http.SetCookie(w, &cookie)

	// Redirect the user back to the home page
	http.Redirect(w, r, "/", 307)
}

//deletes the cookie
func logout(w http.ResponseWriter, r *http.Request){
	deleteCookie := http.Cookie{Name: "Auth", Domain: "localhost", Path: "/", Value: "none", Expires: time.Now()}
	http.SetCookie(w, &deleteCookie)
	return
}

func room_data_fetcher(w http.ResponseWriter, r *http.Request) {
	var rooms []room_entry

	state := r.URL.Query()["state"][0]	//gets state query parameter that user passed on GET request
	
	//gets hotel rooms available in that state
	rows, err := db.Query("SELECT r.HotelID, r.Description, r.Room_no, r.Price FROM Room r, Hotel h WHERE r.HotelID = h.HotelID and h.State=?", state)
	log.Println(rows)
	if err != nil {
		log.Println("1")
        log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
        	var entry room_entry
        	if err := rows.Scan(&(entry.Hotel_id), &(entry.Room_description), &(entry.Room_no), &(entry.Room_price)); err != nil {
					log.Println("5")
                	log.Fatal(err)
        	}
			
		//append room_entry to the rooms array
		rooms = append(rooms, entry)
	}
	
	
	if err := rows.Err(); err != nil {
		log.Println("2")
        log.Fatal(err)
	}

	json1, err := json.Marshal(rooms)
	log.Println(rooms)
	log.Println(string(json1))
	if err != nil {
		log.Println("3")
		log.Fatal(err)
	}

	//returns back json response
	fmt.Printf("At the end\n")
	
	w.Header().Set("Content-Type", "application/json")
	w.Write(json1)
}

func submitReview(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()	//parse url parameters passed

	//parse post data
	rating := r.Form["rating"][0]
	comment := r.Form["comment"][0]
	hotel_id := r.Form["hotel_id"][0]
	room_no := r.Form["room_no"][0]
	btype := r.Form["btype"][0]
	stype := r.Form["stype"][0]
	CID := r.Form["CID"][0]

	//insert review into database
	_, err := db.Exec("INSERT INTO Review values(?, ?, ?, ?, ?, ?, ?)", rating, comment, hotel_id, room_no, btype, stype, CID)
	if err != nil {
		log.Fatal(err)
	}

	return
}

func makeReservation(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()	//parse url parameters passed

	//parse post data for credit card info
	Cnumber := r.Form["card_number"][0]
	BillingAddr := r.Form["BillingAddr"][0]
	Name := r.Form["name"][0]
	securityCode := r.Form["security_code"][0]
	Type := r.Form["type"][0]
	ExpDate := r.Form["exp_date"][0]

	//insert credit card into database
	_, err := db.Exec("INSERT INTO CreditCard values(?, ?, ?, ?, ?, ?)", Cnumber, BillingAddr, Name, securityCode, Type, ExpDate)
	if err != nil {
		log.Fatal(err)
	}

	//parse post data for reservation
	ResDate := r.Form["res_date"][0]
	TotalAmt := r.Form["total_amount"][0]
	CID := r.Form["customerID"][0]

	//insert a reservation into database
	_, err = db.Exec("INSERT INTO Reservation values(?, ?, ?, ?, ?, ?, ?)", ResDate, TotalAmt, CID, Cnumber)

	if err != nil {
		log.Fatal(err)
	}

	return

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
	http.HandleFunc("/register/", register)
	http.HandleFunc("/login/", login)
	http.HandleFunc("/logout/", logout)
	http.HandleFunc("/submit_review/", submitReview)
	http.HandleFunc("/make_reservation/", makeReservation)
	http.HandleFunc("/login_status/", checkLoginStatus)

	//listens on port 8081
	log.Fatal(http.ListenAndServe(":8081", nil))
}
