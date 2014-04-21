$( document ).ready(function() {
  
});


function selectElementsStyles() {
  $("iframe").contents().find("html").each(function() {
    $(this).bind("click", function(e) { 
      e.preventDefault()
      var selectedElementStyles = $(e.target).getStyles(),
          defaultElementStyles = $("<" + e.target.tagName + ">").getStyles(),
          foundStyles = selectUniqueStylesFrom(selectedElementStyles, defaultElementStyles);
      console.log(selectedElementStyles)
      console.log(defaultElementStyles)
      console.log(foundStyles)
      printStylesOf(foundStyles);
    });
  });
}

function selectUniqueStylesFrom(targetElement, defaultElement) {
  var uniqueProperties = {};

  for (var prop in targetElement) {
    console.log("target Element: " + targetElement[prop]);
    console.log("default Element: " + defaultElement[prop]);
    if (targetElement[prop] !== defaultElement[prop] &&
      defaultElement[prop] !== "") {
      uniqueProperties[prop] = targetElement[prop];
    }
  }
  return uniqueProperties;
}

function printStylesOf(uniqueStyleObject){
  var styleString = "";
  for (var prop in uniqueStyleObject) {
    styleString += ("" + prop + ": " + uniqueStyleObject[prop] + ";\n");
  }
  $("p.lead.computed-css").text(styleString);
}