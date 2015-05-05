class AddinvoiceIDtoSale < ActiveRecord::Migration
  def change
    add_column :sales, :invoice_id, :string
  end
end
