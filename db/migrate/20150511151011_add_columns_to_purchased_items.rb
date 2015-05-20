class AddColumnsToPurchasedItems < ActiveRecord::Migration
  def change

    add_column :purchased_items, :item_id, :string
    add_column :purchased_items, :purchase_id, :integer
    add_column :purchased_items, :total, :decimal
    add_column :purchased_items, :status, :boolean

  end
end
