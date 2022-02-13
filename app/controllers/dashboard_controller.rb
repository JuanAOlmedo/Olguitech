class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def edit; end

    def editor
        @articles = Article.published
        @proyectos = Proyecto.published
        @productos = Product.published

        @article_drafts = Article.drafted
        @proyecto_drafts = Proyecto.drafted
        @product_drafts = Product.drafted
    end

    def trash
        @articles = Article.trashed
        @proyectos = Proyecto.trashed
        @productos = Product.trashed

        @trash = true
    end
end
