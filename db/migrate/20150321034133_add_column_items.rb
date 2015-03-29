class AddColumnItems < ActiveRecord::Migration
  def change
    add_column :items, :sell_price, :decimal
  end
end
