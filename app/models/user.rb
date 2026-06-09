# frozen_string_literal: true

class User < ApplicationRecord
    extend FriendlyId

    friendly_id :email, use: :slugged

    validates :email,
              format: { with: URI::MailTo::EMAIL_REGEXP },
              presence: true,
              uniqueness: true
    validates :name,
              format: { with: /\A\p{L}+( \p{L}+)*\z/, allow_blank: true },
              length: { maximum: 30 }
    validates :company,
              format: { with: /\A[\p{L}\d .()&'-]*\z/ },
              length: { maximum: 50 },
              allow_blank: true
    validates :phone,
              format: { with: /\A[\d ()+-]*\z/ },
              length: { minimum: 5, maximum: 20 },
              allow_blank: true

    has_secure_token :edit_token
    has_secure_token :newsletter_token
    has_secure_token :confirmation_token

    has_many :messages, dependent: :destroy

    def confirm
        return if confirmed?

        self.confirmed_at = Time.now

        return if id.nil?

        save
    end

    def confirmed?
        !!confirmed_at
    end

    # Suscribe a la newsletter y manda un mail si correponde
    # El usuario podría no existir en la base de datos todavía
    def subscribe
        was_subscribed = newsletter

        self.newsletter = true
        self.locale = I18n.locale

        success = save

        # Mandar un mail confirmando la suscripción solo si el usuario no estaba suscrito previamente
        SubscriptionMailer.subscribe(self).deliver if success && !was_subscribed

        success
    end
end
