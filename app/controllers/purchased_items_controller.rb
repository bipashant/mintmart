class PurchasedItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @purchase_item = PurchasedItem.all
    respond_to do |format|
      format.html
      format.json { render json: PurchasedItem.new(view_context) }
    end
  end

  def show
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "SHOW", :item_path
  end

  def new
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "NEW", :new_item_path
    @item = Item.new
    @categories=Category.all

  end

  def edit
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "UPDATE", :edit_item_path
    @categories=Category.all
  end

  def create
    @purchased_item = PurchasedItem.new(item_params)
    @purchased_item.total = @purchased_item.unit_price.to_d * @purchased_item.quantity.to_d
    if @purchased_item.save
      @count = @purchased_item.purchase.purchased_items.count
      @amount = @purchased_item.purchase.purchased_items.sum(:total)
      respond_to do |format|
        format.json { render json: {count: @count, total_amount: @amount}}
      end
    end
  end

  def check_item_id
    @item = PurchasedItem.find_by_item_id(params[:purchased_item][:item_id])
    respond_to do |format|
      format.json { render json: !@item }
    end
  end

  def generate_item_id_for_open_item
    @item =  PurchasedItem.last ? (PurchasedItem.last.id+1).to_s.rjust(6,'0') : '000001'
    respond_to do |format|
      format.json { render json: {item_id: @item} }
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase_item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @purchase_item = PurchasedItem.find(params[:id])
  end

  def item_params
    params.require(:purchased_item).permit( :item_id, :name, :category_id, :quantity, :unit_price, :sell_price, :expiration_date, :purchase_id, :current_quantity,:margin)
  end
end
