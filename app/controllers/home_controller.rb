class HomeController < ApplicationController

  def index
    redirect_to "/v1/definition"
  end
end
