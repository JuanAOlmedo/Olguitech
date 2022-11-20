# frozen_string_literal: true

class ContactosController < ApplicationController
    def index; end

    def new
        @contacto = Contacto.new
        @user = @contacto.user
        @contacto.interests.build
    end

    def update; end

    def create
        @user = User.find_by(user_params) || User.new(user_params)

        @contacto = @user.contactos.new(message: contacto_params[:message])
        contacto_params[:interests_attributes].each_value do |interest|
            @contacto.interests.new(interest)
        end

        if @user.name && @user.phone && @user.company
            process_contact
        else
            process_contact_for_incomplete_user
        end

        @user.update!(locale: I18n.locale)
    end

    private

    def contacto_params
        params.require(:contacto).permit(:message, interests_attributes: [:id, :record_type, :record_id])
    end

    def user_params
        params.require(:user).permit :email
    end

    def process_contact
        if @contacto.save
            @contacto.send_mail

            redirect_to root_path,
                        notice: I18n.t('contact.sent')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def process_contact_for_incomplete_user
        if @contacto.save
            @contacto.send_mail

            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end
end
