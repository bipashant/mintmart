class AddMarginToItem < ActiveRecord::Migration
  def change
    add_column :items, :margin, :decimal
  end
end
