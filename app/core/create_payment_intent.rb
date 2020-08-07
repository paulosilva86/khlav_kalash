require 'stripe'

class CreatePaymentIntent

  Stripe.api_key = Rails.application.credentials.stripe_secret_key

  def initialize(amount_in_cents, currency)
    @amount_in_cents = amount_in_cents
    @currency = currency
  end

  def self.run(amount_in_cents, currency)
    self.new(amount_in_cents, currency).run
  end

  def run
    payment_intent = Stripe::PaymentIntent.create({
      amount: @amount_in_cents,
      currency: @currency,
      payment_method_types: ['card']
    })
    { success: true, data: payment_intent }
  rescue Stripe::InvalidRequestError => e
    { success: false, message: e.message}
  rescue Stripe::StripeError => e
    { success: false, message: e.message}
  end

end
