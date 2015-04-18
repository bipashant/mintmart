class ItemPurchaseDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  include ItemsHelper
  def_delegators :@view, :button_tag, :link_to, :content_tag, :h


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Item.name Category.name Item.unit_price Item.sell_price Item.quantity Item.expiration_date)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Item.name Category.name Item.unit_price Item.sell_price Item.quantity Item.expiration_date)
  end

  def set_purchase_id current_purchase_id
    binding.pry
    @current_purchase_id = current_purchase_id
  end

  private

  def data
    records.map do |record|
      [
          record.name,
          record.category.name,
          record.unit_price,
          record.sell_price,
          record.quantity,
          record.expiration_date,
          render_tabs(record)
      ]
    end
  end

  def get_raw_records
       Item.joins(:category).all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end