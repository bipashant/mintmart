class SalesReportDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :button_tag, :link_to, :content_tag, :h

  include SalesHelper
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Sale.invoice_id Customer.first_name Customer.last_name Sale.amount Sale.payment_method Sale.created_at)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||=  %w(Sale.invoice_id Customer.first_name Customer.last_name Sale.amount Sale.payment_method Sale.created_at)
  end

  def set_duration( start_date, end_date)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
  end

  private

  def data
    records.map do |record|
      [
        record.invoice_id,
        record.customer.full_name,
        record.amount,
        record.payment_method,
        record.created_at.strftime('%Y/%m/%d'),
        render_tabs(record)
      ]
    end
  end

  def get_raw_records
    Sale.joins(:customer).where(created_at: (@start_date.beginning_of_day)..(@end_date.end_of_day))
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
