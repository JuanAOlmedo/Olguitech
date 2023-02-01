# frozen_string_literal: true

class DashboardController < ApplicationController
    before_action :authenticate_admin!

    # GET /dashboard/edit
    def edit; end

    # GET /dashboard/ or /dashboard/articles
    def articles
        @articles = Article.published
        @projects = Project.published
        @products = Product.published

        @article_drafts = Article.drafted
        @project_drafts = Project.drafted
        @product_drafts = Product.drafted
    end

    # GET /dashboard/categories
    def categories
        @super_categories =
            SuperCategory.all.includes(dashboard_categories: %i[dashboard_articles dashboard_products dashboard_projects])
    end

    # GET /dashboard/newsletters
    def newsletters
        @newsletters = Newsletter.sent
        @newsletter_drafts = Newsletter.drafted
    end

    # GET /dashboard/trash
    def trash
        @articles = Article.trashed
        @projects = Project.trashed
        @products = Product.trashed

        @trash = true
    end

    # GET /dashboard/users
    def users; end
end
