class AddStatusToPurchasedAndSells < ActiveRecord::Migration
  def change
    add_column :purchases, :status, :boolean
    add_column :sales, :status, :boolean
  end
end
