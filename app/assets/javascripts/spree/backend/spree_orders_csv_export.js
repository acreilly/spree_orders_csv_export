// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'
$(document).ready(function() {

  $("#all_orders").on('click', function(e) {
    if (this.checked){
      $(".order_row").prop('checked', true);
      $("#list_state_change").css('visibility', 'inherit');
    }else{
      $(".order_row").prop('checked', false);
      $("#list_state_change").css('visibility', 'hidden');
    }
  });

});