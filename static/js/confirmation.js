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