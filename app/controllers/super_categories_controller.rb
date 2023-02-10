# frozen_string_literal: true

class SuperCategoriesController < ApplicationController
    before_action :set_super_category, only: %i[edit update destroy]
    before_action :authenticate_admin!

    # GET /super_categories/new
    def new
        @super_category = SuperCategory.new
    end

    # GET /super_categories/1/edit
    def edit; end

    # POST /super_categories
    def create
        @super_category = SuperCategory.new(super_category_params)

        if @super_category.save
            redirect_to "/#{I18n.locale}/dashboard/categories"
        else
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /super_categories/1
    def update
        if @super_category.update(super_category_params)
            redirect_to "/#{I18n.locale}/dashboard/categories"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /super_categories/1
    def destroy
        @super_category.destroy

        redirect_to "/#{I18n.locale}/dashboard/categories"
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_super_category
        @super_category = SuperCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def super_category_params
        params.require(:super_category).permit :title, :title2, { category_ids: [] }
    end
end
