class DropTablePurchases < ActiveRecord::Migration
  def change
    drop_table :purchases
  end
end
