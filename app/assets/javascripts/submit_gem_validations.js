$( document ).ready(function() {
  validatesGemItFields();
  repoNameFailure();
});

function validatesGemItFields() {
  $(".gem-it-btn").click(function (e) {
    var $allInputs = $("input#repo_name, input#gem_name, input#description, input#email"),
      $allErrors = $("#hidden-repo-error, #hidden-gem-error, #hidden-description-error, #hidden-email-error"),
      regEx = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/,
      validations = [
        function(repo){ return repo.value.length < 4; },
        function(gem){ return gem.value.length < 4; },
        function(description){ return description.value.length < 15; },
        function(email){ return !regEx.test(email.value); }
      ],
      i = 0,
      trigger = 0;

    $allErrors.hide();
    $("#hidden-repo-name-error").hide();
    
    for (i; i < 4; i++) {
      if (validations[i]($allInputs[i])) {
        $allErrors[i].style.display = "inline";
      }
      else { 
        $allErrors[i].style.display = "none";
        trigger++;
        if (trigger == 4) {
          $("#gem-it-form").submit();
        }
      }
    }
  });
}

function repoNameFailure(){
  $("#gem-it-form").bind("ajax:error", function(data, status, xhr){
    $("#hidden-repo-name-error").show();
  })
}