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
	var coupon = $("#coupon").val()
	var indate = $("#indate").val()
	var outdate = $("#outdate").val()
	var seccode = $("#seccode").val()
	var address = $("#address").val()
	var cardtype = $("#cardtype").val()
	var cardnum = $("#cardnum").val()
	var expirdate = $("#expirdate").val()
	var name = $("#name").val()

	//make ajax request
	$.post("/make_reservation/", {
		hotelID: hotelID,
		room_no: room_no,
		price: price,
		coupon: coupon,
		indate: indate,
		outdate: outdate,
		seccode: seccode,
		address: address,
		cardtype: cardtype,
		cardnum: cardnum,
		expirdate: expirdate,
		name: name
	}, function(data) {
		console.log(data);
	});

	window.location="http://localhost:8081/startpage.html"
}
