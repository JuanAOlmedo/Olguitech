class ContactosController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @contacto = Contacto.new
  end

  def create
    @contacto = current_user.contactos.new(contacto_params)
    @contacto.preference = @contacto.preference.to_i
    @contacto.preference2 = @contacto.preference2.to_i

    if @contacto.save 
      @mail = ContactMailer.contacto(current_user, Article.find(@contacto.preference).title, Proyecto.find(@contacto.preference2).title, @contacto.message).deliver_now!
      @mail = ContactMailer.admin_contacto(current_user, Article.find(@contacto.preference).title, Proyecto.find(@contacto.preference2).title, @contacto.message).deliver_now!
      redirect_to '/contacto', notice: 'Un email ha sido enviado.'
    end
  end

  private
    def contacto_params
      params.require(:contacto).permit(:preference, :preference2, :message)
    end
end
