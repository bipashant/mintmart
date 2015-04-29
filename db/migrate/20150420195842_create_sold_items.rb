class CreateSoldItems < ActiveRecord::Migration
  def change
    create_table :sold_items do |t|
      t.string :name
      t.decimal :rate
      t.integer :total
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
