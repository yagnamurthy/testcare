$('.expand-button').on('click', function(evt) {
  evt.preventDefault();
  $(this).remove();
  return $.each($('.item.hidden'), function(num, element) {
    return $(element).removeClass('hidden');
  });
});


$(document).ready(function() {
   $.when('.navigation-column a.active'); 
    $('nav li:first').addClass('active');
 });