# frozen_string_literal: true

class SuperCategory < ApplicationRecord
    has_many :categories

    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    # Get all super categories which have categories related to published articles
    def self.related_to(model)
        name = model.model_name.collection.to_sym

        self.includes(categories: [name]) # Include categories and the provided model
            .where(categories: { name => { status: 0 } }) # Only allow published articles
            .uniq # Remove duplicates
    end
end
