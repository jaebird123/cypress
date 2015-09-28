// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/* This is something that must be done so that turbolinks will ready the document

var ready;
ready = function() {

  ...your javascript goes here...

};

$(document).ready(ready);
$(document).on('page:load', ready);

*/

var ready;
ready = function() {

    var poc_index = parseInt($('#poc_counter').text());

    $("#add_vendor_form")

	    .on('click', '.add_button', function() {

	    	var template = $('#poc_template');

	    	var clone = template.clone()
	    						.removeClass('hide')
	    						.removeAttr('id')
	    						.attr('data-poc-index', poc_index)
	    						.insertBefore(template);

	    	clone.find('[name = "name"]').attr('name', 'vendor[pocs_attributes][' + poc_index + '][name]').end()
	    		 .find('[name = "contact_type"]').attr('name', 'vendor[pocs_attributes][' + poc_index + '][contact_type]').end()
	    		 .find('[name = "email"]').attr('name', 'vendor[pocs_attributes][' + poc_index + '][email]').end()
	    		 .find('[name = "phone"]').attr('name', 'vendor[pocs_attributes][' + poc_index + '][phone]').end()

        poc_index++;

	    })

	    .on('click', '.remove_button', function() {

	    	$(this).parent().parent('.form-group').remove();

    });

    /* Add a single poc field set for a new vendor */
    if (poc_index == 0) {
      $('.add_button').click();
    }

};

$(document).ready(ready);
$(document).on('page:load', ready);