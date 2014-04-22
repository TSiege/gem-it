(function($){

  $.fn.getStyles = function(only, except){
    var product = {};
    var style;
    var name;

    if(only && only instanceof Array){

      for(var i = 0, l = only.length; i < l; i++){
        name = only[i];
        product[name] = this.css(name);
      }

    } else {

      var dom = this.get(0);

      if (window.getComputedStyle) {

        if (style = window.getComputedStyle(dom, null)) {
          var value;
          if (style.length) {
            for (var i = 0, l = style.length; i < l; i++) {
              name = style[i];
              value = style.getPropertyValue(name);
              product[name] = value;
            }
          } else {
            for (name in style) {
              value = style.getPropertyValue(name) || style[name];
              product[name] = value;
            }
          }
        }
      }
      else if (style = dom.currentStyle) {
        for (name in style) {
          product[name] = style[name];
        }
      }
      else if (style = dom.style) {
        for (name in style) {
          if (typeof style[name] != 'function') {
            product[name] = style[name];
          }
        }
      }

    }

    if(except && except instanceof Array){
      for(var i = 0, l = except.length; i < l; i++){
        name = except[i];
        delete product[name];
      }
    }

    return product;

  };
  $.fn.copyCSS = function(source, only, except){
    var styles = $(source).getStyles(only, except);
    this.css(styles);

    return this;
  };
})(jQuery);