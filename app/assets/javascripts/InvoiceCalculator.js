var InvoiceCalculator;

window.InvoiceCalculator = InvoiceCalculator = (function() {
  var hourly_rate_textbox, invoice_hours_textbox, total_hourly_fee_textbox;

  hourly_rate_textbox = '';

  total_hourly_fee_textbox = '';

  invoice_hours_textbox = '';

  function InvoiceCalculator(hr_textbox_id, thf_textbox_id, ih_textbox_id) {
    hourly_rate_textbox = $('#' + hr_textbox_id);
    total_hourly_fee_textbox = $('#' + thf_textbox_id);
    invoice_hours_textbox = $('#' + ih_textbox_id);
    this.calculate_total_fee();
  }

  InvoiceCalculator.prototype.calculate_service_fee = function(hourly_rate) {
    var service_fee;
    service_fee = this.to_dollar(hourly_rate * 0.15);
    return service_fee;
  };

  InvoiceCalculator.prototype.calculate_total_fee = function() {
    var base, service_fee;
    base = this.to_dollar(hourly_rate_textbox.val()) * invoice_hours_textbox.val();
    service_fee = this.calculate_service_fee(base);
    return total_hourly_fee_textbox.html('$' + this.to_dollar(Number(base) + Number(service_fee)));
  };

  InvoiceCalculator.prototype.to_dollar = function(number) {
    return accounting.formatNumber(number, 2);
  };

  return InvoiceCalculator;

})();
