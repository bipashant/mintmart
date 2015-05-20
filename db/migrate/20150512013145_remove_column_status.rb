class RemoveColumnStatus < ActiveRecord::Migration
  def change
    remove_column :purchased_items, :status
  end
end
