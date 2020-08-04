require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'email address format' do
    it 'should have a valid email address' do
      order = Order.new(
        first_name: 'User',
        country: 'Spain',
        postal_code: '35001',
        email_address: 'user@example.com')
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

  context 'required fields' do
    it 'should have a first_name' do
      order = Order.new(
        country: 'Spain',
        postal_code: '35001',
        email_address: 'user@example.com')
      expect(order.valid?).to be_falsey
      expect(order.errors[:first_name]).to include("can't be blank")
    end

    it 'should have a country' do
      order = Order.new(
        first_name: 'User',
        postal_code: '35001',
        email_address: 'user@example.com')
      expect(order.valid?).to be_falsey
      expect(order.errors[:country]).to include("can't be blank")
    end

    it 'should have a postal_code' do
      order = Order.new(
        first_name: 'User',
        country: 'Spain',
        email_address: 'user@example.com')
      expect(order.valid?).to be_falsey
      expect(order.errors[:postal_code]).to include("can't be blank")
    end

    it 'should have an email_address' do
      order = Order.new(
        first_name: 'User',
        country: 'Spain',
        postal_code: '35001')
      expect(order.valid?).to be_falsey
      expect(order.errors[:email_address]).to include("can't be blank")
    end
  end
end
