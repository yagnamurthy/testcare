window.offers = function() {
  var calculate_rate;
  if ($('#offer_rate').length) {
    calculate_rate = new RateCalculator('offer_rate', 'offer_percentage', 'offer_total');
    calculate_rate.calculate_total_fee();
    return $('#offer_rate').on('change', function() {
      return calculate_rate.calculate_total_fee();
    });
  }
};
