$( document ).ready(function() {
  $(".glyphicon-plus").on("click", function(e){
    var glyphicon = $(this)
    var newFormField = $("<div>")
    newFormField.attr()
    
    glyphicon.siblings("input").attr("disabled", "disabled");
    glyphicon.prepend(newFormField);
  });
});