//  Jquery for server side validation password strength.

jQuery(document).ready(function() {
 
	jQuery('#change_password_new_password, #change_password_new_password_confirmation').on('keyup', function(e) {
 
	if(jQuery('#change_password_new_password').val() != '' && jQuery('#change_password_new_password_confirmation').val() != '' && jQuery('#change_password_new_password').val() != jQuery('#change_password_new_password_confirmation').val())
	{
	jQuery('#passwordStrength').removeClass().addClass('alert alert-error').html('Passwords do not match!');
	 
	return false;
	}
 
	// Must have capital letter, numbers and lowercase letters
	var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*jQuery", "g");
 
	// Must have either capitals and lowercase letters or lowercase and numbers
	var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*jQuery", "g");
 
	// Must be at least 6 characters long
	var okRegex = new RegExp("(?=.{6,}).*", "g");
 
	if (okRegex.test(jQuery(this).val()) === false) {
	// If ok regex doesn't match the password
	jQuery('#passwordStrength').removeClass().addClass('alert alert-error').html('Password must be 6 characters long.');
	 
	} else if (strongRegex.test(jQuery(this).val())) {
	// If reg ex matches strong password
	jQuery('#passwordStrength').removeClass().addClass('alert alert-success').html('Good Password!');
	} else if (mediumRegex.test(jQuery(this).val())) {
	// If medium password matches the reg ex
	jQuery('#passwordStrength').removeClass().addClass('alert alert-info').html('Make your password stronger with more capital letters, more numbers and special characters!');
	} else {
	// If password is ok
	jQuery('#passwordStrength').removeClass().addClass('alert alert-error').html('Weak Password, try using numbers and capital letters.');
	}
	return true;
	});
 
});
