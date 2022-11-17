# frozen_string_literal: true

json.extract! project, :id, :created_at, :updated_at, :localized_title, :localized_desc,
              :localized_content, :status, :categories
json.url project_url(project, format: :json)
json.dom_id dom_id(project)
json.model_name project.model_name.plural
