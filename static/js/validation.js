var x;
function name_check()
{
    var name = document.getElementById("name").value;
    var name_msg = document.getElementById('name_msg');

    onkeyup = function(){
        if(name.length >=3 )
        { 
            name_msg.innerHTML= "";
            return true;
        }
        else{
            name_msg.style.color="red";
            name_msg.innerHTML= "Name is invalid, please enter 3 or more characters!";
            
            return false;
        }
    }
}

function password_check()
{
    var password = document.getElementById("password").value;
    var password_msg = document.getElementById("password_msg");
    
    onkeyup = function(){
        if(password.length >= 5 )
        { 
            password_msg.innerHTML= "";
            return true;
        }
        else{
            password_msg.style.color="red";
            password_msg.innerHTML= "Password is invalid, please enter 5 or more characters!";
            return false;
        }
    }
}

function confirm_check()
{
    var confirm = document.getElementById("confirm").value;
    var confirm_msg = document.getElementById("confirm_msg");

    onkeyup = function()
    {
        if(confirm== password.value)
        {  
            confirm_msg.innerHTML= "";
            return true;
        }
        else{
            confirm_msg.style.color = "red";
            confirm_msg.innerHTML="Passwords do not match!";
            return false;
            
        }
    }
}

function username_check()
{
    var username = document.getElementById("username").value;
    var username_msg = document.getElementById('username_msg');

    onkeyup = function(){
        if(username.length >= 5 )
        { 
            username_msg.innerHTML = "";
            return true;
        }
        else{
            username_msg.style.color="red";
            username_msg.innerHTML= "Username is invalid, please enter 5 or more characters!";
            return false;
        }
    }
}

function email_check()   
{  
    var email = document.getElementById("email").value;
    var email_msg = document.getElementById('email_msg');
    var re = /\S+@\S+\.\S+/;

 if (re.test(email))  
  {  
    email_msg.innerHTML="";  
    return true;  
  }  
  else{
  email_msg.style.color = "red";
  email_msg.innerHTML="Invalid email address!";  
    return false;  
  }
}  

function cardnum_check()
{
    var cardnum = document.getElementById("cardnum").value;
    var cardnum_msg = document.getElementById('cardnum_msg');
    var amex = /^(?:3[47][0-9]{13})$/;
    var visa = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
    var mc = /^(?:5[1-5][0-9]{14})$/;   
    var disc = /^(?:6(?:011|5[0-9][0-9])[0-9]{12})$/;  

    onkeyup = function(){
        if(amex.test(cardnum)||visa.test(cardnum)||mc.test(cardnum)||disc.test(cardnum) )
        { 
            cardnum_msg.innerHTML = "";
            return true;
        }
        else{
            cardnum_msg.style.color="red";
            cardnum_msg.innerHTML= "Credit Card Number is invalid!";
            return false;
        }
    }
}
function expirdate_check()
{
    var expirdate = document.getElementById("expirdate").value;
    var d = new Date();
    var currentYear = d.getFullYear();
    var currentMonth = d.getMonth() + 1;
    // get parts of the expiration date
    var parts = expirdate.split('/');
    var year = parseInt(parts[1], 10) + 2000;
    var month = parseInt(parts[0], 10);
    if(!expirdate.match(/(0[1-9]|1[0-2])[/][0-9]{2}/))
    {
        expirdate_msg.style.color="red";
        expirdate_msg.innerHTML = "The expire date formate is not correct!";
        
    }
    else if (year < currentYear || (year == currentYear && month < currentMonth))
    {
        
        expirdate_msg.style.color="red";  
        expirdate_msg.innerHTML = "The expiry date has passed.";
        
        
    }
    else
    {
         expirdate_msg.innerHTML = "";
          
      
    }
}

function seccode_check()   
{  
    var seccode = document.getElementById("seccode").value;
    var seccode_msg = document.getElementById('seccode_msg');
    var code = /^[0-9]{3,4}$/;

 if (code.test(seccode))  
  {  
    seccode_msg.innerHTML="";  
    return true;  
  }  
  else{
  seccode_msg.style.color = "red";
  seccode_msg.innerHTML="Invalid security code!";  
    return false;  
  }
}  


