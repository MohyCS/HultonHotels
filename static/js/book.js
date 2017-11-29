function getRoomsByState() {
	console.log("here")
	var state = $('#room_state_selection').find(":selected").text();

	$.get("/room_data/", {state: state}, function(data) {
		console.log(data)
		for (i = 0; i < data.length; i++) {
			
			//html string of DOM element we want to append
			var room_entry_html_string = `<div class="room_entry">
            <img class="room_entry_image" src="./img/cat.jpg"></img>
            <div class="room_entry_data">
                <h2 class="room_entry_title">Hotel Name</h2>
                <p class="room_entry_description">Description</p>
                <div class="room_entry_buttons">
                    <p style="">    
                        <a class="btn btn-primary text-center room_entry_review" 
                            href="room.html"
                            style="background-color:red;"
                            onclick="">
                            Write a Review
                        </a>
                    </p>
                    <p>    
                        <a class="btn btn-primary text-center room_entry_book" 
                            href="room.html"
                            style="background-color:red;"
                            onclick="">
                            Book Now!
                        </a>
                    </p>
                </div>
				</div>
			</div>`;
			
			console.log("hi")
			room_entry_html_string = room_entry_html_string.replace("Hotel Name", data[i].Hotel_id);
			room_entry_html_string = room_entry_html_string.replace("Description", data[i].Room_description);
			
			
			//convert html string to DOM
			var room_entry = $.parseHTML(room_entry_html_string);
			
			$("#show_rooms").append(room_entry);
		}
	});
	console.log("here 2")
}
