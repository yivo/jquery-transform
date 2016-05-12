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
    var isNumeric, transformProperty;
    isNumeric = $.isNumeric;
    transformProperty = 'transform';
    $(function() {
      var el, hash, prop;
      el = document.createElement('div');
      if (el.style[transformProperty] == null) {
        hash = {
          mozTransform: '-moz-transform',
          msTransform: '-ms-transform',
          webkitTransform: '-webkit-transform',
          WebkitTransform: '-webkit-transform'
        };
        for (prop in hash) {
          if (!(el.style[prop] != null)) {
            continue;
          }
          transformProperty = hash[prop];
          return;
        }
      }
    });
    $.fn.transform = function(transformation) {
      var allNumeric, allPresent, el, i, j, len, length, unit, value;
      length = arguments.length;
      if (length < 2) {
        return this;
      }
      i = 0;
      allNumeric = true;
      allPresent = true;
      while (++i < length && (allNumeric || allPresent)) {
        if (!isNumeric(arguments[i])) {
          allNumeric = false;
        }
        if (!arguments[i] && arguments[i] !== 0) {
          allPresent = false;
        }
      }
      if (allNumeric || allPresent) {
        value = transformation + "(";
        i = 0;
        while (++i < length) {
          unit = isNumeric(arguments[i]) ? 'px' : '';
          value += "" + arguments[i] + unit + ((i + 1) < length ? ',' : '') + " ";
        }
        value += ')';
      } else {
        value = '';
      }
      if (value != null) {
        for (j = 0, len = this.length; j < len; j++) {
          el = this[j];
          el.style[transformProperty] = value;
        }
      }
      return this;
    };
    $.fn.translate = function() {
      if (arguments.length === 2) {
        return this.transform('translate', arguments[0], arguments[1]);
      } else if (arguments.length === 1) {
        return this.transform('translate', arguments[0]);
      }
    };
    $.fn.translate3d = function() {
      if (arguments.length === 3) {
        return this.transform('translate3d', arguments[0], arguments[1], arguments[2]);
      } else if (arguments.length === 2) {
        return this.transform('translate3d', arguments[0], arguments[1]);
      } else if (arguments.length === 1) {
        return this.transform('translate3d', arguments[0]);
      }
    };
  });

}).call(this);
