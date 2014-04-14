$( document ).ready(function() {
  sessionChecker();
});

function sessionChecker() {
  $("#get-it-btn").click(function(e){
    if(session === false) {
      $("#session-error").show();
    }
    else {
      $("#session-error").hide();
      $("#website-form").submit();
    }
  });

  $("#small-get-it").click(function(e){
    if(session === false) {
      $("#session-error").show();
    } else {
      $("#session-error").hide();
      $("#small-form").submit();
    }
  });
}