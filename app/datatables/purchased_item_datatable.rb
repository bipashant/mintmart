class PurchasedItemDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  include ItemsHelper
  def_delegators :@view, :button_tag, :link_to, :content_tag, :h


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(PurchasedItem.name Category.name PurchasedItem.item_id PurchasedItem.sell_price PurchasedItem.quantity PurchasedItem.expiration_date)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||=  %w(PurchasedItem.name Category.name PurchasedItem.item_id PurchasedItem.sell_price PurchasedItem.quantity PurchasedItem.expiration_date)
  end

  def set_purchase_id current_purchase_id
    @current_purchase_id = current_purchase_id
  end

  private

  def data
    records.map do |record|
      [
          record.name,
          record.category.name,
          record.item_id,
          record.sell_price,
          record.quantity,
          record.expiration_date,
          render_tabs(record)
      ]
    end
  end

  def get_raw_records
    if(@current_purchase_id.nil?)
      PurchasedItem.joins(:category).all
    else
      PurchasedItem.joins(:category).where(purchase_id: @current_purchase_id)
    end

  end

  # ==== Insert 'presenter'-like methods below if necessary
end