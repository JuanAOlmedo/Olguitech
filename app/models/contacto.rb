# frozen_string_literal: true

class Contacto < ApplicationRecord
    belongs_to :user

    def send_mail
        article = Article.find(preference).get_title
        proyecto = Proyecto.find(preference2).get_title

        ContactMailer.contacto(user, article, proyecto, message).deliver_later
        ContactMailer.admin_contacto(user, article, proyecto, message).deliver_later
    end
end
