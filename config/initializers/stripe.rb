Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['STRIPE_SECRET_KEY'],
    :client_id       => ENV['STRIPE_CLIENT_ID']

}

Stripe.api_key = ENV['STRIPE_SECRET_KEY']
