module Interface
  class OrdersController < InterfaceController
    before_action :set_order, only: [:show, :edit, :update]

    def show

    end

    def index

    end

    def create
      # @order = current_client.orders.new()
      # @order.save!
      # @order_has_item @order.order_has_items.new(item: )
      redirect_to edit_interface_order_path(@order)
    end

    def edit

    end

    def update

    end

    private
      def set_order
        @order = current_client.orders.find(params[:id])
      end

  end
end
