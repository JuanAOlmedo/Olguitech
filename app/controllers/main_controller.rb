class MainController < ApplicationController
    def main
        @articles = Article.all.order(created_at: :desc)[0..3]
        @proyectos = Proyecto.all.order(created_at: :desc)[0..3]
        @products = Product.all.order(created_at: :desc)[0..3]

        @user = User.new
    end
end
