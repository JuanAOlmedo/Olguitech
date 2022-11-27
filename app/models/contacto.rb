# frozen_string_literal: true

class Contacto < ApplicationRecord
    belongs_to :user

    has_many :interests, dependent: :destroy
    accepts_nested_attributes_for :interests

    def send_mail
        ContactMailer.contacto(user, self, message).deliver_later wait: 3.minutes
        ContactMailer.admin_contacto(user, self, message).deliver_later wait: 3.minutes
    end
end
