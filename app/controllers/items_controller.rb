class ItemsController < ApplicationController
  require 'barby'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    add_breadcrumb "ITEM", :items_path
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "SHOW", :item_path
  end

  # GET /items/new
  def new
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "NEW", :new_item_path
    @item = Item.new
    @categories=Category.all

  end

  # GET /items/1/edit
  def edit
    add_breadcrumb "ITEM", :items_path
    add_breadcrumb "UPDATE", :edit_item_path
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
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

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :categories_id, :quantity, :unit_price, :expiration_date)
    end
end
