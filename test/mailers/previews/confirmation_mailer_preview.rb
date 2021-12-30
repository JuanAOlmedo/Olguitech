# Preview all emails at http://localhost:3000/rails/mailers/confirmation_mailer
class ConfirmationMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/confirmation_mailer/confirmation_instructions
    def confirmation_instructions
        user = User.last

        ConfirmationMailer.confirmation_instructions(user)
    end
end
