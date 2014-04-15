function switchToGemIt() {
  $(".switch-to-gem-it").click(function(){
    // checks if when you switch that you didn't select data
    // w/o giving it a method name or vice versa
    var methodDataBlank = (function(){return $("#last-gem-method input[type='hidden']").val() == ""}());
    var methodNameBlank = (function(){return $("input#last-method-field").val() == ""}());
    if (methodDataBlank && methodNameBlank) {
      switchToGemItFunctions();
    }
    else {
      methodNameLengthValidationOnNextOrGemIt();
    }
  });
}

function switchToGetIt() {
  $(".switch-to-get-it").click(function(){
    $("#gem-info").hide();
    $("#gem-methods").show();
    return toggleFormTabsClass();
  });
}

function toggleFormTabsClass() {
  $("ul.list-inline li").toggleClass("active");
}

function switchToGemItFunctions() {
  console.log("sdf");
  $("#gem-info").show();
  $("#gem-methods").hide();
  return toggleFormTabsClass();
}