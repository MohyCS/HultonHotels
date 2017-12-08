$(document).ready(function() {
	$.get("/login_status/", function(data) {
		if (data == 1) {
			window.location="http://localhost:8081/startpage.html"
		}
	});
});
