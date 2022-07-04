# frozen_string_literal: true

json.extract! newsletter, :id, :title, :content, :subject, :status
json.url newsletter_url(newsletter, format: :json)
json.dom_id dom_id(newsletter)
json.model_name newsletter.model_name.plural
