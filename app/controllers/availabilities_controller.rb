class AvailabilitiesController < ApplicationController

  def index
    @user = User.friendly.find(params[:user_id])
    @availabilities = @user.availabilities
    @date = params[:date].present? ? params[:date].to_datetime : DateTime.now
  end

end
