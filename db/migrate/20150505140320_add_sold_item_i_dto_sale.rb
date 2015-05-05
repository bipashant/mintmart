class AddSoldItemIDtoSale < ActiveRecord::Migration
  def change
    add_column :sold_items, :sale_id, :integer
  end
end
