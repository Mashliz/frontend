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
  function Js() {
    this.btn = $(".btn");
    this.init();
  }

  Js.prototype.init = function() {
    return this.test();
  };

  Js.prototype.test = function() {
    return this.btn.on("click", function() {
      return alert("worked");
    });
  };

  return Js;

})();
