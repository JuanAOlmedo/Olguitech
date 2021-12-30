class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update]
    before_action :authenticate_edit_token, only: %i[edit update]
    before_action :authenticate_admin!, :redirect_unless_admin, only: [:index]

    def index
        @users = User.all
        @contacted = User.includes(:contactos).where.not(contactos: { id: nil })
    end

    def show; end

    def new; end

    def edit; end

    def update
        parameters = user_params
        parameters[:locale] = I18n.locale

        if @user.update(parameters)
            if session[:will_contact]
                session[:will_contact] = nil

                @contacto = @user.contactos.last
                article = Article.find(@contacto.preference)
                proyecto = Proyecto.find(@contacto.preference2)

                article = article.get_title
                proyecto = proyecto.get_title

                @mail =
                    ContactMailer.contacto(
                        @user,
                        article,
                        proyecto,
                        @contacto.message
                    ).deliver_now!
                @mail =
                    ContactMailer.admin_contacto(
                        @user,
                        Article.find(@contacto.preference).title,
                        Proyecto.find(@contacto.preference2).title,
                        @contacto.message
                    ).deliver_now!

                redirect_to "/#{I18n.locale}/contacto",
                            notice: I18n.t('contact.sent')
            end
        else
            render :edit
        end
    end

    def confirmation
        @user = User.find_by(confirmation_token: params[:confirmation_token])

        if @user
            @user.confirm

            redirect_to root_path, notice: 'Has confirmado tu cuenta'
        else
            redirect_to root_path,
                        alert:
                            'Algo parece no estar bien con ese link, inténtalo de nuevo.'
        end
    end

    def unsubscribe
        @user = User.find_by(newsletter_token: params[:newsletter_token])

        if @user
            @user.update! newsletter: false

            redirect_to root_path,
                        notice:
                            'Ya no recibiras más mails de nosotros. Puedes volver a activar esta opción en tu perfil'
        else
            redirect_to root_path,
                        alert:
                            'Algo parece no estar bien con ese link, inténtalo de nuevo.'
        end
    end

    private

    def redirect_unless_admin
        if !admin_signed_in?
            flash[:alert] = 'Solo administradores pueden hacer eso'
            redirect_to root_path
        end
    end

    def set_user
        @user = User.find(params[:id])
    end

    def authenticate_edit_token
        if @user.edit_token != params[:edit_token] && @user.edit_token != user_params[:edit_token]
            redirect_to root_path, alert: 'No tienes permiso para hacer eso.'
        end
    end

    def user_params
        params.require(:user).permit :name, :phone, :company, :newsletter, :edit_token
    end
end
