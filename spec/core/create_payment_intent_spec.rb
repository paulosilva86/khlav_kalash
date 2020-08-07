require 'rails_helper'
require 'stripe_mock'
require './app/core/create_payment_intent'

RSpec.describe CreatePaymentIntent do

  before { StripeMock.start }
  after { StripeMock.stop }

  it "should succesfully return a PaymentIntent" do
    payment_intent = CreatePaymentIntent.run(299, 'usd')

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
    payment_intent = CreatePaymentIntent.run(0, 'usd')

    expect(payment_intent[:success]).to be_falsey
    expect(payment_intent[:message]).to match("Invalid positive integer")
  end
end
