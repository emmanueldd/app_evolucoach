class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :forbid_multiple_connexion, unless: :format_js?
  before_action :complete_signup, unless: :format_js?
  before_action :set_lead_and_history

  def set_lead_and_history
    cookies[:uuid] ||= SecureRandom.uuid
    cookies[:first_visit_at] ||= DateTime.now
    cookies[:last_visit_at] = DateTime.now
    # History.create(cookies[:uuid], request.env['PATH_INFO']) if request.env['PATH_INFO'].present? && current_admin_user.blank?
  end

  def current_lead
    if params[:email].present?
      lead = Lead.find_or_initialize_by(email: params[:email])
      cookies[:uuid] = lead.uuid if lead.present?
    end
    lead ||= Lead.find_or_initialize_by(uuid: cookies[:uuid])
    lead.save! if lead.new_record?
    return lead
  end
  helper_method :current_lead

  def complete_signup
    if current_client && !current_client.signup_completed?
      if controller_path != "interface/clients"
        redirect_to edit_interface_client_path(current_client)
      end
    end
  end

  def forbid_multiple_connexion
    if current_user && current_user.current_sign_in_at.present? && current_client && current_client.current_sign_in_at.present?
      if current_user.current_sign_in_at > current_client.current_sign_in_at
        sign_out current_client
      else
        sign_out current_user
      end
    end
  end

  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:slug, :first_name, :last_name, :nickname, :phone])
      devise_parameter_sanitizer.permit(:account_update, keys: [:slug, :first_name, :last_name, :nickname, :avatar, :phone, :address, :instagram_url, :city, :address, :country, :zipcode])
    elsif resource_class == Client
      devise_parameter_sanitizer.permit(:sign_up, keys: [:lead_id, :user_id, :slug, :first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:lead_id, :user_id, :slug, :first_name, :last_name, :nickname, :avatar, :phone, :address, :instagram_url, :city, :address, :country, :zipcode, :birth_date])
    end
  end

  def format_js?
    request.format.js?
  end

  def format_json?
    request.format.json?
  end

end
