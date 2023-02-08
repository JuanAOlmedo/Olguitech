# frozen_string_literal: true

module Getters
    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    def localized_short_title
        title = localized_title
        return if title.nil?

        title.length > 50 ? "#{title[0...50]}..." : title
    end

    def localized_desc
        return description2 if I18n.locale == :en && !description2.nil? && !description2.empty?

        description
    end

    def localized_short_desc
        description = localized_desc
        return if description.nil?

        description.length > 110 ? "#{description[0...110]}..." : description
    end

    def localized_content
        return content2 if I18n.locale == :en && !content2.empty?

        content
    end

    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def fields_for_cards
            %i[id slug title title2 description description2]
        end
    end
end
