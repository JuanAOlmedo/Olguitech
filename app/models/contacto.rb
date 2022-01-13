class Contacto < ApplicationRecord
    belongs_to :user

    def send_mail
        article = Article.find(self.preference).get_title
        proyecto = Proyecto.find(self.preference2).get_title

        ContactMailer.contacto(self.user, article, proyecto, self.message)
            .deliver_later
        ContactMailer.admin_contacto(self.user, article, proyecto, self.message)
            .deliver_later
    end
end
