class HomeController < ApplicationController
  def index
    redirect_to dashboard_root_path
  end
end
