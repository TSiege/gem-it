class GemifierController < ApplicationController
  def index
    @file = File.new("app/views/layouts/application.html.erb")
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
    respond_to do |f|
      f.html {render :page}
      f.js
    end
  end

  def create_side_column
    respond_to do |f|
      f.html {render :right_side_column}
      f.js
    end
  end

  def create
    client = Octokit::Client.new(:access_token => session[:token])
    client.create_repo(params["repo_name"], {description: params[:description], :private => false})
    gemifier = Gemifier.new(params[:gem_name], client.user.login, params['url'], params['path'], params['email'], client)
    gemifier.scaffold
    
    reset_session
    flash[:notice] = "#{params["repo_name"]} was successfully gemified"
    redirect_to "/"
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end
end
