json.array!(@categories) do |category|
  json.extract! category, :id, :name, :description, :image
  json.url category_url(category, format: :json)
end
