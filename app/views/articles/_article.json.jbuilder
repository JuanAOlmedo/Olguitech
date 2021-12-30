json.extract! article, :id, :created_at, :updated_at, :get_title, :get_desc, :get_content, :categories
json.url article_url(article, format: :json)
