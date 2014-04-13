// need to figure out a drier way to execute these validations

function hiddenFieldValidatorOnNextOrGemIt(){
  if ($("#last-gem-method input[type='hidden']").val() == "") {
    $("input#last-method-field").siblings("#hidden-input-error").show();
  }
  else {
    $("input#last-method-field").siblings("#hidden-input-error").hide();
    switchToGemItFunctions();
  }
}

function methodNameUniquenessOnNextOrGemIt (){
  var notUniquetest = methodNameUnique();
  if (notUniquetest) {
    hideAllErrorMessages();
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").hide();
    hiddenFieldValidatorOnNextOrGemIt();
  }
}

function methodNameLengthValidationOnNextOrGemIt() {
  if ($("input#last-method-field").val().length < 3) {
    hideAllErrorMessages();
    $("input#last-method-field").siblings("span#method-name-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-error").hide();
    methodNameUniquenessOnNextOrGemIt();
  }
}