class GemifierController < ApplicationController
  after_action :remove_temp, :only => [:create_iframe]

  def index
    @file = File.new("app/views/layouts/application.html.erb")
    # render "omniauth_success" if session[:token]
  end

  def create_iframe
    @page = params[:website]
    @page = "http://#{@page}" if @page !~ /http/
    @doc = open(@page)
    digest = Digest::MD5.hexdigest(@page)
    @file = File.new("public/tmp/#{digest}.html")
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
    @repo = @client.create_repo(params[:repo_name], {description: params[:description], :private => false})
    @values = create_hash(params[:method_name], params[:last_path])
    @gemifier = Gemifier.new(
      params[:gem_name], 
      @client.user.login, 
      params[:url],
      params[:email], 
      @client, 
      @values, 
      params[:description],
      @repo
    )

    @gem_name = params[:gem_name]
    @gemifier.scaffold
    # reset_session
    respond_to do |f|
      f.html {render :success_modal}
      f.js
    end
    # flash[:notice] = "#{params[:repo_name]} was successfully gemified"
    # redirect_to "/"
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end

  private



  def create_hash(labels, node_paths)
    labels.collect.with_index do |label, i|
      if !label.empty? && !node_paths[i].empty?
        {label => node_paths[i]}
      end  
    end 
  end
    
end
