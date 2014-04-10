function reveal() {

  $("#foot").addClass("footer-down");
  $("#head").addClass("header-up");

  setTimeout(function() {
    $("#frame-bg").css({
      "position": "static",
      "transform": "translateY(-28px)"
    });
    $("#head").hide();
    $("#foot").removeClass("footer-down");

  }, 1300);

}