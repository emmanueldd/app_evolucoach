class HomeController < ApplicationController
  def index
    if Rails.env.production?
      redirect_to 'https://formation.evolucoach.com'
    else
      redirect_to dashboard_root_path
    end
  end

end
