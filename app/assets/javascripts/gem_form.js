$( document ).ready(function() {
  switchFormTabs();
  addFormFields();
  switchToGemIt();
  switchToGetIt();
});

function switchToGemIt() {
  $(".switch-to-gem-it").click(function(){
    $("ul.list-inline li").toggleClass("active");
    $("#gem-info").show();
    $("#gem-methods").hide();
  });
}

function switchToGetIt() {
  $(".switch-to-get-it").click(function(){
    $("#gem-info").hide();
    $("#gem-methods").show();
  });
}

function switchFormTabs() {
    $("ul.list-inline li").click(function(){
    $("li.active").removeClass();
    $(this).addClass("active");
  });
}

function addFormFields() {
  $(".glyphicon-plus").on("click", function(e){
    $("div#last-gem-method").removeAttr("id")
    var glyphicon = $(this)
    var newFormDiv = $("<div>")
    newFormDiv.attr("id", "last-gem-method");

    var newFormField = '<label for="method_name[]">Method Name</label>' +
      '<input class="form-control" id="last-method-field" name="method_name[]" type="text" value=""><br>' +
      '<label for="method-data">Is this the data you want?</label>' +
      '<p><span class="last-data-field"></span></p>' +
      '<input class="last_path" name="last_path[]" type="hidden" value="">';

    newFormDiv.append(newFormField);

    $("label[for='method-data-1']").text("This is the data you want.")

    glyphicon.parent().removeAttr();
    $("#gem-methods").find("input").each(function(){
        $(this).attr("readonly", "readonly");
    });
    glyphicon.before(newFormDiv);
  });
}