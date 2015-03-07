class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index

    add_breadcrumb "CUSTOMER", :customers_path
    @customers = Customer.all
  end

  def show
    add_breadcrumb "CUSTOMER", :customers_path
    add_breadcrumb "SHOW", :customer_path
  end

  def new
    add_breadcrumb "CUSTOMER", :customers_path
    add_breadcrumb "NEW", :new_customer_path
    @customer = Customer.new
  end

  def edit
    add_breadcrumb "CUSTOMER", :customers_path
    add_breadcrumb "UPDATE", :edit_customer_path
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :middle_name, :last_name, :phone, :address, :total_purchased_amount)
    end
end
