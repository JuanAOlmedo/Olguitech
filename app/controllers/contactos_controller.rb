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
        @user = User.find_by(user_params)

        if @user
            if @user.name && @user.phone && @user.company
                process_contact_for_existing_user
            else
                process_contact_for_incomplete_user
            end
        else
            process_contact_for_new_user
        end
    end

    private

    def contacto_params
        params.require(:contacto).permit(:message, interests_attributes: [:id, :record_type, :record_id])
    end

    def user_params
        params.require(:user).permit :email
    end

    def process_contact_for_new_user
        parameters = user_params
        parameters[:locale] = I18n.locale

        @user = User.new(parameters)

        @contacto = @user.contactos.new(message: contacto_params[:message])

        contacto_params[:interests_attributes].each_value do |interest|
            @contacto.interests.new(interest)
        end

        if @user.save && @contacto.save
            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def process_contact_for_existing_user
        @contacto = @user.contactos.new(message: contacto_params[:message])
        @contacto.interests.new(contacto_params[:interest_attributes])

        if @contacto.save
            @contacto.send_mail

            redirect_to "/#{I18n.locale}/contacto",
                        notice: I18n.t('contact.sent')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def process_contact_for_incomplete_user
        @contacto = @user.contactos.new(message: contacto_params[:message])
        @contacto.interests.new(contacto_params[:interest_attributes])

        if @contacto.save
            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end
end
