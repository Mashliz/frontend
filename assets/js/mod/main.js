var Masa;

$(function() {
  return new Masa();
});

Masa = (function() {
  function Masa(test) {
    this.test = test;
    this.btn = $(".btn");
    this.text = "testest";
    this.init();
  }

  Masa.prototype.init = function() {
    return this.cl();
  };

  Masa.prototype.cl = function(b) {
    return this.btn.on("click", (function(_this) {
      return function() {
        return alert(_this.text);
      };
    })(this));
  };

  return Masa;

})();
