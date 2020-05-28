  module Interface
  class HomeController < InterfaceController

    def index
      @profile_home = true
      # TODO : a simplifier
      @programs = Program.where(id: current_client.order_has_items.joins(:order).where(item_type: 'Program', orders: {status: 'paid'}).pluck(:item_id))
      @courses = Course.coming.where(order_id: current_client.orders.paid)
    end

  end
end
