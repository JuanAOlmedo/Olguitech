class MainController < ApplicationController
    def main
        @articles = Article.all.order(created_at: :desc)[0..3]
        @proyectos = Proyecto.all.order(created_at: :desc)[0..3]
    end
end
