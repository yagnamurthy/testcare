window.caregivers = function() {
  var calculate_rate, countwords, preview, schedule_checkboxes, wire_details_box;
  if ('.unhide-more-information') {
    wire_details_box = function(element) {
      return $(element).find(".more-information").slideToggle();
    };
    $(".unhide-more-information").on('click', function(evt) {
      if ($(evt.target).hasClass('nb')) {
        return;
      }
      if (evt.target.nodeName !== 'LABEL') {
        return wire_details_box(this);
      }
    });
  }
  if ($('#availability_and_services_hourly_rate').length) {
    calculate_rate = new RateCalculator('availability_and_services_hourly_rate', 'carespotter-percentage-calculation', 'carespotter-total-rate');
    $('#availability_and_services_hourly_rate').on('change', function() {
      return calculate_rate.calculate_total_fee();
    });
  }
  countwords = $(".count-words");
  if (countwords) {
    $.each(countwords, function(num, element) {
      return Countable.live(element, function(counter) {
        if (parseInt(counter.words) > 50) {
          $(element).parents('.form-elements').find(".green").removeClass("hidden");
          return $(element).parents('.form-elements').find('.words-left').text("50 words minimum (currently " + counter.words + " words)");
        } else {
          $(element).parents('.form-elements').find(".green").addClass("hidden");
          return $(element).parents('.form-elements').find(".words-left").text("50 words minimum (currently " + counter.words + " words)");
        }
      });
    });
    $.each($(".count-characters"), function(num, element) {
      return Countable.live(element, function(counter) {
        var intext;
        if (counter.all >= 50) {
          intext = $(element).val();
          $(element).val(intext.substring(0, 50 + (intext.length - counter.all)));
          return $(element).parents('.form-elements').find(".characters-left").text("Title can be 50 characters total: (currently 0 characters left");
        } else {
          return $(element).parents('.form-elements').find(".characters-left").text("Title can be 50 characters total: (currently " + (50 - counter.all) + " characters left)");
        }
      });
    });
    schedule_checkboxes = $(".schedule-checkbox");
    preview = $("#preview");
    return countwords = $(".count-words");
  }
};


