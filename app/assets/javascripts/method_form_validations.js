$( document ).ready(function() {
  glyphiconPlusListener();
});
  var regEx = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/

// methods for validating and adding form fields

function addFormFields() {
  $("div#last-gem-method").removeAttr("id")
  $("input#last-method-field").removeAttr("id")
  var $glyphicon = $(".glyphicon-plus")
  var $newFormDiv = $("<div>")
  $newFormDiv.attr("id", "last-gem-method");

  var newFormField = '<label for="method_name[]">Method Name</label>' +
    '<span class="error-message" id="method-name-error" style="display: none;"><br> A method name can\'t be less than 3 characters.</span>' +
    '<span class="error-message" id="method-name-uniqueness-error" style="display: none;"><br> Method names must be unique.</span>' +
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
  var $lastMethodName = $("input[name='method_name[]']").last();
  if ($("input#last-method-field").val().length < 3) {
    $("span#method-name-uniqueness-error").show();
  }
  else {
    $("span#method-name-uniqueness-error").remove();
    hiddenFieldValidator();
  }
}

function methodNameLengthValidation() {
  if ($("input#last-method-field").val().length < 3) {
    $("span#method-name-error").show();
  }
  else {
    $("span#method-name-error").remove();
    addFormFields();
    // methodNameUniqueness();
  }
}

function glyphiconPlusListener() {
  $(".glyphicon-plus").on("click", function(e){
    methodNameLengthValidation();
  });
}