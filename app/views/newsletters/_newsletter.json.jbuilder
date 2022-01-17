# frozen_string_literal: true

json.extract! newsletter, :id, :title, :content, :subject, :created_at, :updated_at
json.url newsletter_url(newsletter, format: :json)
