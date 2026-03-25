# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
    default from: email_address_with_name(ENV.fetch('EMAIL_USERNAME', 'olguitech@olguitech.com'), 'Olguitech')
    layout 'mailer'
    default_url_options[:locale] = I18n.locale
end
