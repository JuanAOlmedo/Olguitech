# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/contacto
    def contacto
        user = User.last
        preference, preference2 = Article.first(2)
        message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." 

        ContactMailer.contacto(user, preference.localized_title, preference2.localized_title, message)
    end

    # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/admin_contacto
    def admin_contacto
        user = User.last
        preference, preference2 = Article.first(2)
        message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." 

        ContactMailer.admin_contacto(user, preference.localized_title, preference2.localized_title, message)
    end
end
