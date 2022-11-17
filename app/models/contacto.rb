# frozen_string_literal: true

class Contacto < ApplicationRecord
    belongs_to :user

    def send_mail
        article = Article.find(preference).localized_title
        project = Project.find(preference2).localized_title

        ContactMailer.contacto(user, article, project, message).deliver_later
        ContactMailer.admin_contacto(user, article, project, message).deliver_later
    end
end
