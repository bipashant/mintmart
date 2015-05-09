class AddColumnitemIdtoSoldItem < ActiveRecord::Migration
  def change
    add_column :sold_items, :item_id, :integer
  end
end
