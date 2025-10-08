json.extract! product, :id, :title, :description, :price_cents, :stock, :slug, :created_at, :updated_at
json.url product_url(product, format: :json)
