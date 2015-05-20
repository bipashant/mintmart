class CreatePurchasedItems < ActiveRecord::Migration
  def change
    create_table :purchased_items do |t|
      t.string :name
      t.integer :category_id
      t.integer :quantity
      t.decimal :unit_price
      t.string :expiration_date

      t.timestamps null: false
    end
  end
end
