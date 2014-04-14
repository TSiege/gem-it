$( document ).ready(function() {
  // validateGemItInputs();
});

function validatesGemItFields() {
  $(".gem-it-btn").click(function (e) {
    e.preventDefault();
    debugger;
    var $allInputs = $("input#repo_name, input#gem_name, input#description, input#email"),
      $allErrors = $("#hidden-repo-error, #hidden-gem-error, #hidden-description-error, #hidden-email-error"),
      regEx = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/,
      validations = [
        function(repo){ return repo.value.length < 4; },
        function(gem){ return gem.value.length < 4; },
        function(description){ return description.value.length < 15; },
        function(email){ return !regEx.test(email.value); }
      ],
      i = 0;

    $allErrors.hide();
    
    for (i; i < 4; i++) {
      if (validations[i]($allInputs[i])) {
        $allErrors[i].style.display = "inline";
      }
      else { 
        $allErrors[i].style.display = "none";
      }
    }
  });
}

// function validateGemItInputs() {
//   $(".gem-it-btn").click(function (e) {
//     console.log("clicked");
//     e.preventDefault();
//     debugger;
//     var $allInputs = $("input#repo_name, input#gem_name, input#description, input#email"),
//       $allErrors = $("#hidden-repo-error, #hidden-gem-error, #hidden-description-error, #hidden-email-error"),
//       regEx = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/,
//     validEmail = regEx.test($("input#email"));

//     $allErrors.hide();

//     if ($allInputs[0].value.length < 4) {
//       $("#hidden-repo-error").show();
//     } else if ($allInputs[1].value.length < 4) {
//       $("#hidden-gem-error").show();
//     } else if ($allInputs[2].value.length < 15) {
//       $("#hidden-description-error").show();
//     } else if (!validEmail) {
//       $("#hidden-email-error").show();
//     }
//   });
// }
