# frozen_string_literal: true

json.extract! article, :id, :created_at, :updated_at, :localized_title, :localized_desc,
              :localized_content, :status, :categories
json.url article_url(article, format: :json)
json.dom_id dom_id(article)
json.model_name article.model_name.plural
