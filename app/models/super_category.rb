# frozen_string_literal: true

class SuperCategory < ApplicationRecord
    has_many :categories, dependent: :nullify
    has_many :dashboard_categories, -> { select(:id, :super_category_id, :title, :slug) }, class_name: 'Category'

    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    # Get all super categories which have categories related to published articles
    def self.related_to(name)
        self.includes(categories: [name]) # Include categories and the provided model
            .where(categories: { name => { status: 0 } }) # Only allow published articles
            .uniq # Remove duplicates
    end
end
