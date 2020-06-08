class HomeController < ApplicationController
  def index
    if Rails.env.production? && !request.subdomains.include?('app')
      redirect_to 'https://formation.evolucoach.com'
    else
      redirect_to dashboard_root_path
    end
  end

end
