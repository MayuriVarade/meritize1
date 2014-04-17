// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.datepicker
//= require_tree .


//javascript functions for datepicker


jQuery(function (){
        jQuery('#vote_setting_start_cycle').datepicker( 
    { altField  : '#vote_setting_start_cycle',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
  
});     

//javascript functions for datepicker


jQuery(function (){
        jQuery('#vote_setting_end_cycle').datepicker( 
    { altField  : '#vote_setting_end_cycle',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
});


//javascript functions for datepicker


jQuery(function (){
        jQuery('#prop_start_cycle').datepicker( 
    { altField  : '#prop_start_cycle',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
});

//javascript functions for datepicker


jQuery(function (){
        jQuery('#prop_end_cycle').datepicker( 
    { altField  : '#prop_end_cycle',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
});

jQuery(function (){
        jQuery('#vehicle_start_date').datepicker( 
    { altField  : '#vehicle_start_date',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
  
});     

//javascript functions for datepicker


jQuery(function (){
        jQuery('#vehicle_end_date').datepicker( 
    { altField  : '#vehicle_end_date',  // selector of the hidden input field you want sent to the server
      dateFormat: 'yy-mm-dd',
      altFormat : 'yy-mm-dd' } );
});











//javascript functions for nested forms to


function remove_fields (link) {

 jQuery(link).prev("input[type=hidden]:first").val('1');
   jQuery(link).closest(".fields").hide();


}


function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
   jQuery(link).parent().before(content.replace(regexp, new_id));


}

// $('a[data-popup]').live('click', function(e) {
//   window.open( $(this).attr('href'), "Popup", "height=600, width=600" );
//   e.preventDefault();
// });




$('body').on('click','a[data-popup]', function(e) {
    window.open( $(this).attr('href'), "Popup", "height=600, width=600" );
    e.preventDefault();
});


$( document ).ready(function() {
    $("#submit_plan").click(function(){
        nicEditors.findEditor('plan_forusers').saveContent();
        nicEditors.findEditor('plan_foradmins').saveContent();
        nicEditors.findEditor('plan_pricing').saveContent();
        return true;
    })
});
