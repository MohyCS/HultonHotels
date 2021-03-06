$(document).ready(function () {
	console.log("here")

	$.ajax({
		url: "/room_history/", 
		type: 'get',
		success: function(data) {
		console.log(data)
		for (i = 0; i < data.length; i++) {
			let hotel_name = "Hulton @ " + data[i].City;

			//html string of DOM element we want to append
			var room_entry_html_string = `<div class="room_entry">
            <img class="room_entry_image" src="./img/cat.jpg"></img>
            <div class="room_entry_data">
                <h2 class="room_entry_title">Hotel_Name</h2>
                <p class="room_entry_description">Description</p>
				<p class="room_entry_description">Price: _price</p>
                <div class="room_entry_buttons">
                    <p>    
                        <a class="btn btn-primary text-center room_entry_book" 
                            href="review.html?hotel_id=`+data[i].Hotel_id+`&num=`+data[i].Room_no+`"
                            style="background-color:red;">
                            Review the Room
                        </a>
                    </p>
                </div>
				</div>
			</div>`;
			
			console.log("hi")
			room_entry_html_string = room_entry_html_string.replace("Hotel_Name", hotel_name);
			room_entry_html_string = room_entry_html_string.replace("Description", data[i].Room_description);
			room_entry_html_string = room_entry_html_string.replace("_price", "$" + data[i].Room_price);
			
			
			//convert html string to DOM
			var room_entry = $.parseHTML(room_entry_html_string);
			
			$("#show_rooms").append(room_entry);
		}
	},
	error: function(XMLHttpRequest, textStatus, errorThrown) {
		let status = XMLHttpRequest.status;
		if (status == 401) {
			if (confirm("NOT LOGGED IN, REDIRECTING TO LOG IN PAGE ON OK")) {
				window.location="http://localhost:8081/";
			}
		} else {
			console.log(textStatus);	
		}
	},
});
});
