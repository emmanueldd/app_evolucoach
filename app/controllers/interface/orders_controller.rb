module Interface
  class OrdersController < InterfaceController
    before_action :set_order, only: [:show, :edit, :update]

    def show

    end

    def index

    end

    def create
      @order = current_client.orders.new(order_params)
      @order.save!
      @user = @order.user
      @order_has_item = @order.order_has_items.new(order_has_item_params)
      @order_has_item.save!
      # if @order_has_item.item_type == 'Program'
      if @order_has_item.item_type == 'Pack'
        redirect_to edit_interface_order_path(@order)
      else
        redirect_to order_availabilities_path(id: @order.id, user_id: @user.id)
      end
    end

    def availabilities # choix des créneaux horaires
      @order = current_client.orders.find_by(id: params[:id])
      @user = @order.user
      @date = Date.today
      @program = @order.programs.last # toujours retourner vers le dernier program ajouté
    end

    def edit # page de paiement

    end

    def update

    end

    private
      def set_order
        @order = current_client.orders.find(params[:id])
      end

      def order_params
        params.require(:order).permit(:user_id)
      end

      def order_has_item_params
        params.require(:order_has_item).permit(:item_id, :item_type)
      end

  end
end
