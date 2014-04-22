// need to figure out a drier way to execute these validations

function hiddenFieldValidatorOnNextOrGemIt(){
  if (testBlanknessOf("#last-gem-method input[type='hidden']")) {
    $("input#last-method-field").siblings("#hidden-input-error").show();
    $("#css-get-it-error").show();
  }
  else {
    $("input#last-method-field").siblings("#hidden-input-error").hide();
    $("#css-get-it-error").hide();
    switchToGemItFunctions();
  }
}

function methodNameUniquenessOnNextOrGemIt (){
  if (methodNameUnique()) {
    hideAllMethodNameErrorMessages();
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").show();
    $("#css-get-it-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-uniqueness-error").hide();
    $("#css-get-it-error").hide();
    hiddenFieldValidatorOnNextOrGemIt();
  }
}

function methodNameLengthValidationOnNextOrGemIt() {
  if ($("input#last-method-field").val().length < 3) {
    hideAllMethodNameErrorMessages();
    $("input#last-method-field").siblings("span#method-name-error").show();
    $("#css-get-it-error").show();
  }
  else {
    $("input#last-method-field").siblings("span#method-name-error").hide();
    $("#css-get-it-error").hide();
    methodNameUniquenessOnNextOrGemIt();
  }
}