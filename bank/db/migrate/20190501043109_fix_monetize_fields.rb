class FixMonetizeFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :original_amount_cents_cents
    remove_column :transactions, :original_amount_cents_currency
    remove_column :transactions, :transfered_amount_cents_cents
    remove_column :transactions, :transfered_amount_cents_currency
    add_monetize :transactions, :original_amount
    add_monetize :transactions, :transfered_amount
  end
end
