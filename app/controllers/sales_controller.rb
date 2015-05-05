class SalesController < ApplicationController

  def index
    @sales = Sale.all
  end
  def new
    @item = Item.new
    @categories = Category.all
    @sale = Sale.new
  end

  def show

  end
  
  def create
    items_ids = params[:sale][:items_ids_on_cart].split(',')
    items_quantity = params[:sale][:items_quantity_on_cart].split(',')
    binding.pry
    sale = Sale.create(sale_params(params).merge({invoice_id: generate_invoice_id_for_sale }))

    index = 0
    total_amount = 0
    items_ids.each do |item_id|
      current_item = Item.find_by_item_id(item_id)
      current_item.quantity = current_item.quantity - items_quantity[index].to_i
      total_amount = current_item.sell_price * items_quantity[index].to_i
      current_item.save
      SoldItem.create(custom_sold_item_params(current_item, items_quantity[index].to_i,sale.id))
      ++index
    end
    redirect_to new_sale_path

  end

  def generate_invoice_id_for_sale
    Sale.last ? (Sale.last.id+1).to_s.rjust(8,'0') : '00000001'
  end


  def find_item
    Item.find_by_item_id(params[:item][:name])
    render json: Item.find_by_item_id(params[:item][:name])
  end

  private
  def sale_params params
    params.require(:sale).permit( :customer_id, :amount, :discount, :payment_method)
  end

  def custom_sold_item_params (current_item, quantity,sale_ID)
   {
       name: current_item.name,
       rate: current_item.sell_price,
       quantity: quantity,
       total: current_item.sell_price * quantity,
       sale_id: sale_ID


   }
  end

end
