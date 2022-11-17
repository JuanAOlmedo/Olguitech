# frozen_string_literal: true

class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /categories or /categories.json
    def index
        @categories = Category.all
    end

    # GET /categories/1 or /categories/1.json
    def show
        @categories = Category.all
    end

    # GET /categories/new
    def new
        @category = Category.new
    end

    # GET /categories/1/edit
    def edit; end

    # POST /categories or /categories.json
    def create
        @category = Category.new(category_params)

        respond_to do |format|
            if @category.save
                format.html do
                    redirect_to @category,
                                notice: 'Category was successfully created.'
                end
                format.json do
                    render :show, status: :created, location: @category
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @category.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /categories/1 or /categories/1.json
    def update
        respond_to do |format|
            if @category.update(category_params)
                format.html do
                    redirect_to @category,
                                notice: 'Categoría actualizada exitosamente.'
                end
                format.json { render :show, status: :ok, location: @category }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @category.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /categories/1 or /categories/1.json
    def destroy
        @category.destroy
        respond_to do |format|
            format.html do
                redirect_to categories_url,
                            notice: 'Categoría destruída exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
        @category = Category.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
        params
            .require(:category)
            .permit(
                :title,
                :title2,
                :description,
                :description2,
                { product_ids: [] },
                { article_ids: [] },
                { project_ids: [] },
                :image
            )
    end
end
