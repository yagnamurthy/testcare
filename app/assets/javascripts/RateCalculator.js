var RateCalculator;

window.RateCalculator = RateCalculator = (function() {
  var hourly_rate_textbox, service_fee_textbox, total_hourly_fee_textbox;

  hourly_rate_textbox = '';

  service_fee_textbox = '';

  total_hourly_fee_textbox = '';

  function RateCalculator(hr_textbox_id, sf_textbox_id, thf_textbox_id) {
    hourly_rate_textbox = $('#' + hr_textbox_id);
    service_fee_textbox = $('#' + sf_textbox_id);
    total_hourly_fee_textbox = $('#' + thf_textbox_id);
    this.calculate_total_fee();
  }

  RateCalculator.prototype.calculate_service_fee = function(hourly_rate) {
    var service_fee;
    service_fee = this.to_dollar(hourly_rate * 0.15);
    service_fee_textbox.html('$' + service_fee);
    return service_fee;
  };

  RateCalculator.prototype.calculate_total_fee = function() {
    var base, service_fee;
    base = this.to_dollar(hourly_rate_textbox.val());
    service_fee = this.calculate_service_fee(base);
    return total_hourly_fee_textbox.html('$' + this.to_dollar(Number(base) + Number(service_fee)));
  };

  RateCalculator.prototype.to_dollar = function(number) {
    return accounting.formatNumber(number, 2);
  };

  return RateCalculator;

})()
