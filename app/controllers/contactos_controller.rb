class ContactosController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    require 'prime'

    100000.times do |time|
        Prime.prime?(time)
    end
  end

  def new
    @contacto = Contacto.new
  end

  def create
    @contacto = current_user.contactos.new(contacto_params)
    @contacto.message = @contacto.message.length > 4000 ? @contacto.message + "... [Mensaje muy largo]" : @contacto.message
    @contacto.preference = @contacto.preference.to_i
    @contacto.preference2 = @contacto.preference2.to_i

    if @contacto.save 
      article = Article.find(@contacto.preference)
      proyecto = Proyecto.find(@contacto.preference2)

      article = I18n.locale == :en && article.title2 != "" && article.title2 != nil ? article.title2 : article.title
      proyecto = I18n.locale == :en && proyecto.title2 != "" && proyecto.title2 != nil ? proyecto.title2 : proyecto.title

      @mail = ContactMailer.contacto(current_user, article, proyecto, @contacto.message).deliver_now!
      @mail = ContactMailer.admin_contacto(current_user, Article.find(@contacto.preference).title, Proyecto.find(@contacto.preference2).title, @contacto.message).deliver_now!
      redirect_to "/#{I18n.locale}/contacto", notice: I18n.t("contact.sent")
    end
  end

  private
    def contacto_params
      params.require(:contacto).permit(:preference, :preference2, :message)
    end
end
