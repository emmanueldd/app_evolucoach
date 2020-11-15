module Dashboard
  class OrdersController < DashboardController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
      @orders = current_user.orders.waiting_or_paid.includes(:client).order(created_at: :desc, paid_at: :desc).paginate(per_page: 20, page: params[:page])
    end

    def show
      # redirect to forbidden if order doesnt exist
    end

    def new
      @order = current_user.orders.new
      @client = Client.find_by(id: params[:client_id])
      if params[:item_type].present? && ['Pack', 'OnlineOffer', 'Program'].include?(params[:item_type].camelize)
        @item_type = params[:item_type].camelize
        @item_name = @item_type.constantize.show_name
        @item = @item_type.constantize.find_by(user: current_user, id: params[:item_id]) if params[:item_id].present?
        @items = @item_type.constantize.where(user: current_user).published
      end
    end

    def create
      @order = current_user.orders.new(order_params)
      @order.status = 'waiting'
      if @order.save!
        @order_has_item = @order.order_has_items.new(order_has_item_params)
        @order_has_item.save!
        redirect_to dashboard_orders_path, notice: 'Paiement crée.'
      else
        redirect_back(fallback_location: dashboard_orders_path, alert: 'Ce paiement ne peut être créer.')
      end
    end

    def edit
      # redirect to forbidden if order doesnt exist
    end

    def update
      if !@order.paid? && @order.update!(order_params)
        redirect_to dashboard_orders_path, notice: 'Paiement mis à jour.'
      else
        redirect_back(fallback_location: dashboard_orders_path, alert: 'Ce paiement ne peut être mis à jour.')
      end
    end

    def destroy
      if !@order.paid? && @order.destroy!
        redirect_to dashboard_orders_path, notice: 'Paiement supprimé.'
      else
        redirect_back(fallback_location: dashboard_orders_path, alert: 'Ce paiement ne peut être supprimé.')
      end
    end

    private
      def set_order
        @order = current_user.orders.find_by(uuid: params[:uuid])
      end

      def order_params
        params.require(:order).permit(:status, :client_id, :total_price, :credit)
      end

      def order_has_item_params
        params.require(:order_has_item).permit(:item_id, :item_type)
      end
  end
end
