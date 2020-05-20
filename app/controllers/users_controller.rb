class UsersController < ApplicationController

  def check_slug_availability
    @user = User.find_by(slug: params[:slug])
    render json: { available: @user.blank? }
  end

  def show
    return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    @user = User.friendly.find(params[:id])
    redirect_to users_path if @user.blank?
  end

  def index
    return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    @users = User.validated
  end

end
