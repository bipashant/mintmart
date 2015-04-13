class ItemDatatable < AjaxDatatablesRails::Base
  include ItemsHelper

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Item.name Category.name Item.sell_price,Item.quantity Item.expiration_date)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Item.name Category.name Item.sell_price,Item.quantity Item.expiration_date)
  end

  def set_purchase_id current_purchase_id
    binding.pry
    @current_purchase_id = current_purchase_id
  end

  private

  def data
    binding.pry
    records.map do |record|
      [
          record.name,
          record.category.name,
          record.sell_price,
          record.quantity,
          record.expiration_date,
          'render_tabs(record)'
      ]
    end
  end

  def get_raw_records
    binding.pry
    Item.all
  end
end
