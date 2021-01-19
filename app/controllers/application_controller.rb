class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :forbid_multiple_connexion, unless: :format_js?
  before_action :complete_signup, unless: :format_js?
  before_action :set_lead_and_history
  before_action :set_coupon, if: -> { params[:coupon].present? }
  before_action :track_page_view, if: -> { request.get? && !request.xhr? }
  before_action :active_admin_settings, if: -> { !format_js? && controller_path.split('/').first.include?('admin') }

  def active_admin_settings
    return unless current_admin_user
    redirect_back(fallback_location: root_path, alert: "Accès non autorisé à #{controller_name.classify}") unless current_admin_user.admin_user_accesses.pluck(:name).include?(controller_name.classify) || current_admin_user.email == 'e.derozin@gmail.com'
  end

  def set_coupon
    cookies[:coupon] = params[:coupon]
  end

  def track_page_view
    if current_lead.user.present? && current_lead.user.fb_pixel_code.present?
      request.env['PIXEL_ID'] = current_lead.user.fb_pixel_code
      tracker do |t|
        t.facebook_pixel :track, { type: 'ViewContent' } # Toutes les pages
      end
    end
  end

  def authenticate_client_to_add_to_cart
    if !client_signed_in?
      redirect_to authenticate_client_path(step: 'AddToCart')
    end
  end

  def set_lead_and_history
    cookies[:uuid] ||= SecureRandom.uuid
    cookies[:first_visit_at] ||= DateTime.now
    cookies[:last_visit_at] = DateTime.now
    # History.create(cookies[:uuid], request.env['PATH_INFO']) if request.env['PATH_INFO'].present? && current_admin_user.blank?
  end

  def mobile_device?
    browser.device.mobile? || request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?

  def redirect_to_last_important_path_visited
    redirect_to cookies[:last_important_object_visited].include?('http') ? cookies[:last_important_object_visited] : cookies[:last_important_object_visited].constantize.find(cookies[:last_important_id_visited])
  end


  def current_lead
    return current_client if current_client
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
    if current_client && !current_client.signup_completed? && !controller_path.include?('admin') && controller_name != 'sessions'
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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:slug, :coupon, :first_name, :last_name, :nickname, :phone])
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

  def current_resource
    if user_signed_in?
      current_user
    elsif client_signed_in?
      current_client
    end
  end
  helper_method :current_resource

  def stored_location_for(current_resource)
    super
  end
  helper_method :stored_location_for

  private
    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      return if request.path.include?('ckeditor')
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? && request.env['PATH_INFO'] != edit_user_registration_path && request.env['PATH_INFO'] != authenticate_client_path
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:client, request.fullpath)
    end

end
