class AddsCurrencyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :currency, :string, default: 'USD'
  end
end
