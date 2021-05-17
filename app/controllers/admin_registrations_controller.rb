class AdminRegistrationsController < Devise::RegistrationsController
    before_action :authenticate_admin!, :redirect_unless_admin,  only: [:new, :create]
    skip_before_action :require_no_authentication

    def sign_up(resource_name, resource)
        true
    end
    def sign_up_params
        params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:admin).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
    
    def update
        self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
        prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    
        resource_updated = update_resource(resource, account_update_params)
        yield resource if block_given?
        if resource_updated
            set_flash_message_for_update(resource, prev_unconfirmed_email)
            bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
    
            respond_with resource, location: after_update_path_for(resource)
        else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
        end
    end
    
    def destroy 
        flash[:alert] = I18n.t("shared.cant_cancel")
        redirect_to root_path
    end

    private
    def redirect_unless_admin
        if !admin_signed_in?
            flash[:alert] = I18n.t("shared.admins")
            redirect_to root_path
        end
    end
end