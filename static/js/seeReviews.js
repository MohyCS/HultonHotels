function getReviewsByRoomIDandReviewID() {
	console.log("here")
	var state = $('#review_state_selection').find(":selected").text();

	$.get("/review_data/", {state: state}, function(data) {
		console.log(data)
		for (i = 0; i < data.length; i++) {
			
			//html string of DOM element we want to append
			var review_entry_html_string = `<div class="review_entry">
            <div class="review_entry_data">
                <p class="room_entry_rating">_rating</p>
				<p class="room_entry_description">Description: _description</p>
                <div class="room_entry_buttons">
                    <p>    
                        <a class="btn btn-primary text-center room_entry_book" 
                            href="confirmation.html?hotel_name=`+data[i].Hotel_id+`&description=`+data[i].Review_description+`&num=`+data[i].Room_no+`&price=`+data[i].Room_price+`"
                            style="background-color:red;">
                            Book Now!
                        </a>
                    </p>
                </div>
				</div>
			</div>`;
			
			console.log("hi")
			room_entry_html_string = room_entry_html_string.replace("Hotel_Name", "Hulton @ " + data[i].City);
			room_entry_html_string = room_entry_html_string.replace("Description", data[i].Room_description);
			room_entry_html_string = room_entry_html_string.replace("_price", "$" + data[i].Room_price);
			
			
			//convert html string to DOM
			var room_entry = $.parseHTML(room_entry_html_string);
			
			$("#show_rooms").append(room_entry);
		}
	});
	console.log("here 2")
}