class CreateTrasactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :users, :sender, index: false
      t.references :users, :receiver, index: false

      t.monetize :original_amount_cents
      t.monetize :transfered_amount_cents

      t.string :status

      t.timestamps null: false
    end
  end
end
