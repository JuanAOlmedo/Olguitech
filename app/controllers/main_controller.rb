class MainController < ApplicationController
    def main
        @articles = Article.all.order(created_at: :desc)[0..3]
        @proyectos = Proyecto.all.order(created_at: :desc)[0..3]
        @products = Product.all.order(created_at: :desc)[0..3]

        @user = User.new
    end

    def subscribe
        existent_user = User.find_by(user_params)

        unless existent_user.nil?
            existent_user.update(newsletter: true) unless existent_user.newsletter
            redirect_to root_path,
                        notice: 'Muchas gracias por suscribirte a nuestra newsletter!'
            return
        end

        @user = User.new user_params
        @user.newsletter = true

        if @user.save
            redirect_to root_path,
                        notice: 'Muchas gracias por suscribirte a nuestra newsletter!'
        else
            redirect_to root_path,
                        alert: 'Por favor danos un mail válido',
                        status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit :email
    end
end
