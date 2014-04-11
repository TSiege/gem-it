$( document ).ready(function() {
  addListenersToIframe();
});


function addListenersToIframe() {
  var $lastDataField = $("#last-data-field");
  var $lastPathField = $("#last-path-field");
  $("iframe").contents().find("html").each(function() {
    $(this).bind("click", function(e) { 
      e.preventDefault();
      var t = e.target.innerHTML;
      var p = getPathTo(e.target)
      $lastDataField.text(t);
      $lastPathField.val(p);
      if( $('#iframe-side-helper').is(':visible') ) {
        $('#iframe-side-helper').hide();
        $('#gem-form-column').show();
      }
    });
  });
}


// check the element
// if it has an id 

function getPathTo(element) {
    if (element.id!=='')
        return 'id("'+element.id+'")';
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