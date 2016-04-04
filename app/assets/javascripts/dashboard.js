$(document).ready(function() {
  $('#preview').hide();
  $('#modal').click(function() {
    $(this).hide();
    $('#preview').show();
    $('#preview').click(function() {
      $(this).hide();
      $('#modal').show();
    });
  });
});

$(window).on("scroll", function() {
  var fromTop = $("body").scrollTop();
    $('.caregiver-show-header').toggleClass("hide-for-small", (fromTop > 50));
     
});
