class WelcomeController < ApplicationController

  def index

  end

  def twoohfour
    render :nothing => true, :status => 204
  end

end