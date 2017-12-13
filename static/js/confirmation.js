$(document).ready(function() {
	var hotelName = getParameterByName('hotel_name');
	var description = getParameterByName('description');
	var room_no = getParameterByName('num');
	var price = getParameterByName('price');
	
	//sub in parameters in output
	$("#hotel_name").text(hotelName);
	$("#hotel_description").text(description);
	$("#room_numb").text(room_no);
	$("#room_price").text(price);
});

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function submitReservation() {
	console.log("submitting reservation")

	//get post parameters
	var hotelID = getParameterByName('hotel_id');
	var room_no = getParameterByName('num');
	var breakfast = $("#breakfast").val()
	var service = $("#service").val()
	var indate = $("#indate").val()
	var outdate = $("#outdate").val()

	var seccode = $("#seccode").val()
	var address = $("#address").val()
	var cardtype = $("#cardtype").val()
	var cardnum = $("#cardnum").val()
	var expirdate = $("#expirdate").val()
	var name = $("#name").val()

	if (!inputErrorChecking(indate, outdate, cardnum, name, expirdate, seccode, address)) {
		//error in input
		return;
	}

	var breakfast_price;
	var service_price;
	var num_days

	//get price of breakfast and service and number of days
	$.get("/get_breakfast_service_price/", {hotel_id: hotelID, breakfast: breakfast, service: service, indate: indate, outdate: outdate}, function(data) {
		console.log(data)
		breakfast_price = parseFloat(data.Breakfast_price);
		var breakfast_price_str = parseFloat(Math.round(breakfast_price * 100) / 100).toFixed(2);

		service_price = parseFloat(data.Service_price);
		var service_price_str = parseFloat(Math.round(service_price * 100) / 100).toFixed(2);

		num_days = data.Num_days;

		//calculate total amount
		var pricePerNight = parseFloat(getParameterByName('price'));
		var pricePerNight_str = parseFloat(Math.round(pricePerNight * 100) / 100).toFixed(2);

		var totalamt = (pricePerNight + breakfast_price + service_price) * num_days;
		
		var totalamt_str = parseFloat(Math.round(totalamt * 100) / 100).toFixed(2);
	
		console.log(breakfast_price)
		console.log(service_price)


		if (confirm("Price Breakdown:\nRoom price: $" + pricePerNight_str + " per night.\nBreakfast price: $" + breakfast_price_str + " per night.\nService price: $" + service_price_str + " per night.\n\nTotal Price is $" + totalamt_str + ".\nPress OK to confirm and submit reservation.") == true) {
			//make ajax request
			$.post("/make_reservation/", {
				hotelID: hotelID,
				room_no: room_no,
				price: totalamt,
				indate: indate,
				outdate: outdate,
				seccode: seccode,
				address: address,
				cardtype: cardtype,
				cardnum: cardnum,
				expirdate: expirdate,
				name: name,
				breakfast: breakfast,
				service: service,
				num_days: num_days
			}, function(data) {
				console.log(data);
				window.location="http://localhost:8081/startpage.html"
			}).fail(function(e) {
				if (e.status == 401) {
					if (confirm("NOT LOGGED IN, REDIRECTING TO LOG IN PAGE ON OK")) {
						window.location="http://localhost:8081/";
					}
				} else {
					console.log("ERROR")
				}
			});


		} else {
			console.log("Pressed cancel");
		}
	})
}	

function inputErrorChecking(startDate, endDate, cnumber, name, expirdate, seccode, address) {
	//start Date check
	if (!isValidDate(startDate)) {
		console.log("start date is invalid")
		alert("Start Date is invalid.\n\nPlease Enter in Format YYYY-MM-DD")
		return false
	}

	//end date check
	if (!isValidDate(endDate)) {
		console.log("end date is invalid")
		alert("End Date is invalid.\n\nPlease Enter in Format YYYY-MM-DD")
		return false
	}

	//credit card number check
	if (cnumber.length != 16) {
		console.log("Credit card number was not right length.")
		alert("Credit Card number wasn't in right format.\nNeeds to be 16 numbers no dashes. Ex: 1111222233334444")
		return false
	}

	for (i = 0; i < 16; i++) {
		if (isNaN(parseInt(cnumber[i]))) {
			// Is not a number
			console.log("Credit Card number needs to be numbers")
			alert("Credit Card number wasn't in right format.\nNeeds to be 16 numbers no dashes. Ex: 1111222233334444")
			return false
		}
	}

	//name on card check
	if (name.length >= 30) {
		console.log("Name too long")
		alert("Name was too long. Enter name with less than 30 characters");
		return false
	}

	//expir date check
	if (!isValidDate(expirdate)) {
		console.log("expiration date is invalid")
		alert("Expiration Date is invalid.\n\nPlease Enter in Format YYYY-MM-DD")
		return false
	}

	//security code check
	if (seccode.length != 3) {
		console.log("Security Code number was not right length.")
		alert("Security Code number wasn't in right format.\nNeeds to be 3 numbers. Ex: 111")
		return false
	}

	//address check
	if (address.length >= 100) {
		console.log("Address length is too long")
		alert("Address length is too long. Must be less than 100 characters");
		return false;
	}

	return true;		//return true if no problems
}

function isValidDate(dateString) {
  var regEx = /^\d{4}-\d{2}-\d{2}$/;
  if(!dateString.match(regEx)) return false;  // Invalid format
  var d = new Date(dateString);
  if(!d.getTime() && d.getTime() !== 0) return false; // Invalid date
  return d.toISOString().slice(0,10) === dateString;
}
