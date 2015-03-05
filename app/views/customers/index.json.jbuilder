json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :middle_name, :last_name, :phone, :address, :total_purchased_amount
  json.url customer_url(customer, format: :json)
end
