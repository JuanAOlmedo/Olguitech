# frozen_string_literal: true

class Newsletter < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    enum :status, %i[drafted sent], default: :drafted

    has_rich_text :content

    def send_newsletter
        sent!
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

    def broadcast_refresh_later
        broadcast_refresh_later_to :newsletters
    end
end
