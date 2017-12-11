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
	var price = getParameterByName('price');
	var indate = $("#indate").val()
	var outdate = $("#outdate").val()
	var seccode = $("#seccode").val()
	var address = $("#address").val()
	var cardtype = $("#cardtype").val()
	var cardnum = $("#cardnum").val()
	var expirdate = $("#expirdate").val()
	var name = $("#name").val()
	var breakfast = $("#breakfast").val()
	var service = $("#service").val()

	//make ajax request
	$.post("/make_reservation/", {
		hotelID: hotelID,
		room_no: room_no,
		price: price,
		indate: indate,
		outdate: outdate,
		seccode: seccode,
		address: address,
		cardtype: cardtype,
		cardnum: cardnum,
		expirdate: expirdate,
		name: name,
		breakfast: breakfast,
		service: service
	}, function(data) {
		console.log(data);
	});

	window.location="http://localhost:8081/startpage.html"
}
