class SalesController < ApplicationController

  def new
    @item = Item.new
    @categories = Category.all
    @sale = Sale.new
  end

  def create
    items_ids = params[:sale][:items_ids_on_cart].split(',')
    items_quantity = params[:sale][:items_quantity_on_cart].split(',')
    index = 0
    binding.pry
    items_ids.each do |item_id|
      current_item = Item.find_by_item_id(item_id)
      # SoldItem.create()
      current_item.quantity = current_item.quantity - items_quantity[index].to_i
      current_item.save
      ++index
    end
    sale = Sale.create(sale_params(params))

  end

  def find_item
    render json: Item.find_by_item_id(params[:item][:name])
  end

  private
  def sale_params params
    params.require(:sale).permit( :customer_id, :amount, :discount, :payment_method)
  end
end
