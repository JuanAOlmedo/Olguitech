class RegistrationsController < Devise::RegistrationsController 
    def index
    end

    private 

    def sign_up_params
        params.require(:user).permit(:name, :email, :phone, :company, :password, :password_confirmation, :newsletter)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :phone, :company, :password, :password_confirmation, :current_password, :newsletter)
    end
end