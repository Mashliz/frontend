var Js, cl;

(function($) {
  return $(function() {
    return new Js();
  });
})(jQuery);

cl = function(o) {
  return console.log(o);
};

Js = (function() {
  function Js(test) {
    this.test = test;
    this.btn = $(".btn");
    this.text = "testest";
    this.init();
  }

  Js.prototype.init = function() {
    return this.cl();
  };

  Js.prototype.cl = function(b) {
    return this.btn.on("click", (function(_this) {
      return function() {
        return alert(_this.text);
      };
    })(this));
  };

  return Js;

})();
