class AddColumntoitems < ActiveRecord::Migration
  def change
    add_column :items, :purchased_id, :integer
  end
end
