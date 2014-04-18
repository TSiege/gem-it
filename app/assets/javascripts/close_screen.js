function closeScreen(){
  $(".close, #close-modal").click(function{
    $("#head-swap").html(
      "<h1>Gem It</h1>" +
      "<h1 class='spacer'>___</h1>" +
      "<p class='lead'>" +
      "If you've ever worked on a ruby project and just needed a simple way to grab information from a website and use it then Gem It is here to help. All it takes are these four simple steps.<br><br>" +
      "<a href='/auth/github'>" +
      "1. Sign in with Github so we can set up a repo." +
      "</a><br>" +
      "2. Submit the URL you want us to scrape from.<br>" +
      "3. Click however many targets on that page you want.<br>" +
      "4. Fill out some details.<br><br>" +
      "From there Gem It will use all of the information you provided to make a gem just for you and your projects.</p>"
      )
  });
}