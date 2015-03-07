class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    add_breadcrumb "SUPPLIER", :suppliers_path
    @suppliers = Supplier.all
  end

  def show
    add_breadcrumb "SUPPLIER", :suppliers_path
    add_breadcrumb "SHOW", :supplier_path
  end

  def new
    add_breadcrumb "SUPPLIER", :suppliers_path
    add_breadcrumb "NEW", :new_supplier_path
    @supplier = Supplier.new
  end

  def edit
    add_breadcrumb "SUPPLIER", :suppliers_path
    add_breadcrumb "UPDATE", :edit_supplier_path
  end

  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.require(:supplier).permit(:organization_name, :address, :contact_person, :contact_no)
    end
end
