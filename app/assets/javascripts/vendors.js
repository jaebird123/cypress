// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function($) {

    $(".clickable-row").click(function() {
        window.document.location = $(this).data("href");
    });
    
});