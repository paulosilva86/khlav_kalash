class Order < ApplicationRecord
  before_create :set_defaults

  validates_format_of :email_address, with: URI::MailTo::EMAIL_REGEXP

  UNIT_PRICE_CENTS = 299
  CURRENCY = 'USD'.freeze

  def price
    Money.new(UNIT_PRICE_CENTS, CURRENCY)
  end

  private

  def set_defaults
    self.number = next_number
    self.permalink = SecureRandom.hex(20)

    while Order.where(permalink: self.permalink).any?
      self.permalink = SecureRandom.hex(20)
    end
  end

  def next_number
    current = self.class.reorder('number desc').first.try(:number) || '000000000000'
    current.next
  end
end
