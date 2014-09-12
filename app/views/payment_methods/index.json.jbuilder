json.array!(@payment_methods) do |payment_method|
  json.extract! payment_method, :id, :payment_name, :payment_description
  json.url payment_method_url(payment_method, format: :json)
end
