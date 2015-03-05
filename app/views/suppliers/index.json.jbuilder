json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :organization_name, :address, :contact_person, :contact_no
  json.url supplier_url(supplier, format: :json)
end
