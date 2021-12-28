class ConfirmationMailer < ApplicationMailer
    default from: ENV['EMAIL_USERNAME']
    layout 'mailer'

    def confirmation_instructions(user)
        @email = user.email
        @token = user.confirmation_token

        mail(to: user.email, subject: 'Olguitech s.a.s.')
    end
end
