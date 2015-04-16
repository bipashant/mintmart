class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "ITEM", :items_path
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: ItemDatatable.new(view_context) }
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
    @item = Item.new(item_params)
    @item.total = @item.unit_price.to_d * @item.quantity.to_d
    @item.current_quantity = @item.quantity
    if @item.save
      @count = @item.purchase.items.count
      @amount = @item.purchase.items.sum(:total)
      respond_to do |format|
        format.json { render json: {count: @count, total_amount: @amount}}
      end
    end
  end

  def check_item_id
    @item = Item.find_by_item_id(params[:item][:item_id])
    respond_to do |format|
      format.json { render json: !@item }
    end
  end

  def generate_item_id_for_open_item
    @item =  Item.last ? (Item.last.id+1).to_s.rjust(6,'0') : '000001'
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
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit( :item_id, :name, :category_id, :quantity, :unit_price, :sell_price, :expiration_date, :purchase_id, :current_quantity)
    end
end
