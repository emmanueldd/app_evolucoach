class SubscriptionMailer < ApplicationMailer
  before_action :set_subscription_and_params


  # app/views/subscription_mailer/subscription_paid_email.html.haml
  # SubscriptionMailer.with(subscription: @subscription).subscription_paid_email.deliver_later
  def subscription_paid_email
    mail(to: @user.email, subject: "Félicitations, ton abonnement est activé !")
  end

  def subscription_renewal_email
    mail(to: @user.email, subject: "Confirmation d'abonnement")
  end



  private
    def set_subscription_and_params
      # SubscriptionMailer.with(subscription: @subscription).subscription_paid_email.deliver_later
      @subscription = params[:subscription]
      @user = @subscription.user
    end
end
