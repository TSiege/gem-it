class GemifierController < ApplicationController
  def index
    render "omniauth_success" if session[:token]
  end

  def create
    client = Octokit::Client.new(:access_token => session[:token])
    client.create_repo(params["repo_name"], {description: params[:description], :private => false})
    reset_session
    flash[:notice] = "#{params["repo_name"]} was successfully gemified"
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end
end
