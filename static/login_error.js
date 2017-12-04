var x;
function email_check()
{
    var email = document.getElementById("email").value;
    var email_msg = document.getElementById("email_msg");
    onkeyup = function()
    {

        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if (reg.test(email) == false) 
        {
            email_msg.style.color = "red";
            email_msg.innerHTML = "Invalid E-Mail!";
            return (false);
        }
        else
        {
            email_msg.style.color = "green";
            email_msg.innerHTML = "Valid E-Mail!";    
        }

        /**if (!(name.includes('@')))
        {
            email_msg.style.color = "red";
            email_msg.innerHTML = "Invalid E-Mail!";
        }
        else
        {
            email_msg.style.color = "green";
            email_msg.innerHTML = "Valid E-Mail!";
        }**/
    }
}