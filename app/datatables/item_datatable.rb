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

  private

  def data
    records.map do |record|
      [
          record.name,
          record.category.name,
          record.sell_price,
          record.expiration_date,
          render_tabs(record)

        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
      ]
    end
  end

  def get_raw_records
    Item.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
