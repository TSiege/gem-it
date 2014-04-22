function switchToGemIt() {
  $(".switch-to-gem-it").click(function(e){
    e.preventDefault();

    if (testBlanknessOf("#last-gem-method input[type='hidden']") &&
     testBlanknessOf("input#last-method-field")) {
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
    unbindListenersFromIframe();
    var defaultChoice = "Text";
    getDataFromIframeBy(defaultChoice);
    activateSelectorBy(defaultChoice);
    return switchToGetItFunctions();
  });
}

function switchToGetItFunctions(){
  var $getIt = $("a.switch-to-get-it");
  if(!$getIt.parent().hasClass("active")){
    removeActiveFromTabs();
    $("#gem-info, #css-info").hide();
    $("#gem-methods").show();
    $getIt.parent().addClass("active");
  }
}

function removeActiveFromTabs() {
  $("ul.list-inline li").removeClass("active");
}

function switchToGemItFunctions() {
  var $gemIt = $("li .switch-to-gem-it");
  if(!$gemIt.parent().hasClass("active")){
    removeActiveFromTabs();
    $("#gem-methods, #css-info").hide();
    $("#gem-info").show();
    $gemIt.parent().addClass("active");
  }
}

function switchToCssIt() {
  $(".switch-to-css-it").click(function(e){
    e.preventDefault();
    var $cssIt = $(".switch-to-css-it");
    if(!$cssIt.parent().hasClass("active")){
      removeActiveFromTabs();
      $("#gem-info, #gem-methods").hide();
      $("#css-info").show();
      $cssIt.parent().addClass("active");
    }
  });
}