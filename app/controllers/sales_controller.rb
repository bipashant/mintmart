class SalesController < ApplicationController

  require 'escper'
  require 'serialport'

  def index
      cpmd = SalesReportDatatable.new(view_context)
      if !(params[:start_date] && params[:end_date])
        params[:start_date] = Time.current.to_date.to_s
        params[:end_date] = Time.current.to_date.to_s
      end

      @total_amount = Sale.where(created_at: ( params[:start_date].to_date.beginning_of_day)..(params[:end_date].to_date.end_of_day)).sum(:amount).to_s

      cpmd.set_duration( params[:start_date], params[:end_date])
      respond_to do |format|
        format.html
        format.json { render json: cpmd }
      end
  end

  def new
    @item = Item.new
    @categories = Category.all
    @sale = Sale.new
  end

  def show
    @sale = Sale.find(params[:id])
    generate_abbreviated_tax_receipt @sale
  end

  def create
    items_ids = params[:sale][:items_ids_on_cart].split(',')
    items_quantity = params[:sale][:items_quantity_on_cart].split(',')
    item_rates = params[:sale][:items_rate_on_cart].split(',')
    sale = Sale.create(sale_params(params).merge({invoice_id: generate_invoice_id_for_sale }))

    index = 0
    total_amount = 0
    items_ids.each do |item_id|
      current_item = Item.find_by_item_id(item_id)
      current_item.quantity = current_item.quantity - items_quantity[index].to_i
      total_amount = item_rates[index].to_i * items_quantity[index].to_i
      current_item.save
      SoldItem.create(custom_sold_item_params(current_item,item_rates[index].to_i, items_quantity[index].to_i,sale.id))

      index += 1
    end
    # generate_abbreviated_tax_receipt sale
    redirect_to sale_path(sale)

  end

  def check_item_availabilty
     render text: Item.find_by_item_id(params[:item_id]).quantity
  end

  def generate_abbreviated_tax_receipt sale
    vp1 = Escper::VendorPrinter.new :id => 1, :name => 'Printer 1 USB', :path => '/dev/usb/lp1', :copies => 1
    print_engine = Escper::Printer.new 'local', [vp1]
    print_engine.open
    customer = sale.customer.full_name.ljust(28,' ')
    receipt = sale.invoice_id.ljust(28,' ')
    user = current_user.username.ljust(15,' ')

    print_engine.print 1, "       Mint Mart Departmental Store   \n "
    print_engine.print 1, "           Kirtipur-3 Tyanglafat\n"
    print_engine.print 1, "               Tel. 01-4335632 \n"
    print_engine.print 1, "       www.facebook.com/mintmartpvt \n"
    print_engine.print 1, "          ABBREVIATED TAX INVOICE        \n"
    print_engine.print 1, "\n"
    print_engine.print 1, "PAN NO. 602456861         Date: #{ Date.today.to_s}\n"
    print_engine.print 1, "\n"
    print_engine.print 1, "Customer    : #{customer}\n"
    print_engine.print 1, "Receipt No. : #{receipt}\n"
    print_engine.print 1, "\n"
    print_engine.print 1, "------------------------------------------\n"
    print_engine.print 1, "SN. ITEM               QTY   Rate   Total\n"
    print_engine.print 1, "------------------------------------------\n"
    index = 1
    sale.sold_items.each do |sold_item|
      sn = sprintf '%02d', index
      sn += '  '
      name = sold_item.name.truncate(17).ljust(18,' ')
      rate = sold_item.rate.round.to_s.rjust(4,' ')+ '  '
      qty = sold_item.quantity.round.to_s.rjust(2,' ')+ '  '
      total = sold_item.total.round.to_s.rjust(4,' ')
      print_engine.print 1, "#{sn}#{name}#{qty} #{rate}   #{total}\n"
      index += 1
    end


    net_total = sale.amount.round.to_s.rjust(5,' ')
    discount = sale.discount.round.to_s.rjust(5,' ')
    total_after_discount = sale.amount - sale.discount
    total_after_discount = total_after_discount.round.to_s.rjust(5,' ')
    time =  Time.now.strftime("%H:%M:%S")
    print_engine.print 1, "------------------------------------------\n"
    print_engine.print 1, "                      Total :    NRS #{net_total}\n"
    print_engine.print 1, "                   Discount :    NRS #{discount}\n"
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "                  Net total :    NRS #{total_after_discount}\n"
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "Cashier : #{user}  #{time}   \n"
    print_engine.print 1, "******************************************\n"
    print_engine.print 1, "*    THANK YOU FOR YOUR BUSINESS         *\n"
    print_engine.print 1, "******************************************\n"
    print_engine.print 1, "\n\n\n\n\n"

    print_engine.close

  end

  def generate_tax_receipt sale
    vp1 = Escper::VendorPrinter.new :id => 1, :name => 'Printer 1 USB', :path => '/dev/usb/lp1', :copies => 1
    print_engine = Escper::Printer.new 'local', [vp1]
    print_engine.open

    customer = sale.customer.full_name.ljust(28,' ')
    receipt = sale.invoice_id.ljust(28,' ')
    user = current_user.username.ljust(15,' ')
    date = sale.created_at.strftime("%Y/%m/%d")

    print_engine.print 1, "       Mint Mart Departmental Store   \n "
    print_engine.print 1, "           Kirtipur-3 Tyanglafat\n"
    print_engine.print 1, "               Tel. 01-4335632 \n"
    print_engine.print 1, "       www.facebook.com/mintmartpvt \n"
    print_engine.print 1, "               TAX INVOICE        \n"
    print_engine.print 1, "\n"
    print_engine.print 1, "PAN NO. 602456861         Date: #{date}\n"
    print_engine.print 1, "\n"
    print_engine.print 1, "Customer    : #{customer}\n"
    print_engine.print 1, "Receipt No. : #{receipt}\n"
    print_engine.print 1, "\n"

    print_engine.print 1, "------------------------------------------\n"
    print_engine.print 1, "ITEM     QTY    Rate  Total   VAT  Total\n"
    print_engine.print 1, "                             (13%)      \n"
    print_engine.print 1, "------------------------------------------\n"
    index = 1
    sale.sold_items.each do |sold_item|
      sn = sprintf '%02d', index
      sn += ' '
      name = sold_item.name.truncate(10).ljust(11,' ')
      if  Item.find(sold_item.item_id).category.include_vat?
        rate = (sold_item.rate/1.13).round(2) #.to_s.rjust(4,' ')+ '  '
        qty = sold_item.quantity.round #.to_s.rjust(2,' ')+ '  '
        total = rate * qty
        vat = (total * 0.13).round
        including_vat = total + vat

        rate = rate.to_s.rjust(7,' ')+ ' '
        qty = qty.to_s.rjust(2,' ')+ '  '
        total = total.to_s.rjust(5,' ')
        vat = vat.to_s.rjust(4,' ')
        including_vat = including_vat.to_s.rjust(5,' ')
      else
        rate = sold_item.rate.round.to_s.rjust(4,' ')+ ' '
        qty = sold_item.quantity.round.to_s.rjust(2,' ')+ '  '
        total = sold_item.total.round.to_s.rjust(5,' ')
        vat = '   0'
        including_vat = total
      end

      print_engine.print 1, "#{sn}#{name}#{qty}#{rate} #{total} #{vat}  #{including_vat}\n"
      index += 1
    end
    net_total = sale.amount.round.to_s.rjust(5,' ')
    discount = sale.discount.round.to_s.rjust(5,' ')
    total_after_discount = sale.amount - sale.discount
    total_after_discount = total_after_discount.round.to_s.rjust(5,' ')
    time =  sale.created_at.strftime("%H:%M:%S")
    print_engine.print 1, "------------------------------------------\n"
    print_engine.print 1, "                      Total :    NRS #{net_total}\n"
    print_engine.print 1, "                   Discount :    NRS #{discount}\n"
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "                  Net total :    NRS #{total_after_discount}\n"
    print_engine.print 1, "----------------------------------------- \n"
    print_engine.print 1, "Cashier : #{user}  #{time}   \n"
    print_engine.print 1, "******************************************\n"
    print_engine.print 1, "*    THANK YOU FOR YOUR BUSINESS         *\n"
    print_engine.print 1, "******************************************\n"
    print_engine.print 1, "\n\n\n\n\n"

    print_engine.close

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

  def custom_sold_item_params (current_item,rate, quantity,sale_ID)
    binding.pry
   {
       name: current_item.name,
       rate: rate,
       quantity: quantity,
       total: rate * quantity,
       sale_id: sale_ID,
       item_id: current_item.id


   }
  end

end
