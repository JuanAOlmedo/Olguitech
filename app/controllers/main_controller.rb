# frozen_string_literal: true

class MainController < ApplicationController
    def main
        @articles = Article.all.order(created_at: :desc)[0..3]
        @proyectos = Proyecto.all.order(created_at: :desc)[0..3]
        @products = Product.all.order(created_at: :desc)[0..3]

        @user = User.new
    end

    def subscribe
        @user = User.find_by(user_params) || User.new(user_params)

        @user.newsletter = true
        @user.locale = I18n.locale

        if @user.save
            redirect_to root_path, notice: t('thanks_for_subscribing')
        else
            redirect_to root_path, alert: t('valid_email'), status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit :email
    end
end
