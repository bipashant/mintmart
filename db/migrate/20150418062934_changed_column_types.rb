class ChangedColumnTypes < ActiveRecord::Migration
  def change
    change_column :purchases, :invoice_id, :string
  end
end
