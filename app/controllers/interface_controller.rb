class InterfaceController < ApplicationController
  before_action :authenticate_client!

	def set_profile_box
		@profile_box = true
	end

end
