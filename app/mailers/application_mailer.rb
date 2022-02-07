# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
    default from: email_address_with_name(ENV['EMAIL_USERNAME'], 'Olguitech')
    layout 'mailer'
    default_url_options[:locale] = I18n.locale
end
