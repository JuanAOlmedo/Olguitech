
class ContactosController < ApplicationController
    def index
        @contacto = Contacto.new
        @user = @contacto.user
    end

    # Find or create a new user based on the email and create a new contact
    # for that user and update their locale
    def create
        @user = User.find_by(user_params) || User.new(user_params)
        @user.locale = I18n.locale
        @contacto = @user.contactos.new(contacto_params)

        unless verify_hcaptcha(model: @contacto)
            render(:index, status: :unprocessable_entity) and return
        end


        if @user.name && @user.phone && @user.company
            process_contact
        else
            process_contact_for_incomplete_user
        end
    end

    private

    def contacto_params
        params.require(:contacto).permit :message
    end

    def user_params
        params.require(:user).permit :email
    end

    # If the contact saves successfully, send the user and the admin an email
    def process_contact
        if @contacto.save
            @contacto.send_mail

            redirect_to root_path, notice: I18n.t('contact.sent')
        else
            render :index, status: :unprocessable_entity
        end
    end

    # If the user doesn't have all fields (name, phone company) filled, take them to
    # the edit_user path to fill them up. Add a contact parameter so that the views
    # can show information according to the context
    def process_contact_for_incomplete_user
        if @user.save && @contacto.save
            @contacto.send_mail

            redirect_to edit_user_path(@user, edit_token: @user.edit_token, contact: true),
                        notice: I18n.t('contact.first_time')
        else
            render :index, status: :unprocessable_entity
        end
    end
end
