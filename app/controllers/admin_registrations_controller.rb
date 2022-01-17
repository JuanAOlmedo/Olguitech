# frozen_string_literal: true

class AdminRegistrationsController < Devise::RegistrationsController
    before_action :authenticate_admin!,
                  :redirect_unless_admin,
                  only: %i[new create]
    skip_before_action :require_no_authentication

    def destroy
        flash[:alert] = I18n.t('shared.cant_cancel')
        redirect_to root_path
    end

    private

    def redirect_unless_admin
        return if admin_signed_in?

        flash[:alert] = I18n.t('shared.admins')
        redirect_to root_path
    end

    def sign_up_params
        params.require(:admin)
              .permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:admin)
              .permit(
                  :name,
                  :email,
                  :password,
                  :password_confirmation,
                  :current_password
              )
    end
end
