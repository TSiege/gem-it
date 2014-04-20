$( document ).ready(function() {
  clearAndRemoveMethodForms();
});

function clearAndRemoveMethodForms(){
  $(".fa-minus-square-o").click(function(){
    var $firstMethodForm = $(".fa-icon-container + div");
    if($firstMethodForm.attr("id") !== "last-gem-method") {
      $firstMethodForm.remove();
      $(".last-data-field, #last-method-field").text("");
      hideAllMethodNameErrorMessages();
      clearAndRemoveMethodForms();
    }
    else {
      $(".last-data-field, #last-method-field").text("");
      hideAllMethodNameErrorMessages();
    }
  });
}