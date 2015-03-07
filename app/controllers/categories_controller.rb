class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  def index
    add_breadcrumb "CATEGORY", :categories_path
    @categories = Category.all
  end

  def show
    add_breadcrumb "CATEGORY", :categories_path
    add_breadcrumb "SHOW", :category_path
  end

  def new
    add_breadcrumb "CATEGORY", :categories_path
    add_breadcrumb "NEW", :new_category_path
    @category = Category.new
    @suppliers = Supplier.all
  end

  def edit
    add_breadcrumb "CATEGORY", :categories_path
    add_breadcrumb "UPDATE", :edit_category_path
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :suppliers_id)
    end
end
