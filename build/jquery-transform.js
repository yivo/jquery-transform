(function() {
  (function(factory) {
    var root;
    root = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : void 0;
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      define(['jquery', 'exports'], function($) {
        return factory(root, $);
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(root, require('jquery'));
    } else {
      factory(root, root.$);
    }
  })(function(__root__, $) {
    $.fn.transform = function(transformation, x, y) {
      var value;
      switch (arguments.length) {
        case 2:
          value = $.isNumeric(x) ? transformation + "(" + x + "px)" : x ? transformation + "(" + x + ")" : '';
          break;
        case 3:
          value = transformation + "(";
          value += $.isNumeric(x) ? x + "px, " : (x || '') + ", ";
          value += $.isNumeric(y) ? y + "px" : y || '';
          value += ')';
      }
      if (value != null) {
        this.css({
          '-moz-transform': value,
          '-ms-transform': value,
          '-webkit-transform': value,
          'transform': value
        });
      }
      return this;
    };
    $.fn.translate = function() {
      var args;
      args = ['translate'];
      if (arguments.length > 0) {
        args.push(arguments[0]);
      }
      if (arguments.length > 1) {
        args.push(arguments[1]);
      }
      return this.transform.apply(this, args);
    };
  });

}).call(this);
