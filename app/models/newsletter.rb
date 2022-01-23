# frozen_string_literal: true

class Newsletter < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    after_create :send_newsletter

    has_rich_text :content

    def send_newsletter
        User.where(newsletter: true).find_each do |user|
            NewsMailer.newsletter(user, self).deliver_later
        end
    end

    def localized_title
        title
    end

    def localized_short_title
        title
    end

    def localized_desc
        subject
    end

    def localized_short_desc
        subject
    end

    def localized_content
        content
    end

    def base_uri
        Rails.application.routes.url_helpers.newsletter_path(self, locale: I18n.locale)
    end
end
