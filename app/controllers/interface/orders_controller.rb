module Interface
  class OrdersController < InterfaceController
    before_action :set_order, only: [:show, :edit, :update, :availabilities, :pay, :payment]
    skip_before_action :authenticate_client!, only: :create
    before_action :authenticate_client_to_add_to_cart, only: :create

    def show
      @user = @order.user
      if params[:alma].present? && @order.alma_uncomplete?
        @order.update(alma_state: 'not_started')
      elsif !@order.paid?
        return redirect_to interface_order_payment_path(@order.uuid)
      end
      # Track if order is paid or its alma payment state is at not_started
      if @order.paid_at.blank?
        @order.update_columns(paid_at: DateTime.now)
        tracker do |t|
          t.facebook_pixel :track, {
            type: 'Purchase',
            options: { value: ( @order.total_price.to_f / 100), currency: 'EUR' }
          }
        end
      end
      #
    end

    def index

    end

    def create
      @order = current_client.orders.new(order_params)
      @order.uuid ||= SecureRandom.uuid
      @order.save!
      @user = @order.user
      @order_has_item = @order.order_has_items.new(order_has_item_params)
      @order_has_item.save!
      # Show the calendly if needed
      if @order.show_calendly_before_payment?
        redirect_to @user.calendly_url
      elsif @order_has_item.item_type == 'Pack'
        redirect_to order_availabilities_path(id: @order.uuid, user_id: @user.id)
      else # Online offer / Program
        redirect_to interface_order_payment_path(@order.uuid)
      end
    end

    def availabilities # choix des créneaux horaires
      @user = @order.user
      @date = params[:date].present? ? params[:date].to_datetime : DateTime.now
      @program = @order.programs.last # toujours retourner vers le dernier program ajouté
    end

    def payment # page de paiement
      tracker do |t|
        t.facebook_pixel :track, { type: 'InitiateCheckout' }
      end
      @stripe = true
      @user = @order.user

      @order.set_total_price
      @order.save!
      if @order.total_price > 0
        stripe_intent = Stripe::PaymentIntent.create({
          amount: @order.total_price,
          customer: current_client.find_stripe_customer_id(@user),
          receipt_email: current_client.email,
          currency: 'eur',
          payment_method_types: ['card'],
          capture_method: 'automatic',
          description: "https://evolucoach.com/admin/orders/#{@order.id}",
          setup_future_usage: 'off_session'
        }, {
          stripe_account: @user.payment_info.stripe_account_id,
        })
        @client_secret = stripe_intent.client_secret
      end
    end

    def update
      @order.update(order_params)
      head :no_content
    end

    def pay
      @order.assign_attributes(order_params)
      @order.status = 'paid'
      @order.set_credit_left
      if @order.save!
        redirect_to interface_payment_completed_path(@order.uuid)
      end
    end

    def pay_alma
      @order = Order.find_by(uuid: params[:id])
      @user = @order.user
      billing_address = params[:billing_address]
      current_lead.update(billing_address_params)
      begin
        if @user.payment_info.alma_api_key.include?('test')
          uri = URI("https://api.sandbox.getalma.eu/v1/payments")
        else
          uri = URI("https://api.getalma.eu/v1/payments")
        end
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.path)
        req["Authorization"] = "Alma-Auth #{@user.payment_info.alma_api_key}"
        req["Content-Type"] = 'text/json'
        req.body = {
          payment: {
            installments_count: 3,
            purchase_amount: @order.total_price,
            return_url: "#{interface_payment_completed_url(@order, alma: true)}",
            customer_cancel_url: "#{alma_cancel_url}",
            customer: {
              email: current_lead.email,
              first_name: current_lead.first_name,
              last_name: current_lead.last_name,
              phone: current_lead.phone
            },
            billing_address: {
              first_name: billing_address[:first_name],
              last_name: billing_address[:last_name],
              line1: billing_address[:line1],
              postal_code: billing_address[:postal_code],
              city: billing_address[:city],
              email: current_lead.email,
              phone: current_lead.phone
            }
          },
          customer: {
            email: current_lead.email,
            first_name: current_lead.first_name,
            last_name: current_lead.last_name,
            phone: current_lead.phone
          }
        }.to_json

        res = http.request(req)
        puts "response #{res.body}"
        payment = JSON.parse(res.body)
        url = payment["url"]
        @order.update(alma_payment_id: payment['id'], alma_state: 'new')
        redirect_to url
      rescue => e
        flash[:notice] = "Une erreur s\'est produite #{e}"
        puts "ALMA: Une erreur s\'est produite #{e}"
        pp payment
        redirect_back(fallback_location: interface_order_payment_path(@order.uuid))
      end
    end

    def alma_cancel
      @order = current_lead.orders.last
      if @order.present?
        redirect_to interface_order_payment_path(@order.uuid)
      else
        redirect_to current_lead.user
      end
    end

    def alma_confirm #webhook
      if @user.payment_info.alma_api_key.include?('test')
        uri = URI("https://api.sandbox.getalma.eu/v1/payments/#{params[:pid]}")
      else
        uri = URI("https://api.getalma.eu/v1/payments/#{params[:pid]}")
      end
      @order = Order.find_by(alma_payment_id: params[:pid])
      @user = @order.user
      if @order.present?
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri.path)
        req["Authorization"] = "Alma-Auth #{@user.payment_info.alma_api_key}"
        res = http.request(req)
        payment = JSON.parse(res.body)
        if payment.present?
          @order.update(alma_state: payment['state'])
        end
        render status: 200, json: { success: true } and return
      end
    end

    private
      def set_order
        @order = current_client.orders.find_by(uuid: params[:id])
      end


      def billing_address_params
        params.require(:billing_address).permit(:first_name, :last_name, :line1, :postal_code, :city, :phone)
      end

      def order_params
        params.require(:order).permit(:stripe_payment_method_id, :stripe_payment_intent_id, :user_id, :coupon_text, :card_token, :card_name, :pack_id, order_has_courses_attributes: [:course_id, :order_id], courses_attributes: [:availability_id, :id, :order_id, :start_time, :status, :my_checkbox, :set_changed_recently_at, :_destroy])
      end

      def order_has_item_params
        params.require(:order_has_item).permit(:item_id, :item_type)
      end

  end
end
