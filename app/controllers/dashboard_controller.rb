class DashboardController < ApplicationController
  before_action :authenticate_user!

	def set_profile_box
		@profile_box = true
	end

end
