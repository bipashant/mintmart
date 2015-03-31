class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :supplier_id
      t.integer :invoice_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
