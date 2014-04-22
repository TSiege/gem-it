$( document ).ready(function() {
  glyphiconPlusListener();
});

// methods for validating and adding form fields

function hideAllMethodNameErrorMessages() {
  $("#method-name-error, #method-name-uniqueness-error, #hidden-input-error").hide();
}

function addFormFields() {
  $("div#last-gem-method").removeAttr("id");
  $("input#last-method-field").removeAttr("id");

  var $glyphicon = $(".fa-plus-square-o"),
      $newFormDiv = $("<div>");

  $newFormDiv.attr("id", "last-gem-method");

  var newFormField = '<label for="method_name[]">Method Name</label>' +
    '<span class="error-message" id="method-name-error" style="display: none;"><br> A method name can\'t be less than 3 characters.</span>' +
    '<span class="error-message" id="method-name-uniqueness-error" style="display: none;"><br> Method names must be unique.</span>' +
    '<input class="form-control" id="last-method-field" name="method_name[]" type="text" value=""><br>' +
    '<label for="method-data">Is this the data you want?</label>' +
    '<span class="error-message" id="hidden-input-error" style="display: none;"><br> You must pick a target before adding more fields.</span>' +
    '<p><span class="last-data-field"></span></p>' +
    '<input class="last_path" name="last_path[]" type="hidden" value="">' +
    '<input class="method_datatypes" name="method_datatypes[]" type="hidden" value="">';

  $newFormDiv.append(newFormField);

  $("label[for='method-data-1']").text("This is the data you want.");

  $glyphicon.parent().removeAttr();

  $("#gem-methods").find("input").each(function(){
      $(this).attr("readonly", "readonly");
  });
  
  $glyphicon.before($newFormDiv);
  $("span#method-name-error").hide();
}

function hiddenFieldValidator(){
  if (testBlanknessOf("#last-gem-method input[type='hidden']")) {
    $("input#last-method-field").siblings("#hidden-input-error").show();
  }
  else {
    $("input#last-method-field").siblings("#hidden-input-error").hide();
    addFormFields();
  }
}

function testBlanknessOf(inputField) {
  return $(inputField).val() === "";
}

function methodNameUnique() {
  var $methodNames = $("input[name='method_name[]']");
  var methodNamesLength = ($methodNames.length - 1);
  var $lastMethodName = $methodNames.last();
  var valuesArr = $.map($methodNames, function(n,i){
    return [n.value.toLowerCase()];
  }).reverse();
  var notUnique = (function() {
    return $.inArray($lastMethodName.val(), valuesArr, 1) > -1;
  }());
  return notUnique;
}

function methodNameUniquenessOnGlyphicon (){
  var notUniquetest = methodNameUnique();
  if (notUniquetest) {
    hideAllMethodNameErrorMessages();
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").hide();
    hiddenFieldValidator();
  }
}

function methodNameLengthValidationOnGlyphicon() {
  if ($("input#last-method-field").val().length < 3) {
    hideAllMethodNameErrorMessages();
    $("input#last-method-field").siblings("span#method-name-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-error").hide();
    methodNameUniquenessOnGlyphicon();
  }
}

function glyphiconPlusListener() {
  $(".fa-plus-square-o").on("click", function(e){
    methodNameLengthValidationOnGlyphicon();
  });
}