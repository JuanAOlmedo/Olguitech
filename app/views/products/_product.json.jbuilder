# frozen_string_literal: true

json.extract! product, :id, :created_at, :updated_at, :localized_title, :localized_desc, :localized_content, :status, :categories
json.url product_url(product, format: :json)
json.dom_id dom_id(product)
json.model_name product.model_name.plural
