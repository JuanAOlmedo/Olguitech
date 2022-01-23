# frozen_string_literal: true

json.extract! product, :id, :created_at, :updated_at, :localized_title, :localized_desc, :localized_content, :categories
json.url product_url(product, format: :json)
