class GemifierController < ApplicationController
  def index
    # render "omniauth_success" if session[:token]
  end

  def create_iframe
    @page = params[:website]
    @page = "http://#{@page}" if @page !~ /http/
    @doc = open(@page)
    digest = Digest::MD5.hexdigest(@page)
    @file = File.new("public/tmp/#{digest}.html", 'w')
    @content = @doc.read.gsub(/<script[^>]*>[^<]*<\/script>/, "<script></script>")
    @content = @content.gsub(/<meta[^[Xx]]*[Xx]-[Ff][rame]*[-][Oo][ptions]*[^>]*\/>/, "")
    @file.write(@content)
    @file.close
    render :page
  end

  def create_repo
    client = Octokit::Client.new(:access_token => session[:token])
    client.create_repo(params["repo_name"], {description: params[:description], :private => false})
    @gemifier = Gemifier.new
    @gemifier.scaffold(params['name'], params['name'], params['url'], params['path'], email)
    reset_session
    flash[:notice] = "#{params["repo_name"]} was successfully gemified"
    redirect_to "/"
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end
end
