class User < ApplicationRecord
    after_create :send_confirmation_instructions

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 

    has_secure_token :edit_token
    has_secure_token :newsletter_token
    has_secure_token :confirmation_token

    has_many :contactos, dependent: :destroy

    def send_confirmation_instructions
        unless self.confirmed?
            self.update(confirmation_sent_at: Time.now)
            ConfirmationMailer.confirmation_instructions(self).deliver_later
        end
    end

    def confirm
        if !!self.id
            self.update(confirmed_at: Time.now) unless self.confirmed?
        else
            self.confirmed_at = Time.now
        end
    end

    def confirmed?
        !!self.confirmed_at
    end
end
