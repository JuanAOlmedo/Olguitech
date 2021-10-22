class UsersController < ApplicationController
    before_action :authenticate_admin!, :redirect_unless_admin, only: [:index]

    def index
        @users = User.all
        @contacted = User.includes(:contactos).where.not(contactos: { id: nil })
    end

    def unsubscribe
        @user = User.find_by(newsletter_token: params[:newsletter_token])

        if @user
            @user.update!(newsletter: false)

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
end
