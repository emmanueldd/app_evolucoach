class AvailabilitiesController < ApplicationController

  def index
    @user = User.friendly.find(params[:user_id])
    @availabilities = @user.availabilities
    @date = DateTime.now
  end

end
