// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function($) {

    poc_index = 0;

    $("#add_vendor_form")

	    .on('click', '.add_button', function() {

	    	poc_index++;

	    	var template = $('#poc_template');

	    	var clone = template.clone()
	    						.removeClass('hide')
	    						.removeAttr('id')
	    						.attr('data-poc-index', poc_index)
	    						.insertBefore(template);

	    	clone.find('[name = "name"]').attr('name', 'poc[' + poc_index + '].name').end()
	    		 .find('[name = "contact_type"]').attr('name', 'poc[' + poc_index + '].contact_type').end()
	    		 .find('[name = "email"]').attr('name', 'poc[' + poc_index + '].email').end()
	    		 .find('[name = "phone_number"]').attr('name', 'poc[' + poc_index + '].phone_number').end()

	    })

	    .on('click', '.remove_button', function() {

	    	$(this).parent().parent('.form-group').remove();

    });

});