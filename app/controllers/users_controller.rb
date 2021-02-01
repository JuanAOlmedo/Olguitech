class UsersController < ApplicationController 
    before_action :authenticate_admin!, :redirect_unless_admin,  only: [:index]

    def index
        @users = User.all
    end

    private
    def redirect_unless_admin
        if !admin_signed_in?
            flash[:alert] = "Solo administradores pueden hacer eso"
            redirect_to root_path
        end
    end
  end
  