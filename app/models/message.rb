# frozen_string_literal: true

class Message < ApplicationRecord
    belongs_to :user

    # Add some time to allow users to fill their information
    def send_mail
        MessageMailer.user_mail(user, self).deliver_later wait: 3.minutes
        MessageMailer.admin_mail(user, self).deliver_later wait: 3.minutes
    end
end
