$( document ).ready(function() {
  resetAndRemoveMethodForms();
});

function resetAndRemoveMethodForms(){
  $(".fa-minus-square-o").click(function(){
    var $firstMethodForm = $(".fa-icon-container + div");
    if($firstMethodForm.attr("id") !== "last-gem-method") {
      $firstMethodForm.remove();
      $(".last-data-field, #last-method-field").text("");
      hideAllMethodNameErrorMessages();
      resetAndRemoveMethodForms();
    }
    else {
      $(".last-data-field, #last-method-field").text("");
      hideAllMethodNameErrorMessages();
    }
  });
}