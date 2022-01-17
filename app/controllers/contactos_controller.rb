# frozen_string_literal: true

class ContactosController < ApplicationController
    def index; end

    def new
        @contacto = Contacto.new
        @user = @contacto.user
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
        params.require(:contacto).permit :preference, :preference2, :message
    end

    def user_params
        params.require(:user).permit :email
    end

    def process_contact_for_new_user
        parameters = user_params
        parameters[:locale] = I18n.locale

        @user = User.new(parameters)

        @contacto = @user.contactos.new(contacto_params)
        @contacto.preference = @contacto.preference.to_i
        @contacto.preference2 = @contacto.preference2.to_i

        if @user.save && @contacto.save
            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def process_contact_for_existing_user
        @contacto = @user.contactos.new(contacto_params)
        @contacto.preference = @contacto.preference.to_i
        @contacto.preference2 = @contacto.preference2.to_i

        if @contacto.save
            @contacto.send_mail

            redirect_to "/#{I18n.locale}/contacto",
                        notice: I18n.t('contact.sent')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def process_contact_for_incomplete_user
        @contacto = @user.contactos.new(contacto_params)
        @contacto.preference = @contacto.preference.to_i
        @contacto.preference2 = @contacto.preference2.to_i

        if @contacto.save
            session[:will_contact] = @contacto.id
            redirect_to edit_user_path(@user, edit_token: @user.edit_token),
                        notice: I18n.t('contact.first_time')
        else
            render :new, status: :unprocessable_entity
        end
    end
end
