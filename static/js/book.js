function getRoomsByState() {
	//clear div of previous elements
	$("#show_rooms").html('');
	console.log("here")
	var state = $('#room_state_selection').find(":selected").val();
	console.log(state)

	$.get("/room_data/", {state: state}, function(data) {
		console.log(data)

		for (i = 0; i < data.length; i++) {
			
			let hotel_name = "Hulton @ " + data[i].City;
			var imgsrc;
			if (data[i].Room_type == 'vip') {
				imgsrc = "./img/vip.jpg";
			} else {
				imgsrc = "./img/reg.jpg";
			}

			//html string of DOM element we want to append
			var room_entry_html_string = `<div class="room_entry">
            <img class="room_entry_image" src=`+imgsrc+`></img>
            <div class="room_entry_data">
                <h2 class="room_entry_title">`+hotel_name+`</h2>
                <p class="room_entry_description">`+data[i].Room_description+`</p>
				<p class="room_entry_description">Price: $`+data[i].Room_price+` per night</p>
                <div class="room_entry_buttons">
		    <p>    
                        <a class="btn btn-primary text-center room_entry_book" 
                            href="seeReviews.html?hotel_id=`+data[i].Hotel_id+`&num=`+data[i].Room_no+`"
                            style="background-color:red;">
                            See Reviews
                        </a>
                    </p>
                    <p>    
                        <a class="btn btn-primary text-center room_entry_book" 
                            href="confirmation.html?hotel_id=`+data[i].Hotel_id+`&hotel_name=`+hotel_name+`&description=`+data[i].Room_description+`&num=`+data[i].Room_no+`&price=`+data[i].Room_price+`"
                            style="background-color:red;">
                            Book Now!
                        </a>
                    </p>
                </div>
				</div>
			</div>`;
			
			//convert html string to DOM
			var room_entry = $.parseHTML(room_entry_html_string);
			
			$("#show_rooms").append(room_entry);
		}
	});
	console.log("here 2")
}
