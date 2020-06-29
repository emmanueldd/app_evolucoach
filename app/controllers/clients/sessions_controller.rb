# frozen_string_literal: true

class Clients::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || resource.user
    end

    def after_sign_out_path_for(resource)
      current_lead.user
      # if cookies[:last_important_object_visited].present? && cookies[:last_important_id_visited].present?
      #   cookies[:last_important_object_visited].constantize.find(cookies[:last_important_id_visited])
      # else
      #   current_lead.user
      # end
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
