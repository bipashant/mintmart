class Add < ActiveRecord::Migration
  def change
    add_column :customers, :communication_media_id, :integer
  end
end
