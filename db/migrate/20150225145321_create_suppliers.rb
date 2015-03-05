class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :organization_name
      t.string :address
      t.string :contact_person
      t.string :contact_no

      t.timestamps null: false
    end
  end
end
