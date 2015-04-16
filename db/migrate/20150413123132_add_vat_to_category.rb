class AddVatToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :include_vat, :integer
  end
end
