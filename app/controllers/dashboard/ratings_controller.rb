module Dashboard
  class RatingsController < DashboardController
    def index
      set_profile_box
      @ratings = current_user.ratings.published.includes(:client)
    end
  end
end
