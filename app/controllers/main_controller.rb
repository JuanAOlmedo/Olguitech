class MainController < ApplicationController
    def main
        @articles = Article.all.order(created_at: :desc)[0..3]
        @proyectos = Proyecto.all.order(created_at: :desc)[0..3]
        @products = Product.all.order(created_at: :desc)[0..3]

        @user = User.new
    end

    def subscribe
        @user = User.new user_params
        @user.newsletter = true

        if @user.save
            main
            redirect_to root_path, notice: "Muchas gracias por suscribirte a nuestra newsletter!"
        else
            if @user.errors.any? && @user.errors.count == 1 && @user.errors.first.type == :taken
                main
                redirect_to root_path, notice: "Ya estabas suscrito a nuestra newsletter"
            else
                main
                redirect_to root_path, alert: "Por favor danos un mail válido"
            end
        end
    end

    private

    def user_params
        params.require(:user).permit :email
    end
end
