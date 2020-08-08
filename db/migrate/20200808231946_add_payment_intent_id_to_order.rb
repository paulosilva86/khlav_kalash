class AddPaymentIntentIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_intent_id, :string
  end
end
