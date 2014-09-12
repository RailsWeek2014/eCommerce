json.array!(@shipments) do |shipment|
  json.extract! shipment, :id, :name, :cost
  json.url shipment_url(shipment, format: :json)
end
