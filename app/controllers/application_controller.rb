class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:slug, :first_name, :last_name, :nickname, :slug])
      devise_parameter_sanitizer.permit(:account_update, keys: [:slug, :first_name, :last_name, :nickname, :avatar, :phone, :address, :instagram_url, :city, :address, :country, :zipcode])
    # elsif resource_class == Pro
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:expo_token_id, :dpt, :first_name, :last_name, :nickname, :avatar, :phone])
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:app_version, :expo_token_id, :dpt, :siret, :first_name, :last_name, :nickname, :instagram_url, :avatar, :phone, :address, :city, :moves, :at_home, moves_to: [], payment_information_attributes: [:rib, :passport, :social_security_number, :pro_id]])
    end
  end
end
