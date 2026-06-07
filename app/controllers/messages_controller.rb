# frozen_string_literal: true

class CaptchaError < StandardError; end

class MessagesController < ApplicationController
    include Captcha
    include Throttle

    # POST /messages
    #      /contacto
    # Crea un mensaje para el usuario que se está contactando.
    # Incluye la validación del módulo Throttle y validación por CAPTCHA
    def create
        @user = set_user
        @message = @user.messages.build message_params
        @show_form = true

        # No hacer la consulta si se hicieron muchas en poco tiempo
        if block_contact?
            @message.errors.add :base, message: I18n.t('contact.error_throttle_html')

            render 'main/contacto', status: :unprocessable_entity
        elsif check_recaptcha(@user) && @user.save
            increment_contact_count

            redirect_user
        else
            render 'main/contacto', status: :unprocessable_entity
        end
    end

    private

    def message_params
        params.require(:message).permit :content
    end

    def user_params
        params.require(:user).permit :email, :name
    end

    # Crea o busca un usuario con el mail pasado por parámetro,
    # actualiza su nombre y locale.
    def set_user
        user = User.find_or_initialize_by(email: user_params[:email])
        user.name = user_params[:name] unless user_params[:name].blank?
        user.locale = I18n.locale

        user
    end

    # Redirige al usuario. Cuando al usuario le falta información por completar, se va a la
    # página de editar usuario para que la pueda llenar.
    def redirect_user
        if @user.name && @user.phone && @user.company
            redirect_to root_path, notice: I18n.t('contact.sent')
        else
            redirect_to edit_user_path(@user, edit_token: @user.edit_token, contact: true),
                        notice: I18n.t('contact.first_time')
        end
    end
end
