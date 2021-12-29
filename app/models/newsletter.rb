class Newsletter < ApplicationRecord
    include Getters

    has_rich_text :content

    def get_short_desc
        self.get_desc
    end

    def get_short_title
        self.get_title
    end

    def description
        self.subject
    end

    def description2
        self.subject
    end

    def title2
        self.title
    end

    def content2
        self.content
    end

    def base_uri
        Rails.application.routes.url_helpers.newsletter_path(id: self.id, locale: I18n.locale)
    end
end
