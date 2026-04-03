# frozen_string_literal: true

class Message < ApplicationRecord
    belongs_to :user
    after_commit :send_mail, on: :create

    # Add some time to allow users to fill their information
    def send_mail
        MessageMailer.user_mail(user, self).deliver_later
        MessageMailer.admin_mail(user, self).deliver_later wait: 3.minutes
    end
end
