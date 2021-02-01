class ContactosController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @contacto = Contacto.new
  end

  def create
    @contacto = Contacto.new(contacto_params)

    if @contacto.save 
      @preference = Article.find(@contacto.preference.to_i).title
      @preference2 = Proyecto.find(@contacto.preference2.to_i).title

      @user = current_user

      @user.preference1 = @preference
      @user.preference2 = @preference2

      @user.save

      @mail = ContactMailer.contacto(current_user, @contacto.preference, @contacto.preference2).deliver_now!
      redirect_to contactos_path, notice: 'Un email ha sido enviado.'
      @contacto.destroy
    end
  end

  private
    def contacto_params
      params.require(:contacto).permit(:preference, :preference2)
    end
end
