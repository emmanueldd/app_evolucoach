class OrderMailer < ApplicationMailer
  before_action :set_order_and_params

  # app/views/order_mailer/alma_payment_user_email.html.haml
  # OrderMailer.with(order: @order).alma_payment_user_email.deliver_later
  def alma_payment_user_email
    mail(to: @user.email, subject: "#{@client.first_name} a un paiement en attente de validation")
  end

  # app/views/order_mailer/order_paid_user_email.html.haml
  # OrderMailer.with(order: @order).order_paid_user_email.deliver_later
  def order_paid_user_email
    mail(to: @user.email, subject: "#{@client.first_name} vient de faire un paiement")
  end

  # app/views/order_mailer/alma_payment_client_email.html.haml
  # OrderMailer.with(order: @order).alma_payment_client_email.deliver_later
  def alma_payment_client_email
    mail(to: @client.email, subject: 'Ton paiement est en attente de validation')
    # mail(from: "#{@user.first_name} Evolucoach", to: @client.email, subject: 'Ton paiement est en attente de validation')
  end

  # app/views/order_mailer/order_paid_client_email.html.haml
  # OrderMailer.with(order: @order).order_paid_client_email.deliver_later
  def order_paid_client_email
    mail(to: @client.email, subject: 'Confirmation de paiement')
    # mail(from: "#{@user.first_name} Evolucoach", to: @client.email, subject: 'Confirmation de paiement')
  end

  # app/views/order_mailer/client_changed_coachings_user_email.html.haml
  # OrderMailer.with(order: @order).client_changed_coachings_user_email.deliver_later
  def client_changed_coachings_user_email
    # Permettre au coach de bloquer le changement de créneaux 48h avant ?
    # Prévenir le client que le coach sera notifié du changement d'horaire

    # Course.send_courses_changed_recently_to_user is called every 1hour
    @courses = @order.courses.confirmed_removed_canceled.where.not(changed_recently_at: nil)

    mail(to: @user.email, subject: "#{@client.first_name} a changé ses dates de coaching")

    @courses.update_all(changed_recently_at: nil)
  end

  private
    def set_order_and_params
      # OrderMailer.with(order: @order).order_paid_user_email.deliver_later
      @order = params[:order]
      @user = @order.user
      @client = @order.client
    end
end
