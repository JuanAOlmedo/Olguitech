# frozen_string_literal: true

class CaptchaError < StandardError; end

class MessagesController < ApplicationController
    include Captcha

    before_action :check_contact_count, only: :create

    # Find or create a new user based on the email, create a new message
    # for that user and update their locale
    # POST /messages
    #      /contacto
    def create
        @user = set_user
        @message = @user.messages.build message_params

        if check_recaptcha(@user) && @user.save
            increment_contact_count

            redirect_user
        else
            @show_form = true
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

    def set_user
        user = User.find_or_initialize_by(email: user_params[:email])
        user.name = user_params[:name] unless user_params[:name].blank?
        user.locale = I18n.locale

        user
    end

    def check_contact_count
        render 'main/contacto', status: :unprocessable_entity if contact_count >= 10
    end

    def contact_count
        bucket = Time.now.to_i / 1.day.to_i

        Rails.cache.fetch("contactos_#{bucket}", expires_in: 1.day) { 0 }
    end

    def increment_contact_count
        bucket = Time.now.to_i / 1.day.to_i

        Rails.cache.increment("contactos_#{bucket}")
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
