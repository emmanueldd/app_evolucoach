module Dashboard
  class SubscriptionsController < DashboardController

    def index
      @subscription = current_user.subscriptions.last
      if @subscription.present?
        redirect_to [:dashboard, @subscription]
      else
        redirect_to new_dashboard_subscription_path
      end
    end

    def new
      # Un seul plan -> 1 mois gratuits, puis 89€/mois
      @stripe_price_id = Setting.where(setting_name: 'stripe_price_id').last.setting_value
      @subscription = Subscription.new(stripe_price_id: @stripe_price_id)
    end

    def create
      # Create the subscription with the favorite card
      begin
        @subscription = Subscription.create_subscription(current_user, subscription_params)
      rescue => errors
        @errors = errors
        render :new
      else
        redirect_to dashboard_subscription_path(@subscription, success: 'Ton abonnement est activé.')
      end
    end

    def show
      @subscription = current_user.subscriptions.find(params[:id])
    end


    def update
      # NOTE :
      # - Permet : le changement de pricing et annulation ?
      # => https://stripe.com/docs/billing/subscriptions/fixed-price#change-price
      @subscription = current_user.subscriptions.find_by(id: params[:id])
      if @subscription.present?
        if @subscription.update(subscription_params) && @subscription.errors.blank?
          render json: { subscription: @subscription }
        else
          # Errors come from the subscription model begin/rescue : # => cancel # => change_pricing
          render json: { errors: @subscription.errors }
        end
      else
        render json: { errors: :subscription_not_found }
      end
    end

    def destroy
      # NOTE :
      # - Permet : le changement de pricing
      # => https://stripe.com/docs/billing/subscriptions/fixed-price#change-price
      @subscription = current_user.subscriptions.find_by(id: params[:id])
      if @subscription.present?
        if @subscription.destroy
          render json: { destroyed: true }
        else
          render json: { destroyed: false }
        end
      else
        render json: { errors: :subscription_not_found }
      end
    end

    def cancel
      @subscription = current_user.subscriptions.find_by(id: params[:id])
      if @subscription.present?
        if @subscription.cancel && @subscription.errors.blank?
          redirect_to dashboard_subscriptions_path, alert: 'Ton abonnement a bien été annulé.'
        else
          redirect_to dashboard_subscriptions_path, alert: "Une erreur est survenue. #{@subscription.errors}"
        end
      else
        redirect_to dashboard_subscriptions_path, alert: 'Une erreur est survenue.'
      end
    end


    def stripe_webhook
      webhook_secret = ENV['STRIPE_WEBHOOK_SECRET']
      payload = request.body.read
      if webhook_secret.present?
        # Retrieve the event by verifying the signature using the raw body and secret if webhook signing is configured.
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil
        begin
          event = Stripe::Webhook.construct_event(
            payload, sig_header, webhook_secret
          )
        rescue JSON::ParserError => e
          # Invalid payload
          status 400
          return
        rescue Stripe::SignatureVerificationError => e
          # Invalid signature
          puts '⚠️  Webhook signature verification failed.'
          status 400
          return
        end
      else
        data = JSON.parse(payload, symbolize_names: true)
        event = Stripe::Event.construct_from(data)
      end
      event_type = event['type']
      data = event['data']
      data_object = data['object']

      if event_type == 'invoice.payment_succeeded' || event_type == 'invoice.payment_failed'
        @subscription = Subscription.find_by(stripe_subscription_id: data_object["subscription"])
        @subscription = @subscription.renew_stripe_infos if @subscription.present?
      end
      render json: { status: 'success', subscription: @subscription }
    end

    private
      def subscription_params
        params.require(:subscription).permit(:stripe_price_id, :status, :stripe_tax_id)
      end

  end
end
