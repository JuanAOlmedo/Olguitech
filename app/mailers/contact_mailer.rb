class ContactMailer < ApplicationMailer
  default from: ENV['EMAIL_USERNAME']
  layout 'mailer'
  
  def contacto(user, preference, preference2)
    @user = user
    @preference = Article.find(preference.to_i).title
    @preference2 = Proyecto.find(preference2.to_i).title
    
    mail(to: @user.email, subject: 'Olguitech s.a.s.')
  end
end
