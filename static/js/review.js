function submitReview() {
	//get value of the rating 
	var radioValue = $("input[name='rating']:checked").val() 
	
	if (radioValue == 5) {
		rating = "A+";
	} else if (radioValue == 4) {
		rating = "B+";
	} else if (radioValue == 3) {
		rating = "C+";
	} else if (radioValue == 2) {
		rating = "D+";
	} else if (radioValue == 1) {
		rating = "F+";
	}

	var hotelID = getParameterByName('hotel_id');
	var room_no = getParameterByName('num');
	var rating_description = $("#text_review").val()
	console.log(hotelID)

	//make ajax request
	$.post("/submit_review/", {
		hotel_id: hotelID,
		room_no: room_no,
		description: rating_description,
		rating: rating
	}, function(data) {
		console.log(data);
	});

	window.location="http://localhost:8081/startpage.html"

}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

