class UsersController < ApplicationController

  def check_slug_availability
    @user = User.find_by(slug: params[:slug])
    render json: { available: @user.blank? }
  end

  def show
    # return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    begin
      @user = User.friendly.find(params[:id])
    rescue
      return redirect_to users_path if @user.blank?
    end
    cookies[:last_user_visited_id] = @user.id
    current_lead.update(user: @user)
  end

  def index
    # return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    @users = User.validated
  end

end
