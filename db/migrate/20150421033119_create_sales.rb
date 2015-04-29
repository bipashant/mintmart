class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :customer_id
      t.decimal :discount
      t.decimal :amount
      t.timestamps null: false
    end
  end
end
