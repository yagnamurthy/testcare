var SearchForm;

window.SearchForm = SearchForm = (function() {
  SearchForm.prototype.searchObject = {};

  SearchForm.prototype.zipcode = null;

  function SearchForm(location) {
    this.searchObject = purl(location);
    this.zipcode = this.searchObject.data.seg.path[2];
  }

  SearchForm.prototype.getParams = function() {
    if (this.searchObject.data.param.query) {
      return this.searchObject.data.param.query.s;
    }
  };

  SearchForm.prototype.get = function(keyword) {
    if (keyword === 'zipcode') {
      return this.zipcode;
    } else {
      return this.searchObject.param(keyword);
    }
  };

  return SearchForm;

})();
