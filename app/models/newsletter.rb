class Newsletter < ApplicationRecord
    include Getters

    extend FriendlyId
    friendly_id :title, use: :slugged

    after_create :send_newsletter

    has_rich_text :content

    def send_newsletter
        User.where(newsletter: true).find_each do |user|
            NewsMailer.newsletter(user, self).deliver_later
        end
    end

    def get_short_desc
        get_desc
    end

    def get_short_title
        get_title
    end

    def description
        subject
    end

    def description2
        subject
    end

    def title2
        title
    end

    def content2
        content
    end

    def base_uri
        Rails.application.routes.url_helpers.newsletter_path(self, locale: I18n.locale)
    end
end
