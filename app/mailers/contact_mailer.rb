class ContactMailer < ApplicationMailer
  default from: ENV['EMAIL_USERNAME']
  layout 'mailer'
  
  def contacto(user, preference, preference2, message)
    @user = user
    @preference = preference
    @preference2 = preference2
    @message = message
    
    mail(to: @user.email, subject: 'Olguitech s.a.s.')
  end

  def admin_contacto(user, preference, preference2, message)
    @user = user
    @preference = preference
    @preference2 = preference2
    @message = message
    
    mail(to: ENV['EMAIL_USERNAME'], subject: 'Una nueva persona se ha contactado')
  end
end