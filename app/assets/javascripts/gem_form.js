$( document ).ready(function() {
  switchFormTabs();
  glyphiconPlusListener()
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

// methods for validating and adding form fields

function addFormFields() {
  $("div#last-gem-method").removeAttr("id")
  $("input#last-method-field").removeAttr("id")
  var $glyphicon = $(".glyphicon-plus")
  var $newFormDiv = $("<div>")
  $newFormDiv.attr("id", "last-gem-method");

  var newFormField = '<label for="method_name[]">Method Name</label>' +
    '<span class="error-message" id="method-name-error" style="display: none;"><br> A Method Name Can\'t be less than 3 characters.</span>' +
    '<span class="error-message" id="method-name-uniqueness-error" style="display: none;"><br> A Method Name Can\'t be less than 3 characters.</span>' +
    '<input class="form-control" id="last-method-field" name="method_name[]" type="text" value=""><br>' +
    '<label for="method-data">Is this the data you want?</label>' +
    '<span class="error-message" id="hidden-input-error" style="display: none;"><br> You must pick a target before adding more fields.</span>' +
    '<p><span class="last-data-field"></span></p>' +
    '<input class="last_path" name="last_path[]" type="hidden" value="">';

  $newFormDiv.append(newFormField);

  $("label[for='method-data-1']").text("This is the data you want.")

  $glyphicon.parent().removeAttr();
  $("#gem-methods").find("input").each(function(){
      $(this).attr("readonly", "readonly");
  });
  $glyphicon.before($newFormDiv);
  $("span#method-name-error").hide();
}

function hiddenFieldValidator(){
  if ($("#last-gem-method input[type='hidden']").val() < 1) {
    $("#hidden-input-error").show();
  }
  else {
    $("#hidden-input-error").remove();
    addFormFields();
  }
}

function methodNameUniqueness() {
  if ($("input#last-method-field").val().length < 3) {
    $("span#method-name-error").show();
  }
  else {
    $("span#method-name-error").remove();
    hiddenFieldValidator();
  }
}

function methodNameLengthValidation() {
  if ($("input#last-method-field").val().length < 3) {
    $("span#method-name-error").show();
  }
  else {
    $("span#method-name-error").remove();
    methodNameUniqueness();
  }
}

function glyphiconPlusListener() {
  $(".glyphicon-plus").on("click", function(e){
    methodNameLengthValidation();
  });
}