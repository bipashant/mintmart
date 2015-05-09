class SalesController < ApplicationController

  require 'escper'
  require 'serialport'

  def index
    @sales = Sale.all
  end
  def new
    @item = Item.new
    @categories = Category.all
    @sale = Sale.new
  end

  def show
      @sale = Sale.find(params[:id])
      generate_receipt
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
      index += 1
    end
    generate_receipt
    redirect_to sale_path(sale)

  end

  def check_item_availabilty

     render text: Item.find_by_item_id(params[:item_id]).quantity
  end

  def generate_receipt
    vp1 = Escper::VendorPrinter.new :id => 1, :name => 'Printer 1 USB', :path => '/dev/usb/lp1', :copies => 1
    print_engine = Escper::Printer.new 'local', [vp1]
    print_engine.open

    print_engine.print 1, "\n       Mint Mart Departmental Store\n "
    print_engine.print 1, "   Sangam Chowk, Kirtipur-3 Tyanglafat\n"
    print_engine.print 1, "                TAX INVOICE               \n"
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "item    quantity --rate--vat---total------ \n"
    print_engine.print 1, "----------------------------------------- \n"
    3.times{
      print_engine.print 1, "Pen    10 Pcs.  --100.00 13% 1000.00- \n"
    }
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "----------------------total : NRS 5000\n"
    print_engine.print 1, "----------------------------------------- \n"

    print_engine.close

    # @net_amount_without_tax = 0
    # @net_taxable_amount = 0
    #
    # sale.sold_items.each do |current_sold_item|
    #   @net_amount_without_tax += current_sold_item.total
    #   if current_sold_item.item.category.include_vat == 1
    #     @net_taxable_amount += current_sold_item.total * 13/100
    #   end
    # end

    # binding.pry
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
       sale_id: sale_ID,
       item_id: current_item.id


   }
  end

end
