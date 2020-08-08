require 'rails_helper'
require 'stripe_mock'
require './app/core/create_payment_intent'

RSpec.describe CreatePaymentIntent do

  before(:all) do
    @order = Order.new(
      first_name: 'User',
      country: 'Spain',
      postal_code: '35001',
      email_address: 'user@example.com')
    @order.save!
  end

  before { StripeMock.start }
  after { StripeMock.stop }

  it "should succesfully return a PaymentIntent" do
    payment_intent = CreatePaymentIntent.run(299, 'usd', @order)

    expect(@order.payment_intent_id).to match(payment_intent[:data].id)
    expect(payment_intent[:success]).to be_truthy
    expect(payment_intent[:data].id).to match(/pi_[a-z,0-9,A-Z]/)
    expect(payment_intent[:data].object).to match("payment_intent")
    expect(payment_intent[:data].amount).to equal(299)
    expect(payment_intent[:data].currency).to match("usd")
    expect(payment_intent[:data].payment_method_types).to include("card")
    expect(payment_intent[:data].livemode).to be_falsey
    expect(payment_intent[:data].client_secret).to match(/pi_[a-z,0-9,A-Z]+_secret_[a-z,0-9,A-Z]+/)
  end

  it "should throw an error when amount is zero" do
    payment_intent = CreatePaymentIntent.run(0, 'usd', @order)

    expect(payment_intent[:success]).to be_falsey
    expect(payment_intent[:message]).to match("Invalid positive integer")
  end
end
