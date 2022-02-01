# frozen_string_literal: true

class User < ApplicationRecord
    extend FriendlyId
    friendly_id :email, use: :slugged

    after_create :send_confirmation_instructions

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_secure_token :edit_token
    has_secure_token :newsletter_token
    has_secure_token :confirmation_token

    has_many :contactos, dependent: :destroy

    def send_confirmation_instructions
        return if confirmed?

        update(confirmation_sent_at: Time.now)
        ConfirmationMailer.confirmation_instructions(self).deliver_later
    end

    def confirm
        return if confirmed?

        self.confirmed_at = Time.now

        return if id.nil?

        save
    end

    def confirmed?
        !!confirmed_at
    end
end
