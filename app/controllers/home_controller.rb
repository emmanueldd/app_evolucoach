class HomeController < ApplicationController
  def index
    redirect_to dashboard_root_path if user_signed_in?
  end

end
