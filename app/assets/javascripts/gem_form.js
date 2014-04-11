$( document ).ready(function() {

  $(".glyphicon-plus").on("click", function(e){
    $("div#last-gem-method").removeAttr("id")
    var glyphicon = $(this)
    var newFormDiv = $("<div>")
    newFormDiv.attr("id", "last-gem-method");

    var newFormField = '<label for="method-name-1">Method Name</label>' +
      '<input class="form-control" id="last-method-field" name="method-name-1" type="text" value=""><br>' +
      '<label for="method-data-1">Is this the data you want?</label>' +
      '<p><span id="last-data-field"></span></p>' +
      '<input id="last-path-field" name="last-path-field" type="hidden" value="">';

    newFormDiv.append(newFormField);

    glyphicon.parent().removeAttr();
    $("#gem-methods").find("input").each(function(){
        $(this).attr("disabled", "disabled");
    });
    glyphicon.before(newFormDiv);
  });

});




