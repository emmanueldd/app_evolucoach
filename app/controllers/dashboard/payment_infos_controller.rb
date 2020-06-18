module Dashboard
  class PaymentInfosController < DashboardController

    def index
      # redirect to new or edit
      @stripe = true
      @payment_info = current_user.payment_info
      @payment_info ||= current_user.build_payment_info

      # Verifier si le stripe account est valide, erronné ou en attente de validation
      # Afficher le statut dans la vue
      if @payment_info.stripe_account_id.present?
        @stripe_account = Stripe::Account.retrieve(@payment_info.stripe_account_id)
      end
    end

    def create
      @payment_info = current_user.build_payment_info(payment_info_params)
      token = params['token-account']
      stripe_account = Stripe::Account.create({
        type: 'custom',
        account_token: token,
        requested_capabilities: ['card_payments', 'transfers'],
        external_account: {
          object: 'bank_account',
          country: 'FR', # TODO : INTERNATIONNALISATION
          currency: 'eur',
          account_number: @payment_info.iban
        },
      })
      @payment_info.stripe_account_id = stripe_account.id
      if @payment_info.save!
        s_for_ssl = Rails.env.production? ? 's' : ''
        url = "http#{s_for_ssl}://#{request.domain}#{dashboard_payment_infos_path}"
        account_links = Stripe::AccountLink.create({
          account: @payment_info.stripe_account_id,
          failure_url: "#{url}?error=Erreur",
          success_url: "#{url}?success=Ok",
          type: 'custom_account_verification',
          collect: 'eventually_due',
        })
        redirect_to account_links.url
      end
    end

    def update
      @payment_info = current_user.payment_info
      token = params['token-account']
      stripe_account = Stripe::Account.update(
        current_user.payment_info.stripe_account_id,
        {
          external_account: {
            object: 'bank_account',
            country: 'FR', # TODO : INTERNATIONNALISATION
            currency: 'eur',
            account_number: @payment_info.iban
          },
          account_token: token
        }
      )
      if current_user.payment_info.update(payment_info_params)
        s_for_ssl = Rails.env.production? ? 's' : ''
        url = "http#{s_for_ssl}://#{request.domain}#{dashboard_payment_infos_path}"
        account_links = Stripe::AccountLink.create({
          account: @payment_info.stripe_account_id,
          failure_url: "#{url}?error=Erreur",
          success_url: "#{url}?success=Ok",
          type: 'custom_account_verification',
          collect: 'eventually_due',
        })
        redirect_to account_links.url
      end
    end

    private
    def payment_info_params
      params.require(:payment_info).permit(:first_name, :last_name, :iban)
    end

  end
end
