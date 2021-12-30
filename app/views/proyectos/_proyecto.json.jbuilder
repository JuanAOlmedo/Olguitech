json.extract! proyecto, :id, :created_at, :updated_at, :get_title, :get_desc, :get_content, :categories
json.url proyecto_url(proyecto, format: :json)
