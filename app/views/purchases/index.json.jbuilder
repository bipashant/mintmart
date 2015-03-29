json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :supplier_id, :invoice_id, :amount
  json.url purchase_url(purchase, format: :json)
end
