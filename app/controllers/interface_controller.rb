class InterfaceController < ApplicationController
  before_action :authenticate_client!

  def authenticate_client!
    redirect_to(new_client_registration_path, alert: 'Vous devez vous connecter ou vous enregistrer pour continuer.') unless client_signed_in?
  end

	def set_profile_box
		@profile_box = true
	end

end
