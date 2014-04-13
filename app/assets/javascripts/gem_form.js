$( document ).ready(function() {
  switchFormTabs();
  switchToGemIt();
  switchToGetIt();
});

function switchToGemIt() {
  $(".switch-to-gem-it").click(function(){
    $("ul.list-inline li").toggleClass("active");
    $("#gem-info").show();
    $("#gem-methods").hide();
  });
}

function switchToGetIt() {
  $(".switch-to-get-it").click(function(){
    $("#gem-info").hide();
    $("#gem-methods").show();
  });
}

function switchFormTabs() {
    $("ul.list-inline li").click(function(){
    $("li.active").removeClass();
    $(this).addClass("active");
  });
}