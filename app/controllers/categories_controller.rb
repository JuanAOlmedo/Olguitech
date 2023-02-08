# frozen_string_literal: true

class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /categories
    def index
        @categories = Category.all
    end

    # GET /categories/1
    def show
        @categories = Category.all

        @articles = @category.articles.published
        @projects = @category.projects.published
        @products = @category.products.published
    end

    # GET /categories/new
    def new
        @category = Category.new
    end

    # GET /categories/1/edit
    def edit; end

    # POST /categories
    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to @category, notice: 'Category was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /categories/1
    def update
        if @category.update(category_params)
            redirect_to @category, notice: 'Categoría actualizada exitosamente.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /categories/1
    def destroy
        @category.destroy

        redirect_to categories_url, notice: 'Categoría destruída exitosamente.', status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
        @category = Category.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
        params.require(:category)
              .permit(
                  :title,
                  :title2,
                  :description,
                  :description2,
                  { product_ids: [] },
                  { article_ids: [] },
                  { project_ids: [] },
                  :super_category_id,
                  :image
              )
    end
end
