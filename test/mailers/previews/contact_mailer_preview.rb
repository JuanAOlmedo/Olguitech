# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contacto
    def contacto
        user = User.last
        contact = user.contactos.new(message: 'saddsa')

        ContactMailer.contacto(user, contact)
    end

    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/admin_contacto
    def admin_contacto
        user = User.last
        contact = user.contactos.new(message: 'saddsa')

        ContactMailer.admin_contacto(user, contact)
    end
end
