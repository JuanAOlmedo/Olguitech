# frozen_string_literal: true

json.extract! category, :id, :localized_title, :localized_desc, :created_at, :updated_at
json.url category_url(category, format: :json)
