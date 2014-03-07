//  $ for server side validation for sign_up.
  $(document).ready(function() {
   
//  $ for server side validation password strength.

	$('#change_password_new_password').keyup(function(e) {
     var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
     var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
     var enoughRegex = new RegExp("(?=.{6,}).*", "g");
     if (false == enoughRegex.test($(this).val())) {
             $('#passstrength').html('Password is too short (minimum is 6 characters)');
     } else if (strongRegex.test($(this).val())) {
             $('#passstrength').className = 'ok';
             $('#passstrength').html('Strong!');
     } else if (mediumRegex.test($(this).val())) {
             $('#passstrength').className = 'alert';
             $('#passstrength').html('Medium!');
     } else {
             $('#passstrength').className = 'error';
             $('#passstrength').html('Weak!');
     }
     return true;
	});

// signin validations 

        $("#signin").validate({
        errorElement:'span',
        rules: {
            "session[email]":{
                          required: true,
                          email: true
                         },
         
        
          "session[password]":{
                                  required: true,
                                 }

            },
        messages: {
            "session[email]":{
                         required:  "Please enter your Email Address",
                         email   :  "Please enter Valid Email Id"
                         

                        
                         },
        
        
             "session[password]":{
                              required:"Please enter Password"
                             }                    
            }
        });

// sign up validations
$("#new_user").validate({
errorElement:'span',
rules: {


"user[firstname]" :{
required: true

},

"user[lastname]" :{
required: true

},

"user[email]" :{
required: true,
email: true,
remote:"/users/validations/check_email"


},
"user[companyname]" :{
required: true


}
},

  messages: {

    "user[firstname]" :{
required: "Please enter your First name"

},
    "user[lastname]" :{
required: "Please enter your Last name"

},
    "user[email]" :{
required: "Please enter your Email Address",
 email:  "Please enter Valid Email Id",
 remote:"email id already exists"
},

"user[companyname]" :{
required: "Please enter your Company name"


}

  }



    });


// $("#edit_user_16").validate({
// errorElement:'span',
// rules: {


// "user[firstname]" :{
// required: true

// },

// "user[lastname]" :{
// required: true,
// },
// "user[email]" :{
// required: true,
// email: true
// },
// "user[password]" :{
// required: true,
// }
// },

//   messages: {

 
//     "user[firstname]" :{
// required: "Please enter your First name"

// },
//    "user[lastname]" :{
// required: "Please enter your Last name"

// },
//    "user[email]" :{
// required: "Please enter your Email Address"
//  email:  "Please enter Valid Email Id"

// },
//     "user[password]" :{
// required: "Please enter password",


// }

//   }



//    });
// jQuery("#contact-form").validate({
// errorElement:'span',
// rules: {

// "email" :{
// required: true
// email: true

// }
// },

//   messages: {


// "user[companyname]" :{
// required: "Please enter your Email Address"


// }

//   }



//     });

 
});
