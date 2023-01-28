# frozen_string_literal: true

json.extract! super_category, :id, :created_at, :updated_at
json.url super_category_url(super_category, format: :json)
