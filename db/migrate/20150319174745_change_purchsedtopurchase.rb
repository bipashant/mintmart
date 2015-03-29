class ChangePurchsedtopurchase < ActiveRecord::Migration
  def change
    rename_column :items, :purchased_id, :purchase_id
  end
end
