class AddColumnOnCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :communication_details, :string
    add_column :customers, :status, :boolean
  end
end
