$( document ).ready(function() {
  addListenersToIframe();
});


function addListenersToIframe() {
  $("iframe").contents().find("html").each(function() {
    $(this).bind("click", function(e) { 
      e.preventDefault();
      var t = e.target.innerHTML;
      var p = getPathTo(e.target)
      $("#last-gem-method .last-data-field").text(t);
      $("#last-gem-method .last_path").val(p);
      if( $('#iframe-side-helper').is(':visible') ) {
        $('#iframe-side-helper').hide();
        $('#tab-bar').show();
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