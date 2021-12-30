json.extract! product, :id, :created_at, :updated_at, :get_title, :get_desc, :get_content, :categories
json.url product_url(product, format: :json)
