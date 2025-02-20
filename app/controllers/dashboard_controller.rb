# frozen_string_literal: true

class DashboardController < ApplicationController
    before_action :authenticate_admin!

    # GET /dashboard/edit
    def edit; end

    # GET /dashboard/ or /dashboard/articles
    def articles
        @solutions = Solution.published
        @projects = Project.published
        @products = Product.published

        @solution_drafts = Solution.drafted
        @project_drafts = Project.drafted
        @product_drafts = Product.drafted
    end

    # GET /dashboard/categories
    def categories
        @uncategorized = [Solution.where.missing(:categories),
                          Product.where.missing(:categories),
                          Project.where.missing(:categories)].flatten
        @unsupercategorized =
            Category.select(:id, :title, :super_category_id, :slug).includes(:dashboard_solutions,
                                                                             :dashboard_products, :dashboard_projects).where super_category_id: nil
        @super_categories =
            SuperCategory.all.includes(dashboard_categories: %i[dashboard_solutions
                                                                dashboard_products dashboard_projects])
    end

    # GET /dashboard/newsletters
    def newsletters
        @newsletters = Newsletter.sent
        @newsletter_drafts = Newsletter.drafted
    end

    # GET /dashboard/trash
    def trash
        @solutions = Solution.trashed
        @projects = Project.trashed
        @products = Product.trashed

        @trash = true
    end

    # GET /dashboard/users
    def users; end
end
