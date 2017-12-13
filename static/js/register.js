function errorChecking() {
	var name = $("#name").val();
	var email = $("#email").val();
	var phone_no = $("#phone_no").val();
	var address = $("#address").val();

	if (name.length > 30) {
		alert("NAME CAN'T BE LONGER THAN 30 CHARACTERS")
		return false;
	}

	if (email.length > 40) {
		alert("EMAIL CAN'T BE LONGER THAN 40 CHARACTERS")
		return false;
	}

	//phone number check
	if (phone_no.length != 10) {
		alert("Phone number wasn't in right format.\nNeeds to be 10 numbers no dashes. Ex: 1234567890")
		return false
	}

	for (i = 0; i < 10; i++) {
		if (isNaN(parseInt(phone_no[i]))) {
			// Is not a number
			alert("Phone number wasn't in right format.\nNeeds to be 10 numbers no dashes. Ex: 1234567890")
			return false
		}
	}

	if (address.length > 100) {
		alert("ADDRESS CAN'T BE LONGER THAN 100 CHARACTERS")
		return false;
	}

	return false;
}
