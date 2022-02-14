# frozen_string_literal: true

json.extract! proyecto, :id, :created_at, :updated_at, :localized_title, :localized_desc, :localized_content, :status, :categories
json.url proyecto_url(proyecto, format: :json)
json.dom_id dom_id(proyecto)
json.model_name proyecto.model_name.plural
