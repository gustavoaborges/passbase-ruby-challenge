class AddsIndexToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_index :transactions, :sender_id, name: 'index_transactions_on_sender_users_id'
    add_index :transactions, :receiver_id, name: 'index_transactions_on_receiver_users_id'
  end
end
