class ApplicationMailer < ActionMailer::Base
    default from: email_address_with_name(ENV['EMAIL_USERNAME'], 'Olguitech')
    layout 'mailer'
end
