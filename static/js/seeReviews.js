$(document).ready(function() {
	console.log("here")
	var hotel_id = getParameterByName('hotel_id')
	var room_no = getParameterByName('num')

	$.get("/review_data/", {hotel_id: hotel_id, room_no: room_no}, function(data) {
		console.log(data)
		for (i = 0; i < data.length; i++) {
			let hotel_name = "Hulton Hotels @ " + data[i].City + ", Room #: " + data[i].Room_no;

			//html string of DOM element we want to append
			var review_entry_html_string = `<div class="review_container">
				<h1 class="bold">`+hotel_name+`</h1>
				<h3>Rating: `+data[i].Rating+`</h2>
				<p class="italics">by `+data[i].Customer_name+`</p>
				<h4>Breakfast Type: `+data[i].Btype+`</h4>
				<h4>Service Type: `+data[i].Stype+`</h4>
				<p>`+data[i].Description+`</p>	
			</div>`;
			
			//convert html string to DOM
			var review_entry = $.parseHTML(review_entry_html_string);
			
			$("#see_Reviews").append(review_entry);
		}
	});
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

