//  jQuery for server side validation for sign_up.
  jQuery(document).ready(function() {
   
//  jQuery for server side validation password strength.

	jQuery('#change_password_new_password').keyup(function(e) {
     var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*jQuery", "g");
     var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*jQuery", "g");
     var enoughRegex = new RegExp("(?=.{6,}).*", "g");
     if (false == enoughRegex.test(jQuery(this).val())) {
             jQuery('#passstrength').html('Password is too short (minimum is 6 characters)');
     } else if (strongRegex.test(jQuery(this).val())) {
             jQuery('#passstrength').className = 'ok';
             jQuery('#passstrength').html('Strong!');
     } else if (mediumRegex.test(jQuery(this).val())) {
             jQuery('#passstrength').className = 'alert';
             jQuery('#passstrength').html('Medium!');
     } else {
             jQuery('#passstrength').className = 'error';
             jQuery('#passstrength').html('Weak!');
     }
     return true;
	});


        jQuery("#signin").validate({
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
                         required:  "Please enter the field",
                         email   :  "Please enter Valid Email Id"
                         },
        
        
             "session[password]":{
                              required:"Please enter field"
                             }                    
            }
        });


 
});
