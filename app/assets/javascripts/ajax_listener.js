$(document).ready(function() {
  $("#get-it-btn").click(function() {
    $(this).parents("form").submit();
  });
});