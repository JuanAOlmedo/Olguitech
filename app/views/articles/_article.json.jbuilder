# frozen_string_literal: true

json.extract! article, :id, :created_at, :updated_at, :localized_title, :localized_desc,
              :localized_content, :categories
json.url article_url(article, format: :json)
