require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'should have a valid email address' do
    order = Order.new(email_address: 'user@example.com')
    expect(order.valid?).to be_truthy
  end

  it 'should not have a valid email address without the @ symbol' do
    order = Order.new(email_address: 'userexample.com')
    expect(order.valid?).to be_falsey
    expect(order.errors[:email_address]).to include('is invalid')
  end

  it 'should not have a valid email address without the username' do
    order = Order.new(email_address: '@example.com')
    expect(order.valid?).to be_falsey
    expect(order.errors[:email_address]).to include('is invalid')
  end

  it 'should not have a valid email address without the domain' do
    order = Order.new(email_address: 'user@')
    expect(order.valid?).to be_falsey
    expect(order.errors[:email_address]).to include('is invalid')
  end
end
