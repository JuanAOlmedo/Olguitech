# frozen_string_literal: true

class MainController < ApplicationController
    def main
        @articles = Article.published.order(created_at: :desc).last 4
        @proyectos = Proyecto.published.order(created_at: :desc).last 4
        @products = Product.published.order(created_at: :desc).last 4

        @user = User.new
    end

    def subscribe
        existent_user = User.find_by(user_params)

        unless existent_user.nil?
            existent_user.update(newsletter: true) unless existent_user.newsletter
            redirect_to root_path,
                        notice: t('thanks_for_subscribing')
            return
        end

        @user = User.new user_params
        @user.newsletter = true

        if @user.save
            redirect_to root_path,
                        notice: t('thanks_for_subscribing')
        else
            redirect_to root_path,
                        alert: t('valid_email'),
                        status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit :email
    end
end
