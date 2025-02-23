# frozen_string_literal: true

class MessagesController < ApplicationController
    invisible_captcha only: [:create]

    # Find or create a new user based on the email, create a new message
    # for that user and update their locale
    def create
        @user = User.find_by(user_params) || User.new(user_params)
        @message = @user.messages.new message_params
        @user.locale = I18n.locale

        if @message.save && @user.save
            @message.send_mail

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
        params.require(:user).permit :email
    end

    # Redirect the user to the appropriate page based on their status
    # Redirects to root_path if all fields are filled, otherwise redirects to edit_user_path
    def redirect_user
        if @user.name && @user.phone && @user.company
            redirect_to root_path, notice: I18n.t('contact.sent')
        else
            redirect_to edit_user_path(@user, edit_token: @user.edit_token, contact: true),
                        notice: I18n.t('contact.first_time')
        end
    end
end
