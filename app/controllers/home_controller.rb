class HomeController < ApplicationController
  def index
    redirect_to dashboard_root_path if user_signed_in?
    redirect_to interface_root_path if client_signed_in?
  end

end
