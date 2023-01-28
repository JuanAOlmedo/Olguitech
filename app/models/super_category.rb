# frozen_string_literal: true

class SuperCategory < ApplicationRecord
    has_many :categories

    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end
end
