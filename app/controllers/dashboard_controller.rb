# frozen_string_literal: true

class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def edit; end

    def articles
        @articles = Article.published
        @proyectos = Proyecto.published
        @products = Product.published

        @article_drafts = Article.drafted
        @proyecto_drafts = Proyecto.drafted
        @product_drafts = Product.drafted
    end

    def categories
        @categories = Category.all
    end

    def trash
        @articles = Article.trashed
        @proyectos = Proyecto.trashed
        @products = Product.trashed

        @trash = true
    end

    def users; end
end
