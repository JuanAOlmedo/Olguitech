class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]
    before_action :authenticate_edit_token, only: %i[edit destroy]
    before_action :authenticate_edit_token_for_update, only: %i[update]
    before_action :authenticate_admin!,
                  :redirect_unless_admin,
                  only: %i[index new create]

    def index
        @users = User.all
        @contacted = User.includes(:contactos).where.not(contactos: { id: nil })
    end

    def show; end

    def new
        @user = User.new
    end

    def edit; end

    def destroy
        @user.destroy

        respond_to do |format|
            format.html do
                redirect_to root_path,
                            notice: I18n.t('users.deleted'),
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    def create
        parameters = new_user_params

        confirm = parameters[:auto_confirm] == 0 ? false : true
        parameters.delete(:auto_confirm)

        @user = User.new parameters
        @user.confirm if confirm

        if @user.save
            respond_to do |format|
                format.html { redirect_to root_path }
                format.turbo_stream
            end
        end
    end

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
                    ).deliver_later
                @mail =
                    ContactMailer.admin_contacto(
                        @user,
                        Article.find(@contacto.preference).title,
                        Proyecto.find(@contacto.preference2).title,
                        @contacto.message
                    ).deliver_later

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
            redirect_to root_path,
                        status: :unauthorized,
                        alert: 'Solo administradores pueden hacer eso'
        end
    end

    def set_user
        @user = User.find(params[:id])
    end

    def authenticate_edit_token
        @user.regenerate_edit_token unless @user.edit_token

        if @user.edit_token != params[:edit_token]
            redirect_to root_path, alert: 'No tienes permiso para hacer eso.'
        end
    end

    def authenticate_edit_token_for_update
        @user.regenerate_edit_token unless @user.edit_token

        if @user.edit_token != user_params[:edit_token]
            redirect_to root_path, alert: 'No tienes permiso para hacer eso.'
        end
    end

    def user_params
        params.require(:user).permit :name,
                                     :phone,
                                     :company,
                                     :newsletter,
                                     :edit_token
    end

    def new_user_params
        params.require(:user).permit :email,
                                     :name,
                                     :phone,
                                     :company,
                                     :newsletter,
                                     :auto_confirm
    end
end
