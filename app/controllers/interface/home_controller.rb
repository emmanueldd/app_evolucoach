  module Interface
  class HomeController < InterfaceController

    def index
      @profile_home = true
      # TODO : a simplifier
      @programs = current_client.programs
      @courses = Course.coming.where(order_id: current_client.orders.paid).order(start_time: :asc)
    end

  end
end
