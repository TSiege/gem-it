$( document ).ready(function() {
  addListenersToIframe();
  bindNewSelectorToIframe();
});

function addListenersToIframe() {
  getDataFromIframeBy("Text");
  activateSelectorBy("Text");
}

function bindNewSelectorToIframe() {
  $(".fa-align-left, .fa-link, .fa-picture-o").click(function(e){
    unbindListenersFromIframe();
    var usersChoice = $(this).children().text();
    getDataFromIframeBy(usersChoice);
    activateSelectorBy(usersChoice);
  });
}

function getDataFromIframeBy(dataType) {
  $("iframe").contents().find("html").each(function() {
    $(this).bind("click", function(e) { 
      e.preventDefault();
      var eTarget = e.target,
        data = getDataBy(dataType, eTarget),
        path = linkPathCorrector(dataType, getPathTo(eTarget));
      $("#last-gem-method .last-data-field").text(data);
      if(eTarget.classList[0] === "gem-it-iframe") {
        var correctIframePath = path.replace(/video/, "iframe");
        $("#last-gem-method .last_path").val(correctIframePath);
      } else {
        $("#last-gem-method .last_path").val(path);
      }
      $("#last-gem-method .method_datatypes").val(dataType);
      dataSelectorErrorListener();
    });
  });
}

function getDataBy(dataType, eTarget) {
  if (dataType === "Text"){
    return eTarget.innerText || eTarget.textContent || "No text here.";
  }
  else if(dataType === "Links") {
    return eTarget.href || eTarget.parentNode.href || "No links here.";
  }
  else {
    return eTarget.src || "No media here.";
  }
}

function linkPathCorrector(dataType, path) {
  if (dataType === "Links") {
    if(path.match(/.+a\[\d\]/) instanceof Array)
      return path.match(/.+a\[\d\]/)[0];
    else {
      return path.match(/.+a\[\d\]/);
    }
  } else {
    return path;
  }
}

function getPathTo(element) {
  if (element.id!=='')
    return 'id(\"'+element.id+'\")';
  if (element===document.body)
    return element.tagName.toLowerCase();

  var ix= 0;
  var siblings= element.parentNode.childNodes;
  for (var i= 0; i<siblings.length; i++) {
    var sibling= siblings[i];
    if (sibling===element)
      return getPathTo(element.parentNode)+'/'+element.tagName.toLowerCase()+'['+(ix+1)+']';
    if (sibling.nodeType===1 && sibling.tagName===element.tagName)
      ix++;
  }
}

function dataSelectorErrorListener(){
  var selectorErrors = [
    "No text here.", "No links here.", "No media here."
  ];
  var $usersChoice = $("#last-gem-method .last-data-field");
  if ($.inArray($usersChoice.text(), selectorErrors) > -1){
    $usersChoice.addClass("error-message");
  }
  else {
    $usersChoice.removeClass("error-message");
  }
}

function activateSelectorBy(dataType) {
  var $selectors = $(".fa-align-left, .fa-link, .fa-picture-o");
  $selectors.removeClass("fa-active");
  if (dataType === "Text"){
    $selectors[0].classList.add("fa-active");
  }
  else if(dataType === "Links") {
    $selectors[1].classList.add("fa-active");
  }
  else {
    $selectors[2].classList.add("fa-active");
  }
}

function unbindListenersFromIframe() {
  $("iframe").contents().find("html").each(function() {
    $(this).unbind();
  });
}