$(document).ready(function() {
    $('#address_type').change(function() {
      if ($(this).val() === 'other') {
        $('#other_address_type_field').show();
      } else {
        $('#other_address_type_field').hide();
      }
    });
  });