# frozen_string_literal: true

class MessagesController < ApplicationController
    # Find or create a new user based on the email, create a new message
    # for that user and update their locale
    # POST /messages
    def create
        @user = User.find_or_initialize_by(email: user_params[:email])
        @user.name = user_params[:name] unless user_params[:name].blank?
        @user.locale = I18n.locale

        @message = @user.messages.build message_params

        validate_cloudflare_turnstile unless Rails.env.test?

        @user.save!

        redirect_user
    rescue RailsCloudflareTurnstile::Forbidden
        @user.errors.add(:base, I18n.t('contact.captcha_failed'))
        render 'main/contacto', status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid
        render 'main/contacto', status: :unprocessable_entity
    end

    private

    def message_params
        params.require(:message).permit :content
    end

    def user_params
        params.require(:user).permit :email, :name
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
