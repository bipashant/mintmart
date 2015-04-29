class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :sales, :amount, :decimal, :precision => 10, :scale => 2
    change_column :sales, :discount, :decimal, :precision => 10, :scale => 2

  end
end
