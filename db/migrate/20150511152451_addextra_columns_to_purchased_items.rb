class AddextraColumnsToPurchasedItems < ActiveRecord::Migration
  def change
    add_column :purchased_items, :sell_price, :decimal
    add_column :purchased_items, :margin, :decimal
  end
end
