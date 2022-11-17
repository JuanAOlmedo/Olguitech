# frozen_string_literal: true

class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def edit; end

    def articles
        @articles = Article.published
        @projects = Project.published
        @products = Product.published

        @article_drafts = Article.drafted
        @project_drafts = Project.drafted
        @product_drafts = Product.drafted
    end

    def categories
        @categories = Category.all
    end

    def newsletters
        @newsletters = Newsletter.sent
        @newsletter_drafts = Newsletter.drafted
    end

    def trash
        @articles = Article.trashed
        @projects = Project.trashed
        @products = Product.trashed

        @trash = true
    end

    def users; end
end
