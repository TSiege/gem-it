class GemifierController < ApplicationController
  def index
    @file = File.new("app/views/layouts/application.html.erb")
    # render "omniauth_success" if session[:token]
  end

  def create_iframe
    # @iframe = IframeContainer.new(params)
    # @iframe.to_s
    @page = params[:website] !~ /http/ ? "http://#{params[:website]}" : params[:website] 
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
      f.js
    end
  end

  def create
    @client = Octokit::Client.new(:access_token => session[:token])
    raise "error" if @client.repository?(params[:repo_name])
    @gemifier = Gemifier.new(@client, params)
    @gemifier.scaffold

    reset_session

    respond_to do |f|
      @gem_name = params[:gem_name] #for modal
      f.html {render :success_modal}
      f.js
    end
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end

end
