# frozen_string_literal: true

class ContactosController < ApplicationController
    def index; end
    
    def new
        @contacto = Contacto.new
        @user = @contacto.user
        @contacto.interests.build
    end

    # Find or create a new user based on the email and create a new contact
    # for that user and update their locale
    def create
        @user = User.find_by(user_params) || User.new(user_params)
        @user.locale = I18n.locale
        @contacto = @user.contactos.new(contacto_params)

        if @user.name && @user.phone && @user.company
            process_contact
        else
            process_contact_for_incomplete_user
        end
    end

    private

    def contacto_params
        params.require(:contacto).permit(:message,
                                         interests_attributes: %i[id record_type record_id])
    end

    def user_params
        params.require(:user).permit :email
    end

    # If the contact saves successfully, send the user and the admin an email
    def process_contact
        if @contacto.save
            @contacto.send_mail

            redirect_to root_path,
                        notice: I18n.t('contact.sent')
        else
            render :new, status: :unprocessable_entity
        end
    end

    # If the user doesn't have all fields (name, phone company) filled,
    # take them to the edit_user path to fill them up
    def process_contact_for_incomplete_user
        if @user.save && @contacto.save
            @contacto.send_mail

            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end
end
