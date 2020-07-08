module Dashboard
  class PaymentInfosController < DashboardController

    def index
      @stripe = true
      @payment_info = current_user.payment_info
      @payment_info ||= current_user.build_payment_info.save
      @payment_info = current_user.payment_info
      if @payment_info.stripe_oauth_token.present?
        response = Stripe::OAuth.token({
          grant_type: 'authorization_code',
          code: @payment_info.stripe_oauth_token,
        })
        @payment_info.update(stripe_account_id: response.stripe_user_id, stripe_oauth_token: nil)
      end
      # Verifier si le stripe account est valide, erronné ou en attente de validation
      # Afficher le statut dans la vue
      if @payment_info.stripe_account_id.present?
        @stripe_account = Stripe::Account.retrieve(@payment_info.stripe_account_id)
      end
    end

    def redirect_uri
      if current_user.payment_info.update(stripe_oauth_token: params[:code])
        redirect_to dashboard_payment_infos_path, notice: 'Vos modifications sur Stripe sont en attente d\'approbation'
      end
    end

    def create
      @payment_info = current_user.build_payment_info(payment_info_params)
      if @payment_info.save!
        redirect_to "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.configuration.stripe[:client_id]}&scope=read_write"
      end
    end

    def update
      @payment_info = current_user.payment_info
      if current_user.payment_info.update(payment_info_params)
        redirect_to "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.configuration.stripe[:client_id]}&scope=read_write"
      end
    end

    private
    def payment_info_params
      params.require(:payment_info).permit(:first_name, :last_name, :iban, :alma_api_key)
    end

  end
end
