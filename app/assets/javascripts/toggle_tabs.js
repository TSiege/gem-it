function switchToGemIt() {
  $(".switch-to-gem-it").click(function(e){
    e.preventDefault();
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
  $(".switch-to-get-it").click(function(e){
    e.preventDefault();
    if(!$(".switch-to-get-it").parent().hasClass("active")){
      $("#gem-info").hide();
      $("#gem-methods").show();
      return toggleFormTabsClass();
    }
  });
}

function toggleFormTabsClass() {
  $("ul.list-inline li").toggleClass("active");
}

function switchToGemItFunctions() {
  if(!$(".switch-to-gem-it").parent().hasClass("active")){
    $("#gem-info").show();
    $("#gem-methods").hide();
    return toggleFormTabsClass();
  }
}