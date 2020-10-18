class UsersController < ApplicationController

  def check_slug_availability
    @user = User.find_by(slug: params[:slug])
    render json: { available: @user.blank? }
  end

  def calendly
    @user = User.find_by(slug: params[:id])
  end

  def show
    # return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    begin
      @user = User.friendly.find(params[:id])
    rescue
      return redirect_to users_path if @user.blank?
    end
    request.env['PIXEL_ID'] = @user.fb_pixel_code
    store_user_location!
    cookies[:last_user_visited_id] = @user.id

    # Crée la stat de visite si ce n'est pas current_user ou un user (autre coach) : le lead ou le client prend automatiquement le dernier user visité
    current_lead.update(user: @user) unless user_signed_in? && current_user == @user
  end

  def user_important
    @user = User.friendly.find(params[:id])
    if cookies[:last_important_object_visited].present?
      redirect_to_last_important_path_visited
    else
      redirect_to @user
    end
  end

  def index
    # return redirect_to dashboard_root_path, notice: 'Votre profil sera prochainement disponible'
    @users = User.validated
  end

end
