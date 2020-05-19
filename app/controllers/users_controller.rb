  class UsersController < ApplicationController

    def check_slug_availability
      @user = User.find_by(slug: params[:slug])
      render json: { available: @user.blank? }
    end
  end
