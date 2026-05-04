# frozen_string_literal: true

class DashboardController < ApplicationController
    before_action :authenticate_admin!

    # GET /dashboard/edit
    def edit; end

    # GET /dashboard/ or /dashboard/articles
    def articles
        @solutions = get_articles(Solution, published: true)
        @projects = get_articles(Project, published: true)
        @products = get_articles(Product, published: true)

        @solution_drafts = get_articles(Solution, drafted: true)
        @project_drafts = get_articles(Project, drafted: true)
        @product_drafts = get_articles(Product, drafted: true)
    end

    # GET /dashboard/categories
    def categories
        @categories = true # Para determinar path en las views

        # Artículos sin categorías
        @uncategorized = [Solution, Project, Product].map do |model|
            get_articles(model, uncategorized: true)
        end
        @uncategorized.flatten!

        # Categorías sin supercategorías, incluyendo sus artículos
        @unsupercategorized = Category.includes_dashboard_articles
                                      .unsupercategorized
                                      .load

        # Super categorías, incluyendo categorías y sus respectivos artículos
        @super_categories = SuperCategory.includes_dashboard_categories.load
    end

    # GET /dashboard/newsletters
    def newsletters
        @newsletters = Newsletter.sent
        @newsletter_drafts = Newsletter.drafted
    end

    # GET /dashboard/trash
    def trash
        @solutions = get_articles(Solution, trashed: true)
        @projects = get_articles(Project, trashed: true)
        @products = get_articles(Product, trashed: true)

        @trash = true
    end

    # GET /dashboard/users
    def users; end

    private

    def get_articles(model, uncategorized: false, published: false, drafted: false, trashed: false)
        model = model.uncategorized if uncategorized
        model = model.published if published
        model = model.drafted if drafted
        model = model.trashed if trashed
        model.includes_image
             .select(model.fields_for_dashboard)
             .uncategorized
             .load
    end
end
