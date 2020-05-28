module Interface
  class OrdersController < InterfaceController
    before_action :set_order, only: [:show, :edit, :update, :availabilities]

    def show
    end

    def index

    end

    def create
      # begin dégueulasse
      @order = current_client.orders.new(order_params)
      @order.save!
      @user = @order.user
      @order_has_item = @order.order_has_items.new(order_has_item_params)
      @order_has_item.save!
      @order.set_credit
      # end dégueulasse

      # if @order_has_item.item_type == 'Program'
      if @order_has_item.item_type == 'Program'
        redirect_to edit_interface_order_path(@order)
      else # if @order_has_item.item_type == 'pack'
        redirect_to order_availabilities_path(id: @order.id, user_id: @user.id)
      end
    end

    def availabilities # choix des créneaux horaires
      @user = @order.user
      @date = DateTime.now
      @program = @order.programs.last # toujours retourner vers le dernier program ajouté
    end

    def edit # page de paiement
      @stripe = true
      @user = @order.user

      @order.set_total_price
      @order.save!

      stripe_intent = Stripe::PaymentIntent.create({
        amount: @order.total_price,
        customer: current_client.find_stripe_customer_id,
        receipt_email: current_client.email,
        currency: 'eur',
        payment_method_types: ['card'],
        capture_method: 'automatic',
        description: "https://evolucoach.com/admin/orders/#{@order.id}",
        setup_future_usage: 'off_session'
      })
      @client_secret = stripe_intent.client_secret
    end

    def update
      @order.assign_attributes(order_params)
      @order.status = 'paid'
      if @order.save!
        redirect_to [:interface, @order]
      end
    end

    private
      def set_order
        @order = current_client.orders.find(params[:id])
      end

        # def order_params
        #   params.require(:order).permit(:user_id)
        # end

      def order_params
        params.require(:order).permit(:user_id, :coupon_text, :card_token, :card_name, :pack_id, order_has_courses_attributes: [:course_id, :order_id], courses_attributes: [:availability_id, :id, :order_id, :start_time, :status, :my_checkbox, :_destroy])
      end

      def order_has_item_params
        params.require(:order_has_item).permit(:item_id, :item_type)
      end

  end
end
