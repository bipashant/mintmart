json.array!(@items) do |item|
  json.extract! item, :id, :name, :category_id, :quantity, :unit_price, :expiration_date
  json.url item_url(item, format: :json)
end
