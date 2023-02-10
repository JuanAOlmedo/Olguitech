# frozen_string_literal: true

json.status @project.status
json.dom_id dom_id(@project)
json.model_name @project.model_name.plural
