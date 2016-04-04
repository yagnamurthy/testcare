var CaregiversCollection;

window.CaregiversCollection = CaregiversCollection = (function() {
  function CaregiversCollection(zipcode, page, sort, params) {
    this.zipcode = zipcode;
    this.page = page || 1;
    this.sort = sort || 1;
    this.params = params;
  }

  CaregiversCollection.prototype.fetch = function() {
    var params;
    params = {
      zipcode: this.zipcode,
      sort: this.sort,
      page: this.page
    };
    if (this.params) {
      params.s = this.params;
      params = $.param(params);
      return $.getJSON("/caregivers?" + params);
    } else {
      params = $.param(params);
      return $.getJSON("/caregivers?" + params);
    }
  };

  return CaregiversCollection;

})();