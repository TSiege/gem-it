class GemifierController < ApplicationController
  def index
    render "omniauth_success" if session[:token]
  end

  def create
    @client = Octokit::Client.new(:access_token => session[:token])
    @client.create_repo(params["repo_name"])
  end

  def omniauth
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
    redirect_to "/"
  end
end
