class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy, :load_item_list]

  respond_to :html

  def index
    @purchases = Purchase.all
    respond_with(@purchases)
  end

  def show
    @items = @purchase.items
    @item = Item.new
    @categories = Category.all
    respond_with(@purchase)
  end

  def load_item_list
    item_datatable = ItemDatatable.new(view_context)
    item_datatable.set_purchase_id(@purchase.id)
    binding.pry
    respond_to do |format|
      format.json { render json: item_datatable }
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
    @purchase = Purchase.new(purchase_params)
    @purchase.save
    respond_with(@purchase)
  end

  def update
    @purchase.update(purchase_params)
    respond_with(@purchase)
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
