class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy, :load_item_list, :activate_purchase]

  respond_to :html

  def index
    @purchases = Purchase.all
    respond_with(@purchases)
  end

  def show
    @purchased_items = @purchase.purchased_items
    @purchased_item = PurchasedItem.new
    @categories = Category.all

    idt = PurchasedItemDatatable.new(view_context)
    idt.set_purchase_id(@purchase.id)

    respond_to do |format|
      format.html
      format.json { render json: idt }
    end
  end

  def new
    @purchase = Purchase.new
    @suppliers = Supplier.all
    @categories = Category.all
    @item = Item.new
    respond_with(@purchase)
  end

  def edit
  end

  def create
    @purchase = Purchase.new(purchase_params.merge({status: 0}))
    @purchase.save
    respond_with(@purchase)
  end

  def update
    @purchase.update(purchase_params)
    respond_with(@purchase)
  end

  def activate_purchase
    @purchase.update(status: 1)
    @purchase.purchased_items.each do |item|
      Item.create(item.attributes.except('id').merge({current_quantity: item.quantity}))
    end
    respond_to do |format|
      format.json { render json: {purchase: @purchase}}
    end

  end

  def destroy
    @purchase.destroy
    respond_with(@purchase)
  end

  private
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:supplier_id, :invoice_id, :amount, :date)
    end
end
