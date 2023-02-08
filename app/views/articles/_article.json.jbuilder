# frozen_string_literal: true

json.extract! article, :status
json.url article_url(article, format: :json)
json.dom_id dom_id(article)
json.model_name article.model_name.plural
