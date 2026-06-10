# frozen_string_literal: true

class Message < ApplicationRecord
    LINK_PATTERN = %r/https?:\/\/|www\.|ftps?:\/\/|\.[a-z]{2,}\/|[a-z]+\.com/i

    belongs_to :user
    after_commit :send_mail, on: :create
    validates :content, format: {
        without: LINK_PATTERN
    }, length: { maximum: 2000 }

    # Add some time to allow users to fill their information
    def send_mail
        MessageMailer.user_mail(user, self).deliver_later wait: 10.minutes
        MessageMailer.admin_mail(user, self).deliver_later wait: 3.minutes
    end
end
