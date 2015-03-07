class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :categories_id
      t.integer :quantity
      t.integer :unit_price
      t.string :expiration_date

      t.timestamps null: false
      index
    end
  end
end
