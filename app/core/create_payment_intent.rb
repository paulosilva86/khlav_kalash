require 'stripe'

class CreatePaymentIntent

  Stripe.api_key = Rails.application.credentials.stripe_secret_key

  def initialize(amount_in_cents, currency, order)
    @amount_in_cents = amount_in_cents
    @currency = currency
    @order = order
  end

  def self.run(amount_in_cents, currency, order)
    self.new(amount_in_cents, currency, order).run
  end

  def run
    payment_intent = Stripe::PaymentIntent.create({
      amount: @amount_in_cents,
      currency: @currency,
      payment_method_types: ['card']
    })

    @order.payment_intent_id = payment_intent.id
    @order.save!
    { success: true, data: payment_intent }
  rescue Stripe::InvalidRequestError => e
    { success: false, message: e.message}
  rescue Stripe::StripeError => e
    { success: false, message: e.message}
  end

end
