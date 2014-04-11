$( document ).ready(function() {
  $(".glyphicon-plus").on("click", function(e){
    $(this).siblings("input").attr("disabled", "disabled");
    
  });
});