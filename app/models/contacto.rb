# frozen_string_literal: true

class Contacto < ApplicationRecord
    belongs_to :user

    # Add some time to allow users to fill their information
    def send_mail
        ContactMailer.contacto(user, self).deliver_later wait: 3.minutes
        ContactMailer.admin_contacto(user, self).deliver_later wait: 3.minutes
    end
end
