$( document ).ready(function() {
  addSelect2Listener();
  addSelectElementsStylesListener();
});

function addSelectElementsStylesListener() {
  $(".switch-to-css-it").click(function(){
    unbindListenersFromIframe();
    selectElementsStyles();
  });
}

function selectElementsStyles() {
  $("iframe").contents().find("html").each(function() {
    $(this).bind("click", function(e) { 
      e.preventDefault();
      var userSelectedProperties = $("#css-property-selections").val().split(","),
          selectedElementStyles = $(e.target).getStyles(userSelectedProperties);
      printStylesOf(selectedElementStyles);
    });
  });
}

function printStylesOf(uniqueStyleObject){
  var styleString = "";
  for (var prop in uniqueStyleObject) {
    styleString += ("<b>" + prop + ":</b> " + uniqueStyleObject[prop] + ";<br>");
  }
  $("p.lead.computed-css").html(styleString);
}

function addSelect2Listener(){
  $("#css-property-selections").select2({
    tags:["background", "border", "border-radius", "box-shadow", "box-sizing",
          "color", "cursor", "opacity", "font", "height", "letter-spacing",
          "line-height", "list-style", "max-height", "max-width", "min-height",
          "min-width", "outline", "overflow", "padding", "position", "text-align",
          "text-decoration", "text-indent", "text-shadow", "text-transform",
          "vertical-align", "visibility", "white-space", "width", "word-spacing",
          "word-wrap", "z-index", "zoom,"],
    tokenSeperators: [",", " "]
  });
}