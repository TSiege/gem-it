class GemifierController < ApplicationController
  def index

  end

  def create
    raise env["omniauth.auth"]
  end
end
