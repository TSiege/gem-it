class GemifierController < ApplicationController
  after_action :remove_temp, :only => [:create_iframe]

  def index
    @file = File.new("app/views/layouts/application.html.erb")
    @session = session[:token] ? true : false
  end

  def create_iframe

    @iframe_file = Concerns::IframeContentCreator.new(params)
    @iframe_file.create_iframe_file

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

<<<<<<< HEAD
  private



  def create_hash(labels, node_paths)
    labels.collect.with_index do |label, i|
      if !label.empty? && !node_paths[i].empty?
        {label => node_paths[i]}
      end  
    end 
  end
    
=======
>>>>>>> 3129c70d0d2eea2f855df12c1f4ca05eb4375078
end
