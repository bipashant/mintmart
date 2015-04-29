class ChangeIntegerToDecimalAndAddedScale < ActiveRecord::Migration
  def change
    change_column :sold_items, :total, :decimal, :precision => 10, :scale => 2
    change_column :sold_items, :rate, :decimal, :precision => 10, :scale => 2
  end
end
