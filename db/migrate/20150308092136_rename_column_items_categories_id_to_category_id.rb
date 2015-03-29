class RenameColumnItemsCategoriesIdToCategoryId < ActiveRecord::Migration
  def change
    rename_column :items, :categories_id, :category_id
  end
end

