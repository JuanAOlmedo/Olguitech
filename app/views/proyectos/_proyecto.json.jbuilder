# frozen_string_literal: true

json.extract! proyecto, :id, :created_at, :updated_at, :localized_title, :localized_desc, :localized_content,
              :categories
json.url proyecto_url(proyecto, format: :json)
