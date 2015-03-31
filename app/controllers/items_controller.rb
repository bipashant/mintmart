class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "ITEM", :items_path
    @items = Item.all
    binding.pry
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
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item.purchase, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      end
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
      params.require(:item).permit(:name, :category_id, :quantity, :unit_price, :sell_price, :expiration_date, :purchase_id)
    end
end
